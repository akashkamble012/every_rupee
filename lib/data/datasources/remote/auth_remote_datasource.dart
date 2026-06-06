import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/error/app_error.dart';
import '../../../core/utils/app_logger.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';

@singleton
class AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _google = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final BehaviorSubject<UserEntity?> _userSubject = BehaviorSubject<UserEntity?>.seeded(null);

  AuthRemoteDataSource() {
    _auth.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser == null) {
        _userSubject.add(null);
      } else {
        final user = await _fetchOrCreateUserDoc(firebaseUser);
        _userSubject.add(user);
      }
    });
  }

  // ── Auth state stream ─────────────────────────────────────────────────────

  Stream<UserEntity?> get authStateChanges => _userSubject.stream;

  UserEntity? get currentFirebaseUser => _userSubject.value;

  // ── Sign In ───────────────────────────────────────────────────────────────

  Future<Result<UserEntity>> signInWithEmail(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = await _fetchOrCreateUserDoc(cred.user!);
      return Ok(user);
    } on FirebaseAuthException catch (e) {
      return Err(AppError.auth(
          message: _firebaseMessage(e.code), original: e));
    } catch (e) {
      return Err(AppError.auth(message: 'Sign in failed', original: e));
    }
  }

  Future<Result<UserEntity>> signUpWithEmail(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = await _fetchOrCreateUserDoc(cred.user!);
      return Ok(user);
    } on FirebaseAuthException catch (e) {
      return Err(AppError.auth(
          message: _firebaseMessage(e.code), original: e));
    } catch (e) {
      return Err(AppError.auth(message: 'Sign up failed', original: e));
    }
  }

  Future<Result<UserEntity>> signInWithGoogle() async {
    try {
      final googleUser = await _google.signIn();
      if (googleUser == null) {
        return const Err(AppError.auth(message: 'Google Sign-In cancelled'));
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final cred = await _auth.signInWithCredential(credential);
      final user = await _fetchOrCreateUserDoc(cred.user!);
      return Ok(user);
    } on FirebaseAuthException catch (e) {
      return Err(AppError.auth(
          message: _firebaseMessage(e.code), original: e));
    } catch (e) {
      return Err(
          AppError.auth(message: 'Google Sign-In failed', original: e));
    }
  }

  Future<Result<void>> signOut() async {
    await _google.signOut();
    await _auth.signOut();
    return const Ok(null);
  }

  // ── User doc ──────────────────────────────────────────────────────────────

  Future<UserEntity> _fetchOrCreateUserDoc(User firebaseUser) async {
    final ref = _db.collection('users').doc(firebaseUser.uid);
    final snap = await ref.get();
    if (!snap.exists) {
      final data = {
        'uid': firebaseUser.uid,
        'email': firebaseUser.email ?? '',
        'displayName': firebaseUser.displayName,
        'photoUrl': firebaseUser.photoURL,
        'onboardingComplete': false,
        'budgetSetupComplete': false,
        'varianceSortPreference': null,
        'dashboardVisibleCharts': ['wealth_trend', 'allocation_donut', 'daily_spend', 'income_expense', 'category_breakdown'],
        'createdAt': FieldValue.serverTimestamp(),
      };
      await ref.set(data);
      return UserEntity(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName,
        photoUrl: firebaseUser.photoURL,
      );
    }
    final d = snap.data()!;
    return UserEntity(
      uid: d['uid'] as String,
      email: d['email'] as String,
      displayName: d['displayName'] as String?,
      photoUrl: d['photoUrl'] as String?,
      onboardingComplete: d['onboardingComplete'] as bool? ?? false,
      budgetSetupComplete: d['budgetSetupComplete'] as bool? ?? false,
      varianceSortPreference: d['varianceSortPreference'] as String?,
      dashboardVisibleCharts: (d['dashboardVisibleCharts'] as List<dynamic>?)?.map((e) => e as String).toList() 
          ?? ['wealth_trend', 'allocation_donut', 'daily_spend', 'income_expense', 'category_breakdown'],
    );
  }

  Future<Result<void>> markOnboardingComplete(String uid) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .update({'onboardingComplete': true});
      final current = _userSubject.value;
      if (current != null && current.uid == uid) {
        _userSubject.add(current.copyWith(onboardingComplete: true));
      }
      return const Ok(null);
    } catch (e) {
      return Err(AppError.auth(
          message: 'Failed to mark onboarding complete', original: e));
    }
  }

  Future<Result<void>> markBudgetSetupComplete(String uid) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .update({'budgetSetupComplete': true});
      final current = _userSubject.value;
      if (current != null && current.uid == uid) {
        _userSubject.add(current.copyWith(budgetSetupComplete: true));
      }
      return const Ok(null);
    } catch (e) {
      return Err(AppError.auth(
          message: 'Failed to mark budget setup complete', original: e));
    }
  }

  Future<Result<void>> updateVarianceSortPreference(String uid, String preference) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .update({'varianceSortPreference': preference});
      final current = _userSubject.value;
      if (current != null && current.uid == uid) {
        _userSubject.add(current.copyWith(varianceSortPreference: preference));
      }
      return const Ok(null);
    } catch (e) {
      return Err(AppError.auth(
          message: 'Failed to update sort preference', original: e));
    }
  }

  Future<Result<void>> updateDashboardVisibleCharts(String uid, List<String> charts) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .update({'dashboardVisibleCharts': charts});
      final current = _userSubject.value;
      if (current != null && current.uid == uid) {
        _userSubject.add(current.copyWith(dashboardVisibleCharts: charts));
      }
      return const Ok(null);
    } catch (e) {
      return Err(AppError.auth(
          message: 'Failed to update visible charts', original: e));
    }
  }

  // ── Firebase error code → human message ──────────────────────────────────

  String _firebaseMessage(String code) => switch (code) {
        'user-not-found' => 'No account found with that email.',
        'wrong-password' => 'Incorrect password.',
        'email-already-in-use' => 'An account with that email already exists.',
        'weak-password' => 'Password must be at least 6 characters.',
        'invalid-email' => 'Please enter a valid email address.',
        'network-request-failed' =>
          'Network error. Check your connection.',
        _ => 'Authentication error. Please try again.',
      };
}
