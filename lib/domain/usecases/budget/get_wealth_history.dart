import 'package:injectable/injectable.dart';

import '../../repositories/repositories.dart';
import '../../entities/entities.dart';
import 'calculate_monthly_surplus.dart';

@injectable
class GetWealthHistoryUseCase {
  final CalculateMonthlySurplusUseCase _calculateMonthlySurplus;

  const GetWealthHistoryUseCase(this._calculateMonthlySurplus);

  Future<Result<List<MonthlySurplusEntity>>> call(
      DateTime currentMonth, {int monthsCount = 6}) async {
    final List<MonthlySurplusEntity> history = [];
    
    // We want the oldest month at index 0, and currentMonth at the last index.
    for (int i = monthsCount - 1; i >= 0; i--) {
      final targetMonth = DateTime(currentMonth.year, currentMonth.month - i, 1);
      final result = await _calculateMonthlySurplus(targetMonth);
      
      if (result.isErr) {
        return Err(result.error);
      }
      
      history.add(result.value);
    }
    
    return Ok(history);
  }
}
