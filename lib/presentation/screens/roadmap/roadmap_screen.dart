import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'widgets/manage_outflows_dialog.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_design.dart';
import '../../../domain/entities/entities.dart';
import '../../blocs/roadmap/roadmap_bloc.dart';

class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  late final RoadmapBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<RoadmapBloc>();
    _bloc.add(const RoadmapEvent.load());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Roadmap', style: AppDesign.headlineMedium),
          centerTitle: false,
          elevation: 0,
          backgroundColor: AppDesign.background,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => ManageOutflowsDialog(bloc: _bloc),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<RoadmapBloc, RoadmapState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (msg) => Center(
                  child: Text(msg,
                      style: const TextStyle(color: AppDesign.error))),
              loaded: (projectedMonths, temporaryOutflows) {
                if (projectedMonths.isEmpty) {
                  return const Center(child: Text('No projections available.'));
                }
                return _RoadmapTable(months: projectedMonths);
              },
            );
          },
        ),
      ),
    );
  }
}

class _RoadmapTable extends StatelessWidget {
  final List<RoadmapDisplayEntity> months;

  const _RoadmapTable({required this.months});

  @override
  Widget build(BuildContext context) {
    // We use a custom Row layout to make the first column sticky
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sticky "Month" Column
          DataTable(
            headingRowColor: WidgetStateProperty.all(AppDesign.surfaceHigh),
            dataRowMaxHeight: 60,
            dataRowMinHeight: 60,
            horizontalMargin: 16,
            columns: const [
              DataColumn(
                  label: Text('Month',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: months.map((m) {
              return DataRow(
                cells: [
                  DataCell(Text(DateFormat('MMMM yyyy').format(m.month),
                      style: const TextStyle(fontWeight: FontWeight.bold))),
                ],
              );
            }).toList(),
          ),

          // Scrollable Rest of Columns
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(AppDesign.surfaceHigh),
                dataRowMaxHeight: 60,
                dataRowMinHeight: 60,
                horizontalMargin: 16,
                columns: const [
                  DataColumn(
                      label: Text('Net Income',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Core Fixed',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('EMIs/Debts',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Total Outflow',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Surplus',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Accumulated',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Action Plan',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('',
                          style: TextStyle(
                              fontWeight: FontWeight.bold))), // Edit button
                ],
                rows: months.map((m) {
                  final isIncomeOverridden = m.netIncomeOverride != null;
                  final isFixedOverridden = m.coreFixedExpensesOverride != null;
                  final hasActionPlan =
                      m.actionPlan != null && m.actionPlan!.isNotEmpty;

                  return DataRow(
                    cells: [
                      DataCell(Text('₹${m.effectiveIncome.toStringAsFixed(0)}',
                          style: TextStyle(
                              color: isIncomeOverridden
                                  ? AppDesign.primary
                                  : AppDesign.onBackground))),
                      DataCell(Text(
                          '₹${m.effectiveFixedExpenses.toStringAsFixed(0)}',
                          style: TextStyle(
                              color: isFixedOverridden
                                  ? AppDesign.primary
                                  : AppDesign.onBackground))),
                      DataCell(
                          Text('₹${m.temporaryOutflows.toStringAsFixed(0)}')),
                      DataCell(Text('₹${m.totalOutflow.toStringAsFixed(0)}',
                          style: const TextStyle(color: AppDesign.error))),
                      DataCell(Text('₹${m.surplus.toStringAsFixed(0)}',
                          style: const TextStyle(color: AppDesign.success))),
                      DataCell(Text(
                          '₹${m.accumulatedWealth.toStringAsFixed(0)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppDesign.primary))),
                      DataCell(
                        Container(
                          constraints: const BoxConstraints(maxWidth: 200),
                          child: Text(
                            m.actionPlan ?? '-',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: hasActionPlan
                                    ? AppDesign.onBackground
                                    : AppDesign.subtle,
                                fontStyle: hasActionPlan
                                    ? FontStyle.normal
                                    : FontStyle.italic),
                          ),
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.edit,
                              size: 20, color: AppDesign.subtle),
                          onPressed: () {
                            _showEditDialog(context, m);
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, RoadmapDisplayEntity month) {
    final netIncomeController =
        TextEditingController(text: month.netIncomeOverride?.toString() ?? '');
    final fixedExpensesController = TextEditingController(
        text: month.coreFixedExpensesOverride?.toString() ?? '');
    final actionPlanController =
        TextEditingController(text: month.actionPlan ?? '');

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppDesign.surface,
          title: Text('Edit ${DateFormat('MMMM yyyy').format(month.month)}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Leave amount fields empty to use base defaults.',
                    style: TextStyle(fontSize: 12, color: AppDesign.subtle)),
                const SizedBox(height: 16),
                TextField(
                  controller: netIncomeController,
                  decoration: const InputDecoration(
                      labelText: 'Net Income Override', prefixText: '₹'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: fixedExpensesController,
                  decoration: const InputDecoration(
                      labelText: 'Core Fixed Expenses Override',
                      prefixText: '₹'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: actionPlanController,
                  decoration: const InputDecoration(
                      labelText: 'Action Plan / Milestone'),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final income = double.tryParse(netIncomeController.text);
                final fixed = double.tryParse(fixedExpensesController.text);
                final plan = actionPlanController.text.trim();

                context.read<RoadmapBloc>().add(RoadmapEvent.saveOverride(
                      month: month.month,
                      netIncomeOverride: income,
                      coreFixedExpensesOverride: fixed,
                      actionPlan: plan.isEmpty ? null : plan,
                    ));

                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
