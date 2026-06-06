import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

/// Typed failures — every repository / use-case returns
/// `Either<AppError, T>` so errors bubble up cleanly through the BLoC layer.
@freezed
class AppError with _$AppError {
  /// Firebase / network authentication errors
  const factory AppError.auth({
    required String message,
    Object? original,
  }) = AuthError;

  /// Isar read / write failures
  const factory AppError.database({
    required String message,
    Object? original,
  }) = DatabaseError;

  /// Firestore sync failures
  const factory AppError.sync({
    required String message,
    Object? original,
  }) = SyncError;

  /// Generic network / connectivity errors
  const factory AppError.network({
    required String message,
    Object? original,
  }) = NetworkError;

  /// Business-rule violations (e.g. over-budget allocation)
  const factory AppError.validation({required String message}) = ValidationError;

  /// Catch-all for unexpected errors
  const factory AppError.unknown({
    required String message,
    Object? original,
  }) = UnknownError;
}

/// Convenience extension for user-facing messages
extension AppErrorX on AppError {
  String get displayMessage => when(
        auth: (msg, _) => msg,
        database: (msg, _) => 'Storage error: $msg',
        sync: (msg, _) => 'Sync error: $msg',
        network: (msg, _) => 'Network error: $msg',
        validation: (msg) => msg,
        unknown: (msg, _) => 'Something went wrong: $msg',
      );
}
