import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_design.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          unauthenticated: () {
            setState(() {
              _isUnlocked = true;
            });
          },
          authenticated: (u) {
            if (u.isAppLockEnabled && !_isUnlocked) {
              _authenticate();
            } else if (!u.isAppLockEnabled) {
              setState(() {
                _isUnlocked = true;
              });
            }
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
