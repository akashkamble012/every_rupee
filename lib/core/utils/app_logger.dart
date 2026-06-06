import 'package:talker/talker.dart';

/// AppLogger — thin wrapper around the `talker` package.
/// Use this everywhere instead of `print()`.
///
/// Usage:
///   AppLogger.d('Debug message');
///   AppLogger.i('Info message');
///   AppLogger.w('Warning', error: e);
///   AppLogger.e('Error', error: e, stackTrace: st);
class AppLogger {
  AppLogger._();

  static final Talker _talker = Talker();

  static void d(String message, {Object? error, StackTrace? stackTrace}) =>
      _talker.debug(message, error, stackTrace);

  static void i(String message, {Object? error, StackTrace? stackTrace}) =>
      _talker.info(message, error, stackTrace);

  static void w(String message, {Object? error, StackTrace? stackTrace}) =>
      _talker.warning(message, error, stackTrace);

  static void e(String message, {Object? error, StackTrace? stackTrace}) =>
      _talker.error(message, error, stackTrace);
}
