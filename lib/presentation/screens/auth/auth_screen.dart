import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zb_budget/core/router/app_router.dart';
import 'package:zb_budget/core/utils/app_logger.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_design.dart';
import '../../blocs/auth/auth_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const __Body();
  }
}

class __Body extends StatefulWidget {
  const __Body();

  @override
  State<__Body> createState() => __BodyState();
}

class __BodyState extends State<__Body> with SingleTickerProviderStateMixin {
  late final TabController _tab;
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
    _tab.addListener(_tabListner);
  }

  int selectedTab = 0;
  void _tabListner() {
    setState(() {
      selectedTab = _tab.index;
    });
  }

  @override
  void dispose() {
    _tab.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit(AuthBloc bloc) {
    FocusScope.of(context).unfocus();
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;
    if (_tab.index == 0) {
      bloc.add(AuthEvent.signInWithEmail(email: email, password: password));
    } else {
      bloc.add(AuthEvent.signUpWithEmail(email: email, password: password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesign.background,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            AppLogger.i('APP STATE: $state');
            state.maybeWhen(
              authenticated: (user) {
                AppLogger.i('APP STATE: $user');
                if (!user.onboardingComplete && !user.budgetSetupComplete) {
                  context.go(AppRoutes.onboarding);
                } else {
                  context.go(AppRoutes.dashboard);
                }
              },
              failure: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: AppDesign.error,
                  ),
                );
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            final bloc = context.read<AuthBloc>();
            final isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDesign.s24, vertical: AppDesign.s40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDesign.s32),

                  // ── Brand ──────────────────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.appLogo, height: 120),
                      const SizedBox(width: AppDesign.s12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Every Rupee', style: AppDesign.displayLarge),
                            const SizedBox(height: AppDesign.s4),
                            Text(
                              'Zero-based. Zero surprises.',
                              style: AppDesign.bodyMedium
                                  .copyWith(color: AppDesign.subtle),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDesign.s40),

                  // ── Tab selector ───────────────────────────────────────
                  Container(
                    height: 44,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppDesign.surfaceHigh,
                      borderRadius: AppDesign.roundMedium,
                    ),
                    padding: EdgeInsets.zero,
                    child: TabBar(
                      controller: _tab,
                      dividerColor: Colors.transparent,
                      indicator: const BoxDecoration(
                        color: AppDesign.primary,
                        borderRadius: AppDesign.roundMedium,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: AppDesign.subtle,
                      labelStyle: AppDesign.labelLarge,
                      tabAlignment: TabAlignment.fill,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(text: 'Sign In'),
                        Tab(text: 'Sign Up'),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDesign.s32),

                  // ── Form ───────────────────────────────────────────────
                  TextField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: AppDesign.bodyMedium
                        .copyWith(color: AppDesign.onBackground),
                    decoration: const InputDecoration(
                      hintText: 'Email address',
                      prefixIcon: Icon(Icons.mail_outline_rounded,
                          color: AppDesign.subtle),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                  ),
                  const SizedBox(height: AppDesign.s12),
                  TextField(
                    controller: _passwordCtrl,
                    obscureText: _obscure,
                    style: AppDesign.bodyMedium
                        .copyWith(color: AppDesign.onBackground),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline_rounded,
                          color: AppDesign.subtle),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppDesign.subtle,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDesign.s24),

                  // ── Primary CTA ────────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => _submit(bloc),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : Text(
                              selectedTab == 0 ? 'Sign In' : 'Create Account'),
                    ),
                  ),
                  const SizedBox(height: AppDesign.s16),

                  // ── Divider ────────────────────────────────────────────
                  Row(children: [
                    const Expanded(child: Divider(color: AppDesign.divider)),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppDesign.s12),
                      child: Text('or', style: AppDesign.bodySmall),
                    ),
                    const Expanded(child: Divider(color: AppDesign.divider)),
                  ]),
                  const SizedBox(height: AppDesign.s16),

                  // ── Google Sign-In ─────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppDesign.onBackground,
                        side: const BorderSide(
                            color: AppDesign.divider, width: 1),
                        padding:
                            const EdgeInsets.symmetric(vertical: AppDesign.s16),
                        shape: const RoundedRectangleBorder(
                            borderRadius: AppDesign.roundMedium),
                      ),
                      onPressed: isLoading
                          ? null
                          : () => bloc.add(const AuthEvent.signInWithGoogle()),
                      icon: const Icon(Icons.g_mobiledata_rounded, size: 22),
                      label: const Text('Continue with Google'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
