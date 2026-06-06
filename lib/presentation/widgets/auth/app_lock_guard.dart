import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_design.dart';
import '../../../domain/repositories/repositories.dart';
import '../../blocs/auth/auth_bloc.dart';

class AppLockGuard extends StatefulWidget {
  final Widget child;
  const AppLockGuard({super.key, required this.child});

  @override
  State<AppLockGuard> createState() => _AppLockGuardState();
}

class _AppLockGuardState extends State<AppLockGuard> {
  bool _isUnlocked = false;
  bool _isAuthenticating = false;
  bool _wasUnauthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkLock();
  }

  Future<void> _checkLock() async {
    final state = context.read<AuthBloc>().state;
    final user = state.whenOrNull(authenticated: (u) => u);
    
    if (user != null && user.isAppLockEnabled) {
      _authenticate();
    } else {
      if (state.maybeWhen(unauthenticated: () => true, orElse: () => false)) {
        _wasUnauthenticated = true;
      }
      setState(() {
        _isUnlocked = true;
      });
    }
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating) return;
    setState(() {
      _isAuthenticating = true;
    });

    try {
      final localAuth = getIt<LocalAuthentication>();
      final canAuthenticate = await localAuth.canCheckBiometrics || await localAuth.isDeviceSupported();
      
      if (canAuthenticate) {
        final didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Please authenticate to access Every Rupee',
          persistAcrossBackgrounding: true,
        );
        
        if (mounted && didAuthenticate) {
          setState(() {
            _isUnlocked = true;
            _isAuthenticating = false;
          });
        } else {
          setState(() {
            _isAuthenticating = false;
          });
        }
      } else {
        // Fallback if device doesn't support biometrics but lock was somehow enabled
        setState(() {
          _isUnlocked = true;
          _isAuthenticating = false;
        });
      }
    } catch (e) {
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  Future<void> _promptEnableAppLock(String uid) async {
    final localAuth = getIt<LocalAuthentication>();
    final canAuthenticate = await localAuth.canCheckBiometrics || await localAuth.isDeviceSupported();
    
    if (!canAuthenticate || !mounted) {
      setState(() {
        _isUnlocked = true;
      });
      return;
    }

    final shouldEnable = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppDesign.surface,
        title: Text('Enable App Lock?', style: AppDesign.headlineMedium),
        content: Text('Would you like to use fingerprint or face unlock to secure your Every Rupee data?', style: AppDesign.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Not Now', style: TextStyle(color: AppDesign.subtle)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppDesign.primary),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Enable'),
          ),
        ],
      ),
    );

    if (shouldEnable == true) {
      final didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to enable App Lock',
        biometricOnly: false,
      );
      if (didAuthenticate) {
        final repo = getIt<AuthRepository>();
        await repo.updateAppLockStatus(uid, true);
      }
    }

    if (mounted) {
      setState(() {
        _isUnlocked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          unauthenticated: () {
            _wasUnauthenticated = true;
            setState(() {
              _isUnlocked = true;
            });
          },
          authenticated: (u) {
            if (u.isAppLockEnabled && !_isUnlocked) {
              _authenticate();
            } else if (!u.isAppLockEnabled) {
              if (_wasUnauthenticated) {
                _wasUnauthenticated = false;
                _promptEnableAppLock(u.uid);
              } else {
                setState(() {
                  _isUnlocked = true;
                });
              }
            }
            _wasUnauthenticated = false;
          },
          orElse: () {},
        );
      },
      child: _isUnlocked 
        ? widget.child 
        : Scaffold(
            backgroundColor: AppDesign.background,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_rounded, size: 64, color: AppDesign.primary),
                  const SizedBox(height: AppDesign.s24),
                  Text('App Locked', style: AppDesign.headlineMedium),
                  const SizedBox(height: AppDesign.s32),
                  if (!_isAuthenticating)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppDesign.primary),
                      onPressed: _authenticate,
                      child: const Text('Unlock'),
                    )
                  else
                    const CircularProgressIndicator(color: AppDesign.primary),
                ],
              ),
            ),
          ),
    );
  }
}
