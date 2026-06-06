import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_design.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../blocs/auth/auth_bloc.dart';

class BudgetSetupScreen extends StatefulWidget {
  const BudgetSetupScreen({super.key});

  @override
  State<BudgetSetupScreen> createState() => _BudgetSetupScreenState();
}

class _BudgetSetupScreenState extends State<BudgetSetupScreen> {
  static const _uuid = Uuid();

  final _incomeCtrl = TextEditingController();
  final _incomeName = TextEditingController(text: 'Primary Salary');
  final _categories = <_CategoryDraft>[];
  bool _saving = false;

  double get _netIncome =>
      double.tryParse(_incomeCtrl.text.replaceAll(',', '')) ?? 0.0;

  double get _totalAllocated => _categories.fold(
      0.0, (s, c) => s + (double.tryParse(c.capCtrl.text) ?? 0.0));

  double get _unassigned => _netIncome - _totalAllocated;
  bool get _isOverAllocated => _totalAllocated > _netIncome;

  void _addCategory() {
    setState(() => _categories.add(_CategoryDraft()));
  }

  void _removeCategory(int index) {
    setState(() {
      _categories[index].dispose();
      _categories.removeAt(index);
    });
  }

  Future<void> _save(BuildContext context) async {
    if (_netIncome <= 0) {
      _showError('Enter a valid net income.');
      return;
    }
    if (_isOverAllocated) {
      _showError('Total allocation exceeds net income.');
      return;
    }
    if (_categories.isEmpty) {
      _showError('Add at least one budget category.');
      return;
    }

    setState(() => _saving = true);

    final now = DateTime.now();
    final monthStart = startOfMonth(now);

    // Save income source
    final incomeRepo = getIt<IncomeRepository>();
    await incomeRepo.saveIncomeSource(IncomeSourceEntity(
      id: _uuid.v4(),
      name: _incomeName.text.trim().isEmpty
          ? 'Primary Salary'
          : _incomeName.text.trim(),
      amount: _netIncome,
      effectiveFrom: monthStart,
      lastModifiedAt: now,
    ));

    // Save categories
    final catRepo = getIt<BudgetCategoryRepository>();
    for (final draft in _categories) {
      final name = draft.nameCtrl.text.trim();
      final cap = double.tryParse(draft.capCtrl.text) ?? 0.0;
      if (name.isEmpty || cap <= 0) continue;
      await catRepo.saveCategory(BudgetCategoryEntity(
        id: _uuid.v4(),
        name: name,
        cap: cap,
        effectiveFrom: monthStart,
        lastModifiedAt: now,
      ));
    }
    
    if(!context.mounted) return;
    // Mark budget setup complete
    context.read<AuthBloc>().add(const AuthEvent.markBudgetSetupComplete());
  
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppDesign.error),
    );
  }

  @override
  void dispose() {
    _incomeCtrl.dispose();
    _incomeName.dispose();
    for (final c in _categories) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesign.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Sticky math tracker ────────────────────────────────────
            _StickyTracker(
              netIncome: _netIncome,
              totalAllocated: _totalAllocated,
              unassigned: _unassigned,
              isOver: _isOverAllocated,
            ),

            // ── Form ───────────────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppDesign.s16),
                children: [
                  Text('Master Plan Setup', style: AppDesign.headlineMedium),
                  const SizedBox(height: AppDesign.s4),
                  Text(
                    'Assign every rupee before the month begins.',
                    style: AppDesign.bodySmall,
                  ),
                  const SizedBox(height: AppDesign.s24),

                  // Income
                  Text('Net Income', style: AppDesign.titleMedium),
                  const SizedBox(height: AppDesign.s8),
                  TextField(
                    controller: _incomeName,
                    style: AppDesign.bodyMedium
                        .copyWith(color: AppDesign.onBackground),
                    decoration:
                        const InputDecoration(hintText: 'Income source name'),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AppDesign.s8),
                  TextField(
                    controller: _incomeCtrl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style:
                        AppDesign.amountLarge.copyWith(color: AppDesign.credit),
                    decoration:
                        const InputDecoration(hintText: '0', prefixText: '₹ '),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AppDesign.s32),

                  // Categories
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Budget Caps', style: AppDesign.titleMedium),
                      TextButton.icon(
                        onPressed: _addCategory,
                        icon: const Icon(Icons.add_rounded,
                            size: 18, color: AppDesign.primary),
                        label: const Text('Add',
                            style: TextStyle(color: AppDesign.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDesign.s8),

                  ..._categories.asMap().entries.map((e) => _CategoryRow(
                        draft: e.value,
                        onRemove: () => _removeCategory(e.key),
                        onChanged: () => setState(() {}),
                      )),

                  if (_categories.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppDesign.s24),
                        child: Text(
                          'Tap "Add" to create your first budget category',
                          textAlign: TextAlign.center,
                          style: AppDesign.bodySmall,
                        ),
                      ),
                    ),

                  const SizedBox(height: AppDesign.s32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saving || _isOverAllocated
                          ? null
                          : () => _save(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isOverAllocated
                            ? AppDesign.error
                            : AppDesign.primary,
                      ),
                      child: _saving
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Save & Continue'),
                    ),
                  ),
                  const SizedBox(height: AppDesign.s32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Sticky math tracker header ────────────────────────────────────────────

class _StickyTracker extends StatelessWidget {
  final double netIncome;
  final double totalAllocated;
  final double unassigned;
  final bool isOver;

  const _StickyTracker({
    required this.netIncome,
    required this.totalAllocated,
    required this.unassigned,
    required this.isOver,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(
          horizontal: AppDesign.s16, vertical: AppDesign.s12),
      decoration: BoxDecoration(
        color: isOver ? AppDesign.error.withValues(alpha: 0.15) : AppDesign.surface,
        border: Border(
            bottom: BorderSide(
          color: isOver ? AppDesign.error : AppDesign.divider,
          width: 0.5,
        )),
      ),
      child: Row(
        children: [
          _Stat(
              label: 'Income',
              value: formatINR(netIncome),
              color: AppDesign.credit),
          const _VSep(),
          _Stat(
              label: 'Allocated',
              value: formatINR(totalAllocated),
              color: isOver ? AppDesign.error : AppDesign.onBackground),
          const _VSep(),
          _Stat(
            label: isOver ? 'Over By' : 'Unassigned',
            value: formatINR(unassigned.abs()),
            color: isOver ? AppDesign.error : AppDesign.success,
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _Stat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: AppDesign.bodySmall),
          const SizedBox(height: 2),
          Text(value, style: AppDesign.amountSmall.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _VSep extends StatelessWidget {
  const _VSep();
  @override
  Widget build(BuildContext context) {
    return Container(height: 28, width: 0.5, color: AppDesign.divider);
  }
}

// ── Category row in setup form ────────────────────────────────────────────

class _CategoryDraft {
  final nameCtrl = TextEditingController();
  final capCtrl = TextEditingController();

  void dispose() {
    nameCtrl.dispose();
    capCtrl.dispose();
  }
}

class _CategoryRow extends StatelessWidget {
  final _CategoryDraft draft;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  const _CategoryRow({
    required this.draft,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDesign.s8),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: TextField(
              controller: draft.nameCtrl,
              style:
                  AppDesign.bodyMedium.copyWith(color: AppDesign.onBackground),
              decoration: const InputDecoration(hintText: 'Category name'),
              onChanged: (_) => onChanged(),
            ),
          ),
          const SizedBox(width: AppDesign.s8),
          Expanded(
            flex: 3,
            child: TextField(
              controller: draft.capCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style:
                  AppDesign.amountSmall.copyWith(color: AppDesign.onBackground),
              decoration:
                  const InputDecoration(hintText: '0', prefixText: '₹ '),
              onChanged: (_) => onChanged(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded,
                color: AppDesign.subtle, size: 20),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
