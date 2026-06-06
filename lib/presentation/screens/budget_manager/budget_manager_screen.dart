import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_design.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../domain/usecases/budget/calculate_monthly_surplus.dart';

class BudgetManagerScreen extends StatefulWidget {
  const BudgetManagerScreen({super.key});

  @override
  State<BudgetManagerScreen> createState() => _BudgetManagerScreenState();
}

class _BudgetManagerScreenState extends State<BudgetManagerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  List<BudgetCategoryEntity> _categories = [];
  List<IncomeSourceEntity> _incomeSources = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
    _reload();
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  Future<void> _reload() async {
    setState(() => _loading = true);
    final cats = await getIt<BudgetCategoryRepository>().getAllCategories();
    final inc = await getIt<IncomeRepository>().getAllSources();
    final surplusRes = await getIt<CalculateMonthlySurplusUseCase>().call(DateTime.now());
    
    if (mounted) {
      setState(() {
        _categories = cats.isOk
            ? cats.value.where((c) => !c.isDeleted).toList()
            : [];
            
        if (surplusRes.isOk && surplusRes.value.surplus > 0) {
          _categories.add(BudgetCategoryEntity(
            id: systemSavingsCategoryId,
            name: systemSavingsCategoryName,
            cap: surplusRes.value.surplus,
            effectiveFrom: DateTime(2000),
            lastModifiedAt: DateTime.now(),
            iconCode: '0xf01ae', // savings icon (approx)
          ));
        }
            
        _incomeSources = inc.isOk
            ? inc.value.where((s) => !s.isDeleted).toList()
            : [];
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesign.background,
      appBar: AppBar(
        backgroundColor: AppDesign.background,
        elevation: 0,
        title: Text('Caps Manager', style: AppDesign.headlineMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded, color: AppDesign.primary),
            onPressed: () => _showAddSheet(),
          ),
        ],
        bottom: TabBar(
          controller: _tab,
          dividerColor: AppDesign.divider,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: AppDesign.primary, width: 2),
          ),
          labelColor: AppDesign.primary,
          unselectedLabelColor: AppDesign.subtle,
          labelStyle: AppDesign.labelLarge,
          tabs: const [
            Tab(text: 'Budget Caps'),
            Tab(text: 'Income'),
          ],
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppDesign.primary))
          : TabBarView(
              controller: _tab,
              children: [
                _CategoryList(
                  categories: _categories,
                  onEdit: (c) => _showEditCategorySheet(c),
                  onDelete: _deleteCategory,
                ),
                _IncomeList(
                  sources: _incomeSources,
                  onEdit: (s) => _showEditIncomeSheet(s),
                  onDelete: _deleteIncome,
                ),
              ],
            ),
    );
  }

  void _showAddSheet() {
    if (_tab.index == 0) {
      _showEditCategorySheet(null);
    } else {
      _showEditIncomeSheet(null);
    }
  }

  void _showEditCategorySheet(BudgetCategoryEntity? existing) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CategoryEditorSheet(
        existing: existing,
        onSaved: (cat) async {
          await getIt<BudgetCategoryRepository>().saveCategory(cat);
          _reload();
        },
      ),
    );
  }

  void _showEditIncomeSheet(IncomeSourceEntity? existing) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _IncomeEditorSheet(
        existing: existing,
        onSaved: (src) async {
          await getIt<IncomeRepository>().saveIncomeSource(src);
          _reload();
        },
      ),
    );
  }

  Future<void> _deleteCategory(String id) async {
    await getIt<BudgetCategoryRepository>().softDeleteCategory(id);
    _reload();
  }

  Future<void> _deleteIncome(String id) async {
    await getIt<IncomeRepository>().softDeleteIncomeSource(id);
    _reload();
  }
}

// ── Category list tab ─────────────────────────────────────────────────────

class _CategoryList extends StatelessWidget {
  final List<BudgetCategoryEntity> categories;
  final void Function(BudgetCategoryEntity) onEdit;
  final void Function(String) onDelete;

  const _CategoryList({
    required this.categories,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return Center(
        child: Text('No categories. Tap + to add.',
            style: AppDesign.bodyMedium),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppDesign.s16),
      itemCount: categories.length,
      itemBuilder: (_, i) {
        final cat = categories[i];
        final isExpiring = cat.activeUntil != null;
        return Container(
          margin: const EdgeInsets.only(bottom: AppDesign.s8),
          decoration: BoxDecoration(
            color: AppDesign.surface,
            borderRadius: AppDesign.roundMedium,
            border: isExpiring
                ? Border.all(
                    color: AppDesign.warning.withValues(alpha: 0.3), width: 1)
                : null,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDesign.s16, vertical: AppDesign.s4),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppDesign.primary.withValues(alpha: 0.12),
                borderRadius: AppDesign.roundSmall,
              ),
              child: Icon(
                cat.iconCode != null
                    ? IconData(int.parse(cat.iconCode!),
                        fontFamily: 'MaterialIcons')
                    : Icons.category_rounded,
                color: AppDesign.primary,
                size: 20,
              ),
            ),
            title: Text(cat.name, style: AppDesign.titleMedium),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(formatINR(cat.cap),
                    style: AppDesign.amountSmall
                        .copyWith(color: AppDesign.credit)),
                if (isExpiring)
                  Text(
                    'Expires: ${formatFullDate(cat.activeUntil!)}',
                    style: AppDesign.bodySmall
                        .copyWith(color: AppDesign.warning),
                  ),
              ],
            ),
            trailing: cat.id == systemSavingsCategoryId 
              ? const SizedBox.shrink()
              : PopupMenuButton<String>(
              color: AppDesign.surfaceHigh,
              icon: const Icon(Icons.more_vert_rounded,
                  color: AppDesign.subtle, size: 18),
              onSelected: (v) {
                if (v == 'edit') onEdit(cat);
                if (v == 'delete') onDelete(cat.id);
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit',
                      style: AppDesign.bodyMedium),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete',
                      style: AppDesign.bodyMedium
                          .copyWith(color: AppDesign.error)),
                ),
              ],
            ),
            onTap: () {
              if (cat.id != systemSavingsCategoryId) onEdit(cat);
            },
          ),
        );
      },
    );
  }
}

// ── Income list tab ───────────────────────────────────────────────────────

class _IncomeList extends StatelessWidget {
  final List<IncomeSourceEntity> sources;
  final void Function(IncomeSourceEntity) onEdit;
  final void Function(String) onDelete;

  const _IncomeList({
    required this.sources,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (sources.isEmpty) {
      return Center(
        child: Text('No income sources. Tap + to add.',
            style: AppDesign.bodyMedium),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppDesign.s16),
      itemCount: sources.length,
      itemBuilder: (_, i) {
        final src = sources[i];
        return Container(
          margin: const EdgeInsets.only(bottom: AppDesign.s8),
          decoration: const BoxDecoration(
            color: AppDesign.surface,
            borderRadius: AppDesign.roundMedium,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDesign.s16, vertical: AppDesign.s4),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppDesign.credit.withValues(alpha: 0.12),
                borderRadius: AppDesign.roundSmall,
              ),
              child: const Icon(Icons.account_balance_rounded,
                  color: AppDesign.credit, size: 20),
            ),
            title: Text(src.name, style: AppDesign.titleMedium),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(formatINR(src.amount),
                    style: AppDesign.amountSmall
                        .copyWith(color: AppDesign.credit)),
                Text(
                  'From: ${formatShortDate(src.effectiveFrom)}${src.effectiveUntil != null
                          ? ' → ${formatShortDate(src.effectiveUntil!)}'
                          : ' (ongoing)'}',
                  style: AppDesign.bodySmall,
                ),
              ],
            ),
            trailing: PopupMenuButton<String>(
              color: AppDesign.surfaceHigh,
              icon: const Icon(Icons.more_vert_rounded,
                  color: AppDesign.subtle, size: 18),
              onSelected: (v) {
                if (v == 'edit') onEdit(src);
                if (v == 'delete') onDelete(src.id);
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit', style: AppDesign.bodyMedium),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete',
                      style: AppDesign.bodyMedium
                          .copyWith(color: AppDesign.error)),
                ),
              ],
            ),
            onTap: () => onEdit(src),
          ),
        );
      },
    );
  }
}

// ── Category editor bottom sheet ──────────────────────────────────────────

class _CategoryEditorSheet extends StatefulWidget {
  final BudgetCategoryEntity? existing;
  final void Function(BudgetCategoryEntity) onSaved;

  const _CategoryEditorSheet({this.existing, required this.onSaved});

  @override
  State<_CategoryEditorSheet> createState() => _CategoryEditorSheetState();
}

class _CategoryEditorSheetState extends State<_CategoryEditorSheet> {
  static const _uuid = Uuid();
  late final TextEditingController _name;
  late final TextEditingController _cap;
  DateTime? _activeUntil;
  DateTime _effectiveFrom = DateTime(DateTime.now().year, DateTime.now().month, 1);

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _name = TextEditingController(text: e?.name ?? '');
    _cap = TextEditingController(text: e?.cap.toStringAsFixed(0) ?? '');
    _activeUntil = e?.activeUntil;
    _effectiveFrom = e?.effectiveFrom ??
        DateTime(DateTime.now().year, DateTime.now().month, 1);
  }

  @override
  void dispose() {
    _name.dispose();
    _cap.dispose();
    super.dispose();
  }

  void _save() {
    final name = _name.text.trim();
    final cap = double.tryParse(_cap.text);
    if (name.isEmpty || cap == null || cap <= 0) return;
    final now = DateTime.now();
    final entity = BudgetCategoryEntity(
      id: widget.existing?.id ?? _uuid.v4(),
      name: name,
      cap: cap,
      effectiveFrom: _effectiveFrom,
      activeUntil: _activeUntil,
      lastModifiedAt: now,
    );
    widget.onSaved(entity);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return _SheetWrapper(
      title: widget.existing == null ? 'New Budget Cap' : 'Edit Budget Cap',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _name,
            style: AppDesign.bodyMedium
                .copyWith(color: AppDesign.onBackground),
            decoration: const InputDecoration(hintText: 'Category name'),
          ),
          const SizedBox(height: AppDesign.s12),
          TextField(
            controller: _cap,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: AppDesign.amountMedium,
            decoration:
                const InputDecoration(hintText: '0', prefixText: '₹ '),
          ),
          const SizedBox(height: AppDesign.s12),
          _DateRow(
            label: 'Effective From',
            date: _effectiveFrom,
            onTap: () async {
              final p = await _pickDate(context, _effectiveFrom);
              if (p != null) setState(() => _effectiveFrom = p);
            },
          ),
          const SizedBox(height: AppDesign.s8),
          _DateRow(
            label: 'Expires On (optional)',
            date: _activeUntil,
            hint: 'No expiry',
            onTap: () async {
              final p = await _pickDate(
                  context, _activeUntil ?? DateTime.now());
              if (p != null) setState(() => _activeUntil = p);
            },
            trailing: _activeUntil != null
                ? GestureDetector(
                    onTap: () => setState(() => _activeUntil = null),
                    child: const Icon(Icons.close_rounded,
                        color: AppDesign.subtle, size: 16),
                  )
                : null,
          ),
          const SizedBox(height: AppDesign.s20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: _save, child: const Text('Save')),
          ),
        ],
      ),
    );
  }
}

// ── Income editor bottom sheet ────────────────────────────────────────────

class _IncomeEditorSheet extends StatefulWidget {
  final IncomeSourceEntity? existing;
  final void Function(IncomeSourceEntity) onSaved;

  const _IncomeEditorSheet({this.existing, required this.onSaved});

  @override
  State<_IncomeEditorSheet> createState() => _IncomeEditorSheetState();
}

class _IncomeEditorSheetState extends State<_IncomeEditorSheet> {
  static const _uuid = Uuid();
  late final TextEditingController _name;
  late final TextEditingController _amount;
  DateTime _effectiveFrom =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime? _effectiveUntil;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _name = TextEditingController(text: e?.name ?? '');
    _amount =
        TextEditingController(text: e?.amount.toStringAsFixed(0) ?? '');
    _effectiveFrom = e?.effectiveFrom ??
        DateTime(DateTime.now().year, DateTime.now().month, 1);
    _effectiveUntil = e?.effectiveUntil;
  }

  @override
  void dispose() {
    _name.dispose();
    _amount.dispose();
    super.dispose();
  }

  void _save() {
    final name = _name.text.trim();
    final amount = double.tryParse(_amount.text);
    if (name.isEmpty || amount == null || amount <= 0) return;
    final entity = IncomeSourceEntity(
      id: widget.existing?.id ?? _uuid.v4(),
      name: name,
      amount: amount,
      effectiveFrom: _effectiveFrom,
      effectiveUntil: _effectiveUntil,
      lastModifiedAt: DateTime.now(),
    );
    widget.onSaved(entity);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return _SheetWrapper(
      title: widget.existing == null ? 'New Income Source' : 'Edit Income',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _name,
            style: AppDesign.bodyMedium
                .copyWith(color: AppDesign.onBackground),
            decoration: const InputDecoration(
                hintText: 'e.g. Primary Salary, Freelance'),
          ),
          const SizedBox(height: AppDesign.s12),
          TextField(
            controller: _amount,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style:
                AppDesign.amountMedium.copyWith(color: AppDesign.credit),
            decoration:
                const InputDecoration(hintText: '0', prefixText: '₹ '),
          ),
          const SizedBox(height: AppDesign.s12),
          _DateRow(
            label: 'Effective From',
            date: _effectiveFrom,
            onTap: () async {
              final p = await _pickDate(context, _effectiveFrom);
              if (p != null) setState(() => _effectiveFrom = p);
            },
          ),
          const SizedBox(height: AppDesign.s8),
          _DateRow(
            label: 'Valid Until (optional)',
            date: _effectiveUntil,
            hint: 'Ongoing',
            onTap: () async {
              final p = await _pickDate(
                  context, _effectiveUntil ?? DateTime.now());
              if (p != null) setState(() => _effectiveUntil = p);
            },
            trailing: _effectiveUntil != null
                ? GestureDetector(
                    onTap: () => setState(() => _effectiveUntil = null),
                    child: const Icon(Icons.close_rounded,
                        color: AppDesign.subtle, size: 16),
                  )
                : null,
          ),
          const SizedBox(height: AppDesign.s20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: _save, child: const Text('Save')),
          ),
        ],
      ),
    );
  }
}

// ── Shared helpers ────────────────────────────────────────────────────────

class _SheetWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  const _SheetWrapper({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppDesign.surfaceHigh,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDesign.radiusXL)),
      ),
      padding: EdgeInsets.fromLTRB(
        AppDesign.s24,
        AppDesign.s20,
        AppDesign.s24,
        MediaQuery.of(context).viewInsets.bottom + AppDesign.s24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppDesign.s16),
              decoration: BoxDecoration(
                color: AppDesign.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(title, style: AppDesign.headlineMedium),
          const SizedBox(height: AppDesign.s20),
          child,
        ],
      ),
    );
  }
}

class _DateRow extends StatelessWidget {
  final String label;
  final DateTime? date;
  final String? hint;
  final VoidCallback onTap;
  final Widget? trailing;

  const _DateRow({
    required this.label,
    required this.date,
    required this.onTap,
    this.hint,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDesign.s16, vertical: AppDesign.s12),
        decoration: const BoxDecoration(
          color: AppDesign.surface,
          borderRadius: AppDesign.roundMedium,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppDesign.bodySmall),
                  const SizedBox(height: 2),
                  Text(
                    date != null
                        ? formatFullDate(date!)
                        : (hint ?? 'Select date'),
                    style: AppDesign.bodyMedium.copyWith(
                        color: date != null
                            ? AppDesign.onBackground
                            : AppDesign.subtle),
                  ),
                ],
              ),
            ),
            trailing ??
                const Icon(Icons.calendar_today_rounded,
                    color: AppDesign.subtle, size: 16),
          ],
        ),
      ),
    );
  }
}

Future<DateTime?> _pickDate(
    BuildContext context, DateTime initial) async {
  return showDatePicker(
    context: context,
    initialDate: initial,
    firstDate: DateTime(2020),
    lastDate: DateTime(2035),
    builder: (ctx, child) => Theme(
      data: ThemeData.dark().copyWith(
          colorScheme:
              const ColorScheme.dark(primary: AppDesign.primary)),
      child: child!,
    ),
  );
}
