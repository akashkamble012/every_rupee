import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isPromptingAppLock = false;
  String? _uidForPrompt;

  @override
  void initState() {
    super.initState();
    _checkLock();
  }

  Future<void> _checkLock() async {
    final state = context.read<AuthBloc>().state;
    
    state.whenOrNull(
      authenticated: (u) {
        if (u.isAppLockEnabled) {
          _authenticate();
        } else {
          _promptEnableAppLock(u.uid);
        }
      },
      unauthenticated: () {
        setState(() {
          _isUnlocked = true;
        });
      },
    );
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating) return;
    setState(() {
      _isAuthenticating = true;
    });

    try {
      // Wait briefly for the UI to fully attach before launching the system dialog.
      // Calling this too early during app launch can cause the plugin to hang indefinitely on Android.
      await Future.delayed(const Duration(milliseconds: 300));

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

    // Force show the prompt UI instead of using showDialog (which lacks a Navigator here)
    setState(() {
      _isPromptingAppLock = true;
      _uidForPrompt = uid;
    });
  }

  Future<void> _handlePromptDecision(bool enable) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasPromptedAppLock', true);

    if (enable && _uidForPrompt != null) {
      final localAuth = getIt<LocalAuthentication>();
      final didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to enable App Lock',
        biometricOnly: false,
      );
      if (didAuthenticate) {
        final repo = getIt<AuthRepository>();
        await repo.updateAppLockStatus(_uidForPrompt!, true);
      }
    }

    if (mounted) {
      setState(() {
        _isPromptingAppLock = false;
        _isUnlocked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          unauthenticated: () {
            setState(() {
              _isUnlocked = true;
            });
          },
          authenticated: (u) {
            if (u.isAppLockEnabled) {
              if (!_isUnlocked) {
                _authenticate();
              }
            } else {
              _promptEnableAppLock(u.uid);
            }
          },
        );
      },
      child: _isUnlocked 
        ? widget.child 
        : Scaffold(
            backgroundColor: AppDesign.background,
            body: Center(
              child: _isPromptingAppLock
                ? Padding(
                    padding: const EdgeInsets.all(AppDesign.s24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.fingerprint, size: 64, color: AppDesign.primary),
                        const SizedBox(height: AppDesign.s24),
                        Text('Enable App Lock?', style: AppDesign.headlineMedium),
                        const SizedBox(height: AppDesign.s16),
                        Text(
                          'Would you like to use fingerprint or face unlock to secure your Every Rupee data?',
                          style: AppDesign.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppDesign.s32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => _handlePromptDecision(false),
                              child: const Text('Not Now', style: TextStyle(color: AppDesign.subtle)),
                            ),
                            const SizedBox(width: AppDesign.s16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: AppDesign.primary),
                              onPressed: () => _handlePromptDecision(true),
                              child: const Text('Enable'),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Column(
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
