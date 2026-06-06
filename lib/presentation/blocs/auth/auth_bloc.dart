import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:zb_budget/domain/repositories/repositories.dart';

import '../../../core/error/app_error.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/auth/auth_usecases.dart';
import '../../../core/utils/app_logger.dart';

part 'auth_bloc.freezed.dart';

// ── Events ────────────────────────────────────────────────────────────────

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.signInWithEmail({
    required String email,
    required String password,
  }) = _SignInWithEmail;
  const factory AuthEvent.signUpWithEmail({
    required String email,
    required String password,
  }) = _SignUpWithEmail;
  const factory AuthEvent.signInWithGoogle() = _SignInWithGoogle;
  const factory AuthEvent.markOnboardingComplete() = _MarkOnboardingComplete;
  const factory AuthEvent.markBudgetSetupComplete() = _MarkBudgetSetupComplete;
  const factory AuthEvent.signOut() = _SignOut;
}

// ── States ────────────────────────────────────────────────────────────────

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(UserEntity user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.failure(String message) = _Failure;
}

// ── BLoC ──────────────────────────────────────────────────────────────────

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthStateChangesUseCase _getAuthStateChanges;
  final GetCurrentUserUseCase _getCurrentUser;
  final SignInWithEmailUseCase _signInWithEmail;
  final SignUpWithEmailUseCase _signUpWithEmail;
  final SignInWithGoogleUseCase _signInWithGoogle;
  final MarkOnboardingCompleteUseCase _markOnboardingComplete;
  final MarkBudgetSetupCompleteUseCase _markBudgetSetupComplete;
  final SignOutUseCase _signOutUseCase;

  StreamSubscription<UserEntity?>? _authSub;

  AuthBloc(
    this._getAuthStateChanges,
    this._getCurrentUser,
    this._signInWithEmail,
    this._signUpWithEmail,
    this._signInWithGoogle,
    this._markOnboardingComplete,
    this._markBudgetSetupComplete,
    this._signOutUseCase,
  ) : super(const AuthState.initial()) {
    on<_Started>(_onStarted);
    on<_SignInWithEmail>(_onSignInWithEmail);
    on<_SignUpWithEmail>(_onSignUpWithEmail);
    on<_SignInWithGoogle>(_onSignInWithGoogle);
    on<_MarkOnboardingComplete>(_onMarkOnboardingComplete);
    on<_MarkBudgetSetupComplete>(_onMarkBudgetSetupComplete);
    on<_SignOut>(_onSignOut);
  }

  void _onStarted(_Started event, Emitter<AuthState> emit) {
    _authSub ??= _getAuthStateChanges().listen((user) {
        add(const AuthEvent.started()); // re-trigger for stream updates
      });
    final current = _getCurrentUser();
    if (current != null) {
      emit(AuthState.authenticated(current));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onSignInWithEmail(
      _SignInWithEmail event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _signInWithEmail(event.email, event.password);
    result.fold(
      (user) => emit(AuthState.authenticated(user)),
      (err) => emit(AuthState.failure(err.displayMessage)),
    );
  }

  Future<void> _onSignUpWithEmail(
      _SignUpWithEmail event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _signUpWithEmail(event.email, event.password);
    result.fold(
      (user) => emit(AuthState.authenticated(user)),
      (err) => emit(AuthState.failure(err.displayMessage)),
    );
  }

  Future<void> _onSignInWithGoogle(
      _SignInWithGoogle event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _signInWithGoogle();
    result.fold(
      (user) => emit(AuthState.authenticated(user)),
      (err) => emit(AuthState.failure(err.displayMessage)),
    );
  }

  Future<void> _onMarkOnboardingComplete(
      _MarkOnboardingComplete event, Emitter<AuthState> emit) async {
    final current = state.mapOrNull(authenticated: (s) => s.user);
    if (current != null) {
      final result = await _markOnboardingComplete(current.uid);
      result.fold(
        (_) {},
        (err) => emit(AuthState.failure(err.displayMessage)),
      );
    }
  }

  Future<void> _onMarkBudgetSetupComplete(
      _MarkBudgetSetupComplete event, Emitter<AuthState> emit) async {
    final current = state.mapOrNull(authenticated: (s) => s.user);
    if (current != null) {
      final result = await _markBudgetSetupComplete(current.uid);
      result.fold(
        (_) {},
        (err) => emit(AuthState.failure(err.displayMessage)),
      );
    }
  }

  Future<void> _onSignOut(_SignOut event, Emitter<AuthState> emit) async {
    await _signOutUseCase();
    emit(const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _authSub?.cancel();
    return super.close();
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    AppLogger.i('AuthBLOC transition from ${transition.currentState}');
    AppLogger.i('AuthBLOC transition to ${transition.nextState}');
    AppLogger.i('AuthBLOC transition event ${transition.event}');
    super.onTransition(transition);
  }
}
