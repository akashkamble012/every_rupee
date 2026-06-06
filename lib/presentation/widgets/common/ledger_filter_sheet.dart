import 'package:flutter/material.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_design.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';

class LedgerFilterSheet extends StatefulWidget {
  final DateTime? initialFrom;
  final DateTime? initialTo;
  final String? initialCategoryId;
  final TransactionType? initialType;
  final String? initialSearch;
  final void Function({
    DateTime? fromDate,
    DateTime? toDate,
    String? categoryId,
    TransactionType? type,
    String? searchText,
  }) onApply;

  const LedgerFilterSheet({
    super.key,
    this.initialFrom,
    this.initialTo,
    this.initialCategoryId,
    this.initialType,
    this.initialSearch,
    required this.onApply,
  });

  @override
  State<LedgerFilterSheet> createState() => _LedgerFilterSheetState();
}

class _LedgerFilterSheetState extends State<LedgerFilterSheet> {
  DateTime? _from;
  DateTime? _to;
  String? _categoryId;
  TransactionType? _type; // null = all
  final _searchCtrl = TextEditingController();
  List<BudgetCategoryEntity> _categories = [];

  @override
  void initState() {
    super.initState();
    _from = widget.initialFrom;
    _to = widget.initialTo;
    _categoryId = widget.initialCategoryId;
    _type = widget.initialType;
    _searchCtrl.text = widget.initialSearch ?? '';
    _loadCategories();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    final result =
        await getIt<BudgetCategoryRepository>().getAllCategories();
    if (result.isOk && mounted) {
      setState(() => _categories =
          result.value.where((c) => !c.isDeleted).toList());
    }
  }

  void _reset() {
    setState(() {
      _from = null;
      _to = null;
      _categoryId = null;
      _type = null;
      _searchCtrl.clear();
    });
  }

  void _apply() {
    widget.onApply(
      fromDate: _from,
      toDate: _to,
      categoryId: _categoryId,
      type: _type,
      searchText: _searchCtrl.text.trim().isEmpty
          ? null
          : _searchCtrl.text.trim(),
    );
    Navigator.pop(context);
  }

  Future<void> _pickDate(bool isFrom) async {
    final now = DateTime.now();
    final initial = isFrom
        ? (_from ?? DateTime(now.year, now.month, 1))
        : (_to ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (ctx, child) => Theme(
        data: ThemeData.dark()
            .copyWith(colorScheme: const ColorScheme.dark(primary: AppDesign.primary)),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _from = picked;
        } else {
          _to = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.92,
      builder: (_, scrollCtrl) => Container(
        decoration: const BoxDecoration(
          color: AppDesign.surfaceHigh,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDesign.radiusXL)),
        ),
        child: ListView(
          controller: scrollCtrl,
          padding: const EdgeInsets.all(AppDesign.s24),
          children: [
            // ── Handle ─────────────────────────────────────────────
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppDesign.s20),
                decoration: BoxDecoration(
                  color: AppDesign.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // ── Header ─────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filter Ledger',
                    style: AppDesign.headlineMedium),
                TextButton(
                  onPressed: _reset,
                  child: Text('Reset All',
                      style: AppDesign.bodySmall
                          .copyWith(color: AppDesign.error)),
                ),
              ],
            ),
            const SizedBox(height: AppDesign.s24),

            // ── Text Search ─────────────────────────────────────────
            Text('Search', style: AppDesign.titleMedium),
            const SizedBox(height: AppDesign.s8),
            TextField(
              controller: _searchCtrl,
              style: AppDesign.bodyMedium
                  .copyWith(color: AppDesign.onBackground),
              decoration: const InputDecoration(
                hintText: 'Merchant name, note...',
                prefixIcon: Icon(Icons.search_rounded,
                    color: AppDesign.subtle, size: 20),
              ),
            ),
            const SizedBox(height: AppDesign.s20),

            // ── Date Range ─────────────────────────────────────────
            Text('Date Range', style: AppDesign.titleMedium),
            const SizedBox(height: AppDesign.s8),
            Row(
              children: [
                Expanded(
                  child: _DateButton(
                    label: 'From',
                    date: _from,
                    onTap: () => _pickDate(true),
                  ),
                ),
                const SizedBox(width: AppDesign.s8),
                Expanded(
                  child: _DateButton(
                    label: 'To',
                    date: _to,
                    onTap: () => _pickDate(false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDesign.s20),

            // ── Transaction Type ────────────────────────────────────
            Text('Transaction Type', style: AppDesign.titleMedium),
            const SizedBox(height: AppDesign.s8),
            Row(
              children: [
                _TypeChip(
                  label: 'All',
                  selected: _type == null,
                  onTap: () => setState(() => _type = null),
                  color: AppDesign.primary,
                ),
                const SizedBox(width: AppDesign.s8),
                _TypeChip(
                  label: 'Debits (−)',
                  selected: _type == TransactionType.debit,
                  onTap: () =>
                      setState(() => _type = TransactionType.debit),
                  color: AppDesign.debit,
                ),
                const SizedBox(width: AppDesign.s8),
                _TypeChip(
                  label: 'Credits (+)',
                  selected: _type == TransactionType.credit,
                  onTap: () =>
                      setState(() => _type = TransactionType.credit),
                  color: AppDesign.credit,
                ),
              ],
            ),
            const SizedBox(height: AppDesign.s20),

            // ── Category ───────────────────────────────────────────
            Text('Category', style: AppDesign.titleMedium),
            const SizedBox(height: AppDesign.s8),
            DropdownButtonFormField<String?>(
              initialValue: _categoryId,
              dropdownColor: AppDesign.surface,
              decoration: const InputDecoration(),
              hint: Text('All categories',
                  style: AppDesign.bodyMedium
                      .copyWith(color: AppDesign.subtle)),
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text('All Categories',
                      style: AppDesign.bodyMedium
                          .copyWith(color: AppDesign.subtle)),
                ),
                ..._categories.map((c) => DropdownMenuItem<String?>(
                      value: c.id,
                      child: Text(c.name,
                          style: AppDesign.bodyMedium
                              .copyWith(color: AppDesign.onBackground)),
                    )),
              ],
              onChanged: (v) => setState(() => _categoryId = v),
            ),
            const SizedBox(height: AppDesign.s32),

            // ── Apply ───────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _apply,
                child: const Text('Apply Filters'),
              ),
            ),
            const SizedBox(height: AppDesign.s16),
          ],
        ),
      ),
    );
  }
}

class _DateButton extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;

  const _DateButton(
      {required this.label, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDesign.s12, vertical: AppDesign.s12),
        decoration: BoxDecoration(
          color: AppDesign.surface,
          borderRadius: AppDesign.roundMedium,
          border: Border.all(
            color: date != null
                ? AppDesign.primary.withOpacity(0.5)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_rounded,
                size: 14,
                color:
                    date != null ? AppDesign.primary : AppDesign.subtle),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                date != null ? formatShortDate(date!) : label,
                style: AppDesign.bodySmall.copyWith(
                    color: date != null
                        ? AppDesign.onBackground
                        : AppDesign.subtle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color color;

  const _TypeChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
            horizontal: AppDesign.s12, vertical: AppDesign.s8),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.15) : AppDesign.surface,
          borderRadius: AppDesign.roundMedium,
          border: Border.all(
              color: selected ? color : Colors.transparent),
        ),
        child: Text(
          label,
          style: AppDesign.labelLarge.copyWith(
              color: selected ? color : AppDesign.subtle),
        ),
      ),
    );
  }
}
