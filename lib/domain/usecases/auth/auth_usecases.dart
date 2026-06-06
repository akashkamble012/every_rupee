import 'package:injectable/injectable.dart';

import '../../../data/datasources/local/isar_provider.dart';
import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

@injectable
class GetAuthStateChangesUseCase {
  final AuthRepository _repository;
  GetAuthStateChangesUseCase(this._repository);
  Stream<UserEntity?> call() => _repository.authStateChanges;
}

@injectable
class GetCurrentUserUseCase {
  final AuthRepository _repository;
  GetCurrentUserUseCase(this._repository);
  UserEntity? call() => _repository.currentUser;
}

@injectable
class SignInWithEmailUseCase {
  final AuthRepository _repository;
  SignInWithEmailUseCase(this._repository);
  Future<Result<UserEntity>> call(String email, String password) =>
      _repository.signInWithEmail(email: email, password: password);
}

@injectable
class SignUpWithEmailUseCase {
  final AuthRepository _repository;
  SignUpWithEmailUseCase(this._repository);
  Future<Result<UserEntity>> call(String email, String password) =>
      _repository.signUpWithEmail(email: email, password: password);
}

@injectable
class SignInWithGoogleUseCase {
  final AuthRepository _repository;
  SignInWithGoogleUseCase(this._repository);
  Future<Result<UserEntity>> call() => _repository.signInWithGoogle();
}

@injectable
class SignOutUseCase {
  final AuthRepository _repository;
  final IsarProvider _isarProvider;
  SignOutUseCase(this._repository, this._isarProvider);
  Future<Result<void>> call() async {
    await _isarProvider.clearDb();
    return _repository.signOut();
  }
}

@injectable
class MarkOnboardingCompleteUseCase {
  final AuthRepository _repository;
  MarkOnboardingCompleteUseCase(this._repository);
  Future<Result<void>> call(String uid) => _repository.markOnboardingComplete(uid);
}

@injectable
class MarkBudgetSetupCompleteUseCase {
  final AuthRepository _repository;
  MarkBudgetSetupCompleteUseCase(this._repository);
  Future<Result<void>> call(String uid) => _repository.markBudgetSetupComplete(uid);
}
