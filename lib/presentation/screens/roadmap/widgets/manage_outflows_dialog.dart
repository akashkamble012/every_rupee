import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_design.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/repositories/repositories.dart';
import '../../../blocs/roadmap/roadmap_bloc.dart';

class ManageOutflowsDialog extends StatefulWidget {
  final RoadmapBloc bloc;

  const ManageOutflowsDialog({super.key, required this.bloc});

  @override
  State<ManageOutflowsDialog> createState() => _ManageOutflowsDialogState();
}

class _ManageOutflowsDialogState extends State<ManageOutflowsDialog> {
  final _uuid = const Uuid();
  final _nameCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();

  DateTime _startMonth = DateTime.now();
  DateTime _endMonth = DateTime.now().add(const Duration(days: 90));

  @override
  void dispose() {
    _nameCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickMonth(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startMonth : _endMonth,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
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
      setState(() {
        if (isStart) {
          _startMonth = DateTime(picked.year, picked.month, 1);
          if (_endMonth.isBefore(_startMonth)) {
            _endMonth = _startMonth;
          }
        } else {
          _endMonth = DateTime(picked.year, picked.month, 1);
          if (_startMonth.isAfter(_endMonth)) {
            _startMonth = _endMonth;
          }
        }
      });
    }
  }

  void _save() {
    final name = _nameCtrl.text.trim();
    final amountText = _amountCtrl.text.trim();
    if (name.isEmpty || amountText.isEmpty) return;

    final amount = double.tryParse(amountText.replaceAll(',', ''));
    if (amount == null || amount <= 0) return;

    final outflow = TemporaryOutflowEntity(
      id: _uuid.v4(),
      name: name,
      amount: amount,
      startMonth: _startMonth,
      endMonth: _endMonth,
      lastModifiedAt: DateTime.now().toUtc(),
    );

    widget.bloc.add(RoadmapEvent.saveTemporaryOutflow(outflow: outflow));

    _nameCtrl.clear();
    _amountCtrl.clear();
    setState(() {
      _startMonth = DateTime.now();
      _endMonth = DateTime.now().add(const Duration(days: 90));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppDesign.surface,
      shape: RoundedRectangleBorder(borderRadius: AppDesign.roundLarge),
      child: Padding(
        padding: const EdgeInsets.all(AppDesign.s24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Manage Debts / EMIs', style: AppDesign.displayLarge),
            const SizedBox(height: AppDesign.s8),
            Text(
              'Add temporary outflows (like EMIs) that stop at a future date to accurate reflect in your Roadmap.',
              style: AppDesign.bodySmall.copyWith(color: AppDesign.subtle),
            ),
            const SizedBox(height: AppDesign.s24),
            _buildForm(),
            const SizedBox(height: AppDesign.s24),
            Text('Active Outflows', style: AppDesign.titleMedium),
            const SizedBox(height: AppDesign.s8),
            Flexible(
              child: StreamBuilder<List<TemporaryOutflowEntity>>(
                stream: getIt<RoadmapRepository>().watchTemporaryOutflows(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final outflows = snapshot.data ?? [];
                  if (outflows.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text('No active outflows.',
                          style: AppDesign.bodyMedium
                              .copyWith(color: AppDesign.subtle)),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: outflows.length,
                    separatorBuilder: (_, __) =>
                        const Divider(color: AppDesign.divider),
                    itemBuilder: (context, index) {
                      final outflow = outflows[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(outflow.name, style: AppDesign.bodyMedium),
                        subtitle: Text(
                          '${formatMonthYear(outflow.startMonth)} - ${formatMonthYear(outflow.endMonth)}',
                          style: AppDesign.bodySmall
                              .copyWith(color: AppDesign.subtle),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              formatINR(outflow.amount),
                              style: AppDesign.bodyMedium.copyWith(
                                color: AppDesign.error,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  color: AppDesign.error, size: 20),
                              onPressed: () {
                                widget.bloc.add(
                                    RoadmapEvent.deleteTemporaryOutflow(
                                        id: outflow.id));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: AppDesign.s16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.all(AppDesign.s16),
      decoration: BoxDecoration(
        color: AppDesign.surfaceHigh,
        borderRadius: AppDesign.roundMedium,
      ),
      child: Column(
        children: [
          TextField(
            controller: _nameCtrl,
            style: AppDesign.bodyMedium.copyWith(color: AppDesign.onBackground),
            decoration: const InputDecoration(
              labelText: 'Name (e.g. Car EMI)',
            ),
          ),
          const SizedBox(height: AppDesign.s16),
          TextField(
            controller: _amountCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: AppDesign.bodyMedium.copyWith(color: AppDesign.onBackground),
            decoration: const InputDecoration(
              labelText: 'Monthly Amount',
              prefixText: '₹ ',
            ),
          ),
          const SizedBox(height: AppDesign.s16),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _pickMonth(context, true),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Start Month',
                          style: AppDesign.bodySmall
                              .copyWith(color: AppDesign.subtle)),
                      const SizedBox(height: 4),
                      Text(formatMonthYear(_startMonth),
                          style: AppDesign.bodyMedium),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => _pickMonth(context, false),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('End Month',
                          style: AppDesign.bodySmall
                              .copyWith(color: AppDesign.subtle)),
                      const SizedBox(height: 4),
                      Text(formatMonthYear(_endMonth),
                          style: AppDesign.bodyMedium),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDesign.s16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _save,
              child: const Text('Add Outflow'),
            ),
          ),
        ],
      ),
    );
  }
}
