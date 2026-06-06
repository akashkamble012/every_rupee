import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_design.dart';
import '../../blocs/auth/auth_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _ctrl = PageController();
  int _page = 0;

  static const _pages = [
    _OnboardPage(
      icon: Icons.account_balance_wallet_rounded,
      title: 'Give Every Rupee a Job',
      body:
          'Assign 100% of your net income to categories before the month begins. Nothing floats unassigned.',
      color: AppDesign.primary,
    ),
    _OnboardPage(
      icon: Icons.event_repeat_rounded,
      title: 'Caps Expire Automatically',
      body:
          'Set an activeUntil date on any cap — like a 6-month EMI — and it disappears from your budget on the right date.',
      color: AppDesign.credit,
    ),
    _OnboardPage(
      icon: Icons.sms_rounded,
      title: 'SMS Auto-Capture',
      body:
          'Bank debit SMS messages are intercepted, parsed, and logged silently — even when the app is closed.',
      color: AppDesign.warning,
    ),
    _OnboardPage(
      icon: Icons.trending_up_rounded,
      title: 'Surplus = Peace of Mind',
      body:
          'The dashboard always shows you: money in, money assigned, money spent. The gap is your freedom.',
      color: AppDesign.success,
    ),
  ];

  void _next(BuildContext context) async {
    if (_page < _pages.length - 1) {
      _ctrl.nextPage(
          duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
    } else {
      // Mark onboarding complete and proceed
      context.read<AuthBloc>().add(const AuthEvent.markOnboardingComplete());
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesign.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Page view ──────────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _ctrl,
                onPageChanged: (i) => setState(() => _page = i),
                itemCount: _pages.length,
                itemBuilder: (_, i) => _pages[i],
              ),
            ),

            // ── Dots ───────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  height: 6,
                  width: _page == i ? 20 : 6,
                  decoration: BoxDecoration(
                    color: _page == i ? _pages[i].color : AppDesign.divider,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDesign.s16),

            // ── CTA ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppDesign.s24, 0, AppDesign.s24, AppDesign.s32),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _next(context),
                  child: Text(
                      _page < _pages.length - 1 ? 'Next' : 'Set Up My Budget'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Individual onboarding page ─────────────────────────────────────────────

class _OnboardPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final Color color;

  const _OnboardPage({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDesign.s32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 48, color: color),
          ),
          const SizedBox(height: AppDesign.s32),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppDesign.displayMedium,
          ),
          const SizedBox(height: AppDesign.s16),
          Text(
            body,
            textAlign: TextAlign.center,
            style: AppDesign.bodyMedium.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}
