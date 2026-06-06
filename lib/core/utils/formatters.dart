import 'package:intl/intl.dart';

import '../constants/app_constants.dart';

// ── Currency ──────────────────────────────────────────────────────────────

final _inrFormatter = NumberFormat.currency(
  locale: 'en_IN',
  symbol: AppConstants.currencySymbol,
  decimalDigits: 0,
);

final _inrFormatterDecimal = NumberFormat.currency(
  locale: 'en_IN',
  symbol: AppConstants.currencySymbol,
  decimalDigits: 2,
);

/// Format [amount] as Indian Rupees without decimals: ₹1,20,000
String formatINR(double amount) => _inrFormatter.format(amount);

/// Format [amount] as Indian Rupees with 2 decimal places: ₹1,20,000.50
String formatINRDecimal(double amount) => _inrFormatterDecimal.format(amount);

/// Compact notation: 1.2L, 50K, etc.
String formatINRCompact(double amount) {
  if (amount >= 10000000) return '${AppConstants.currencySymbol}${(amount / 10000000).toStringAsFixed(1)}Cr';
  if (amount >= 100000) return '${AppConstants.currencySymbol}${(amount / 100000).toStringAsFixed(1)}L';
  if (amount >= 1000) return '${AppConstants.currencySymbol}${(amount / 1000).toStringAsFixed(1)}K';
  return _inrFormatter.format(amount);
}

// ── Date ──────────────────────────────────────────────────────────────────

final _monthYear = DateFormat('MMMM yyyy');
final _shortDate = DateFormat('d MMM');
final _fullDate = DateFormat('d MMM yyyy');
final _timeStamp = DateFormat('d MMM yyyy, h:mm a');

/// "June 2025"
String formatMonthYear(DateTime date) => _monthYear.format(date);

/// "4 Jun"
String formatShortDate(DateTime date) => _shortDate.format(date);

/// "4 Jun 2025"
String formatFullDate(DateTime date) => _fullDate.format(date);

/// "4 Jun 2025, 3:45 PM"
String formatTimestamp(DateTime date) => _timeStamp.format(date);

/// Returns the first day of [date]'s month: DateTime(2025, 6, 1, 0, 0, 0)
DateTime startOfMonth(DateTime date) => DateTime(date.year, date.month, 1);

/// Returns the last millisecond of [date]'s month
DateTime endOfMonth(DateTime date) =>
    DateTime(date.year, date.month + 1, 1)
        .subtract(const Duration(milliseconds: 1));

/// True if [date] falls within [from] and [until] (both inclusive).
/// If [until] is null, the range is considered open-ended (still active).
bool isWithinRange(DateTime date, DateTime from, DateTime? until) {
  if (date.isBefore(from)) return false;
  if (until != null && date.isAfter(until)) return false;
  return true;
}
