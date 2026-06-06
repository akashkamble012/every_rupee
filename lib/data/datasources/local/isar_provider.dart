import 'package:isar/isar.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/utils/app_logger.dart';
import '../../models/isar/isar_models.dart';



/// Singleton Isar instance — injected everywhere via get_it.
@singleton
class IsarProvider {
  Isar? _isar;

  Isar get db {
    if (_isar == null || !_isar!.isOpen) {
      throw StateError(
          'IsarProvider.db accessed before init(). Call await IsarProvider.init() in bootstrap.');
    }
    return _isar!;
  }

  /// Must be called once during app bootstrap, before runApp.
  Future<void> init() async {
    if (_isar != null && _isar!.isOpen) return;
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        IsarTransactionSchema,
        IsarBudgetCategorySchema,
        IsarIncomeSourceSchema,
        IsarPendingWriteSchema,
        IsarTemporaryOutflowSchema,
        IsarRoadmapMonthSchema,
      ],
      directory: dir.path,
      name: 'zb_budget_db',
    );
    AppLogger.i('Isar opened at ${dir.path}');
  }

  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}
