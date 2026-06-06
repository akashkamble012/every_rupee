  import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/app_error.dart';
import '../../../core/router/app_router.dart';
import '../../widgets/common/ledger_filter_sheet.dart';
import '../../../core/theme/app_design.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';

part 'ledger_screen.freezed.dart';

// ── BLoC ──────────────────────────────────────────────────────────────────

@freezed
class LedgerEvent with _$LedgerEvent {
  const factory LedgerEvent.load() = _Load;
  const factory LedgerEvent.loadMore() = _LoadMore;
  const factory LedgerEvent.applyFilter({
    DateTime? fromDate,
    DateTime? toDate,
    String? categoryId,
    TransactionType? type,
    String? searchText,
  }) = _ApplyFilter;
  const factory LedgerEvent.softDelete(String id) = _SoftDelete;
}

@freezed
class LedgerState with _$LedgerState {
  const factory LedgerState.initial() = _Initial;
  const factory LedgerState.loading() = _Loading;
  const factory LedgerState.loaded({
    required List<TransactionEntity> transactions,
    required bool hasMore,
    required int page,
  }) = _Loaded;
  const factory LedgerState.failure(String message) = _Failure;
}

@injectable
class LedgerBloc extends Bloc<LedgerEvent, LedgerState> {
  final TransactionRepository _txRepo;
  static const _pageSize = 20;

  DateTime? _fromDate;
  DateTime? _toDate;
  String? _categoryId;
  TransactionType? _type;
  String? _searchText;
  StreamSubscription<void>? _txSub;

  LedgerBloc(this._txRepo) : super(const LedgerState.initial()) {
    on<_Load>(_onLoad);
    on<_LoadMore>(_onLoadMore);
    on<_ApplyFilter>(_onApplyFilter);
    on<_SoftDelete>(_onSoftDelete);
    
    _txSub = _txRepo.watchAllTransactions().listen((_) {
      add(const LedgerEvent.load());
    });
  }

  @override
  Future<void> close() {
    _txSub?.cancel();
    return super.close();
  }

  Future<void> _onLoad(_Load event, Emitter<LedgerState> emit) async {
    emit(const LedgerState.loading());
    await _fetch(0, emit, []);
  }

  Future<void> _onLoadMore(_LoadMore event, Emitter<LedgerState> emit) async {
    await state.mapOrNull(
      loaded: (loaded) async {
        if (!loaded.hasMore) return;
        await _fetch(loaded.page + 1, emit, loaded.transactions);
      },
    );
  }

  Future<void> _onApplyFilter(
      _ApplyFilter event, Emitter<LedgerState> emit) async {
    _fromDate = event.fromDate;
    _toDate = event.toDate;
    _categoryId = event.categoryId;
    _type = event.type;
    _searchText = event.searchText;
    add(const LedgerEvent.load());
  }

  Future<void> _onSoftDelete(
      _SoftDelete event, Emitter<LedgerState> emit) async {
    await _txRepo.softDeleteTransaction(event.id);
    add(const LedgerEvent.load());
  }

  Future<void> _fetch(
    int page,
    Emitter<LedgerState> emit,
    List<TransactionEntity> existing,
  ) async {
    final result = await _txRepo.getTransactionsPaged(
      offset: page * _pageSize,
      limit: _pageSize,
      fromDate: _fromDate,
      toDate: _toDate,
      categoryId: _categoryId,
      type: _type,
      searchText: _searchText,
    );
    result.fold(
      (txs) => emit(LedgerState.loaded(
        transactions: [...existing, ...txs],
        hasMore: txs.length >= _pageSize,
        page: page,
      )),
      (err) => emit(LedgerState.failure(err.displayMessage)),
    );
  }
}

// ── Screen ────────────────────────────────────────────────────────────────

class LedgerScreen extends StatelessWidget {
  const LedgerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<LedgerBloc>()..add(const LedgerEvent.load()),
      child: const _LedgerView(),
    );
  }
}

class _LedgerView extends StatelessWidget {
  const _LedgerView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesign.background,
      appBar: AppBar(
        backgroundColor: AppDesign.background,
        elevation: 0,
        title: Text('Ledger', style: AppDesign.headlineMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded,
                color: AppDesign.subtle),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: BlocBuilder<LedgerBloc, LedgerState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(
                child: CircularProgressIndicator(
                    color: AppDesign.primary)),
            loading: () => const Center(
                child: CircularProgressIndicator(
                    color: AppDesign.primary)),
            failure: (message) => Center(
                child: Text(message,
                    style: AppDesign.bodyMedium
                        .copyWith(color: AppDesign.error))),
            loaded: (transactions, hasMore, page) =>
              _TransactionList(
                transactions: transactions,
                hasMore: hasMore,
              ),
          );
        },
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    final bloc = context.read<LedgerBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LedgerFilterSheet(
        onApply: ({fromDate, toDate, categoryId, type, searchText}) {
          bloc.add(LedgerEvent.applyFilter(
            fromDate: fromDate,
            toDate: toDate,
            categoryId: categoryId,
            type: type,
            searchText: searchText,
          ));
        },
      ),
    );
  }
}

class _TransactionList extends StatelessWidget {
  final List<TransactionEntity> transactions;
  final bool hasMore;

  const _TransactionList(
      {required this.transactions, required this.hasMore});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Center(
        child: Text('No transactions found',
            style: AppDesign.bodyMedium),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (n is ScrollEndNotification &&
            n.metrics.extentAfter < 200 &&
            hasMore) {
          context
              .read<LedgerBloc>()
              .add(const LedgerEvent.loadMore());
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDesign.s16, vertical: AppDesign.s8),
        itemCount: transactions.length + (hasMore ? 1 : 0),
        itemBuilder: (_, i) {
          if (i >= transactions.length) {
            return const Padding(
              padding: EdgeInsets.all(AppDesign.s16),
              child: Center(
                  child: CircularProgressIndicator(
                      color: AppDesign.primary, strokeWidth: 2)),
            );
          }
          final tx = transactions[i];
          return Dismissible(
            key: ValueKey(tx.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding:
                  const EdgeInsets.only(right: AppDesign.s20),
              decoration: BoxDecoration(
                color: AppDesign.error.withOpacity(0.15),
                borderRadius: AppDesign.roundMedium,
              ),
              child: const Icon(Icons.delete_outline_rounded,
                  color: AppDesign.error),
            ),
            confirmDismiss: (_) async {
              return await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      backgroundColor: AppDesign.surfaceHigh,
                      title: Text('Delete transaction?',
                          style: AppDesign.titleMedium),
                      content: Text(
                          'This will be synced on the next backup.',
                          style: AppDesign.bodyMedium),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(dialogContext, false),
                          child: const Text('Cancel',
                              style: TextStyle(
                                  color: AppDesign.subtle)),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(dialogContext, true),
                          child: const Text('Delete',
                              style: TextStyle(
                                  color: AppDesign.error)),
                        ),
                      ],
                    ),
                  ) ??
                  false;
            },
            onDismissed: (_) => context
                .read<LedgerBloc>()
                .add(LedgerEvent.softDelete(tx.id)),
            child: GestureDetector(
              onTap: () => context.push(
                  '${AppRoutes.transactionForm}?editId=${tx.id}'),
              child: _LedgerTile(tx: tx),
            ),
          );
        },
      ),
    );
  }
}

class _LedgerTile extends StatelessWidget {
  final TransactionEntity tx;
  const _LedgerTile({required this.tx});

  @override
  Widget build(BuildContext context) {
    final isDebit = tx.type == TransactionType.debit;
    return Container(
      margin: const EdgeInsets.only(bottom: AppDesign.s8),
      padding: const EdgeInsets.all(AppDesign.s16),
      decoration: const BoxDecoration(
        color: AppDesign.surface,
        borderRadius: AppDesign.roundMedium,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color:
                  (isDebit ? AppDesign.debit : AppDesign.credit)
                      .withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDebit
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded,
              color: isDebit ? AppDesign.debit : AppDesign.credit,
              size: 18,
            ),
          ),
          const SizedBox(width: AppDesign.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.merchant ?? 'Transaction',
                  style: AppDesign.bodyMedium
                      .copyWith(color: AppDesign.onBackground),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    if (tx.isRecurring) ...[
                      const Icon(Icons.repeat_rounded, size: 12, color: AppDesign.subtle),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      formatTimestamp(tx.date),
                      style: AppDesign.bodySmall,
                    ),
                  ],
                ),
                if (tx.tags.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    children: tx.tags.map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppDesign.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(tag, style: AppDesign.labelLarge.copyWith(color: AppDesign.primary, fontSize: 10)),
                    )).toList(),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isDebit ? '-' : '+'}${formatINR(tx.amount)}',
                style: AppDesign.amountSmall.copyWith(
                    color: isDebit
                        ? AppDesign.debit
                        : AppDesign.credit),
              ),
              if (tx.paymentMode != null)
                Text(
                  tx.paymentMode!.name.toUpperCase(),
                  style: AppDesign.bodySmall
                      .copyWith(fontSize: 10),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterSheet extends StatelessWidget {
  const _FilterSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDesign.s24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filter Transactions',
              style: AppDesign.headlineMedium),
          const SizedBox(height: AppDesign.s24),
          Text('Advanced filters — Date range, Category, Type, Search',
              style: AppDesign.bodySmall),
          const SizedBox(height: AppDesign.s8),
          Text(
            'Filter UI implementation goes here (date pickers, category dropdown, debit/credit toggle, text search).',
            style: AppDesign.bodyMedium,
          ),
          const SizedBox(height: AppDesign.s24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Apply'),
            ),
          ),
          const SizedBox(height: AppDesign.s16),
        ],
      ),
    );
  }
}
