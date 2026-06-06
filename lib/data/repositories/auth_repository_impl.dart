import 'package:injectable/injectable.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/remote/auth_remote_datasource.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;

  AuthRepositoryImpl(this._remote);

  @override
  Stream<UserEntity?> get authStateChanges => _remote.authStateChanges;

  @override
  UserEntity? get currentUser => _remote.currentFirebaseUser;

  @override
  Future<Result<UserEntity>> signInWithEmail(
          {required String email, required String password}) =>
      _remote.signInWithEmail(email, password);

  @override
  Future<Result<UserEntity>> signUpWithEmail(
          {required String email, required String password}) =>
      _remote.signUpWithEmail(email, password);

  @override
  Future<Result<UserEntity>> signInWithGoogle() => _remote.signInWithGoogle();

  @override
  Future<Result<void>> signOut() => _remote.signOut();

  @override
  Future<Result<void>> markOnboardingComplete(String uid) =>
      _remote.markOnboardingComplete(uid);

  @override
  Future<Result<void>> markBudgetSetupComplete(String uid) =>
      _remote.markBudgetSetupComplete(uid);

  @override
  Future<Result<void>> updateVarianceSortPreference(String uid, String preference) =>
      _remote.updateVarianceSortPreference(uid, preference);

  @override
  Future<Result<void>> updateDashboardVisibleCharts(String uid, List<String> charts) =>
      _remote.updateDashboardVisibleCharts(uid, charts);
}
