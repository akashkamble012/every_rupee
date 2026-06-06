import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/app_error.dart';
import '../../../core/theme/app_design.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';

class TransactionFormScreen extends StatefulWidget {
  final String? editId;
  const TransactionFormScreen({super.key, this.editId});

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  static const _uuid = Uuid();

  TransactionType _type = TransactionType.debit;
  final _amountCtrl = TextEditingController();
  final _merchantCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  String? _selectedCategoryId;
  PaymentMode _paymentMode = PaymentMode.upi;
  DateTime _date = DateTime.now();
  bool _saving = false;
  String? _smsSource;

  List<BudgetCategoryEntity> _categories = [];
  List<BudgetCategoryEntity> _allCategories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories().then((_) {
      if (widget.editId != null) {
        _loadTransaction();
      }
    });
  }

  Future<void> _loadTransaction() async {
    final result =
        await getIt<TransactionRepository>().getTransactionById(widget.editId!);
    if (result.isOk && result.value != null && mounted) {
      final tx = result.value!;
      setState(() {
        _type = tx.type;
        _amountCtrl.text = tx.amount.toStringAsFixed(0);
        _merchantCtrl.text = tx.merchant ?? '';
        _noteCtrl.text = tx.note ?? '';
        if (!_categories.any((c) => c.id == tx.categoryId)) {
          // If the category was deleted, add it temporarily so the dropdown doesn't crash
          try {
            final missingCat =
                _allCategories.firstWhere((c) => c.id == tx.categoryId);
            _categories.add(missingCat);
          } catch (_) {}
        }

        if (_categories.any((c) => c.id == tx.categoryId)) {
          _selectedCategoryId = tx.categoryId;
        } else {
          _selectedCategoryId = null;
        }

        if (tx.paymentMode != null) {
          _paymentMode = tx.paymentMode!;
        }
        _date = tx.date;
        _smsSource = tx.smsSource;
      });
    }
  }

  Future<void> _loadCategories() async {
    final result = await getIt<BudgetCategoryRepository>().getAllCategories();
    if (result.isOk && mounted) {
      _allCategories = result.value;
      final activeCats = result.value.where((c) => !c.isDeleted).toList();
      activeCats.add(BudgetCategoryEntity(
        id: systemSavingsCategoryId,
        name: systemSavingsCategoryName,
        cap: 0, // Cap doesn't matter for the dropdown
        effectiveFrom: DateTime(2000),
        lastModifiedAt: DateTime.now(),
      ));
      setState(() => _categories = activeCats);
    }
  }

  Future<void> _save() async {
    final amount = double.tryParse(_amountCtrl.text.replaceAll(',', ''));
    if (amount == null || amount <= 0) {
      _showError('Enter a valid amount.');
      return;
    }
    if (_selectedCategoryId == null) {
      _showError('Select a category.');
      return;
    }

    setState(() => _saving = true);
    final now = DateTime.now();
    final tx = TransactionEntity(
      id: widget.editId ?? _uuid.v4(),
      amount: amount,
      type: _type,
      date: _date,
      categoryId: _selectedCategoryId!,
      merchant:
          _merchantCtrl.text.trim().isEmpty ? null : _merchantCtrl.text.trim(),
      paymentMode: _paymentMode,
      note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
      smsSource: _smsSource,
      needsReview: false, // Always mark as reviewed when saved manually
      createdAt: now,
      lastModifiedAt: now,
    );

    final result = await getIt<TransactionRepository>().saveTransaction(tx);
    setState(() => _saving = false);

    if (result.isOk && mounted) {
      context.pop();
    } else if (result.isErr && mounted) {
      _showError(result.error.displayMessage);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppDesign.primary,
              onPrimary: AppDesign.onPrimary,
              surface: AppDesign.surfaceHigh,
              onSurface: AppDesign.onBackground,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final now = DateTime.now();
      final newDate = DateTime(
        picked.year,
        picked.month,
        picked.day,
        _date.hour,
        _date.minute,
        _date.second,
      );
      setState(() {
        _date = newDate.isAfter(now) ? now : newDate;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppDesign.error),
    );
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _merchantCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDebit = _type == TransactionType.debit;
    final accentColor = isDebit ? AppDesign.debit : AppDesign.credit;

    return Scaffold(
      backgroundColor: AppDesign.background,
      appBar: AppBar(
        backgroundColor: AppDesign.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget.editId == null ? 'Add Transaction' : 'Edit Transaction',
          style: AppDesign.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDesign.s24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Debit / Credit toggle ────────────────────────────────
            Container(
              height: 48,
              decoration: const BoxDecoration(
                color: AppDesign.surfaceHigh,
                borderRadius: AppDesign.roundMedium,
              ),
              child: Row(
                children: [
                  _TypeButton(
                    label: 'Expense',
                    icon: Icons.arrow_upward_rounded,
                    color: AppDesign.debit,
                    isSelected: isDebit,
                    onTap: () => setState(() => _type = TransactionType.debit),
                  ),
                  _TypeButton(
                    label: 'Income / Refund',
                    icon: Icons.arrow_downward_rounded,
                    color: AppDesign.credit,
                    isSelected: !isDebit,
                    onTap: () => setState(() => _type = TransactionType.credit),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDesign.s32),

            // ── Amount ────────────────────────────────────────────────
            Center(
              child: TextField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                style: AppDesign.amountLarge.copyWith(color: accentColor),
                decoration: InputDecoration(
                  hintText: '0',
                  hintStyle:
                      AppDesign.amountLarge.copyWith(color: AppDesign.subtle),
                  prefixText: '₹ ',
                  prefixStyle:
                      AppDesign.amountLarge.copyWith(color: accentColor),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                ),
              ),
            ),
            const SizedBox(height: AppDesign.s24),

            // ── Category ──────────────────────────────────────────────
            Text('Category', style: AppDesign.titleMedium),
            const SizedBox(height: AppDesign.s8),
            DropdownButtonFormField<String>(
              value: _selectedCategoryId,
              dropdownColor: AppDesign.surfaceHigh,
              decoration: const InputDecoration(),
              hint: Text('Select category',
                  style:
                      AppDesign.bodyMedium.copyWith(color: AppDesign.subtle)),
              items: _categories
                  .map((c) => DropdownMenuItem(
                        value: c.id,
                        child: Text(c.name,
                            style: AppDesign.bodyMedium
                                .copyWith(color: AppDesign.onBackground)),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _selectedCategoryId = v),
            ),
            const SizedBox(height: AppDesign.s16),

            // ── Date ───────────────────────────────────────────────────
            Text('Date', style: AppDesign.titleMedium),
            const SizedBox(height: AppDesign.s8),
            InkWell(
              onTap: _pickDate,
              borderRadius: AppDesign.roundMedium,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDesign.s16, vertical: AppDesign.s16),
                decoration: const BoxDecoration(
                  color: AppDesign.surfaceHigh,
                  borderRadius: AppDesign.roundMedium,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatFullDate(_date),
                      style: AppDesign.bodyMedium
                          .copyWith(color: AppDesign.onBackground),
                    ),
                    const Icon(Icons.calendar_today_rounded,
                        color: AppDesign.subtle, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDesign.s16),

            // ── Merchant ──────────────────────────────────────────────
            TextField(
              controller: _merchantCtrl,
              style:
                  AppDesign.bodyMedium.copyWith(color: AppDesign.onBackground),
              decoration: const InputDecoration(hintText: 'Merchant / Note'),
            ),
            const SizedBox(height: AppDesign.s16),

            // ── Payment mode chips ────────────────────────────────────
            Text('Payment Mode', style: AppDesign.titleMedium),
            const SizedBox(height: AppDesign.s8),
            Wrap(
              spacing: AppDesign.s8,
              children: PaymentMode.values.map((mode) {
                final selected = _paymentMode == mode;
                return ChoiceChip(
                  label: Text(mode.name.toUpperCase()),
                  selected: selected,
                  selectedColor: AppDesign.primary.withOpacity(0.2),
                  backgroundColor: AppDesign.surfaceHigh,
                  labelStyle: AppDesign.labelLarge.copyWith(
                    color: selected ? AppDesign.primary : AppDesign.subtle,
                  ),
                  side: BorderSide(
                    color: selected ? AppDesign.primary : Colors.transparent,
                  ),
                  onSelected: (_) => setState(() => _paymentMode = mode),
                );
              }).toList(),
            ),
            const SizedBox(height: AppDesign.s32),

            // ── Submit ────────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: accentColor),
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Text(isDebit ? 'Log Expense' : 'Log Income'),
              ),
            ),
            const SizedBox(height: AppDesign.s32),
          ],
        ),
      ),
    );
  }
}

class _TypeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.15) : Colors.transparent,
            borderRadius: AppDesign.roundMedium,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: isSelected ? color : AppDesign.subtle, size: 16),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppDesign.labelLarge.copyWith(
                  color: isSelected ? color : AppDesign.subtle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
