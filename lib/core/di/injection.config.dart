// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/datasources/local/isar_provider.dart' as _i7;
import '../../data/datasources/local/roadmap_local_datasource.dart' as _i8;
import '../../data/datasources/local/transaction_local_datasource.dart' as _i11;
import '../../data/datasources/remote/auth_remote_datasource.dart' as _i3;
import '../../data/datasources/remote/firestore_sync_service.dart' as _i15;
import '../../data/repositories/auth_repository_impl.dart' as _i5;
import '../../data/repositories/budget_category_repository_impl.dart' as _i14;
import '../../data/repositories/income_repository_impl.dart' as _i16;
import '../../data/repositories/roadmap_repository_impl.dart' as _i9;
import '../../data/repositories/transaction_repository_impl.dart' as _i12;
import '../../domain/repositories/repositories.dart' as _i4;
import '../../domain/usecases/auth/auth_usecases.dart' as _i6;
import '../../domain/usecases/budget/calculate_monthly_surplus.dart' as _i19;
import '../../domain/usecases/budget/get_category_variances.dart' as _i21;
import '../../domain/usecases/budget/get_wealth_history.dart' as _i22;
import '../../domain/usecases/roadmap/generate_roadmap_usecase.dart' as _i20;
import '../../presentation/blocs/auth/auth_bloc.dart' as _i13;
import '../../presentation/blocs/dashboard/dashboard_bloc.dart' as _i25;
import '../../presentation/blocs/insights/insights_bloc.dart' as _i23;
import '../../presentation/blocs/roadmap/roadmap_bloc.dart' as _i24;
import '../../presentation/screens/ledger/ledger_screen.dart' as _i17;
import '../notifications/sms_listener_service.dart' as _i10;
import '../router/app_router.dart' as _i18;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.AuthRemoteDataSource>(() => _i3.AuthRemoteDataSource());
    gh.factory<_i4.AuthRepository>(
        () => _i5.AuthRepositoryImpl(gh<_i3.AuthRemoteDataSource>()));
    gh.factory<_i6.GetAuthStateChangesUseCase>(
        () => _i6.GetAuthStateChangesUseCase(gh<_i4.AuthRepository>()));
    gh.factory<_i6.GetCurrentUserUseCase>(
        () => _i6.GetCurrentUserUseCase(gh<_i4.AuthRepository>()));
    gh.singleton<_i7.IsarProvider>(() => _i7.IsarProvider());
    gh.factory<_i6.MarkBudgetSetupCompleteUseCase>(
        () => _i6.MarkBudgetSetupCompleteUseCase(gh<_i4.AuthRepository>()));
    gh.factory<_i6.MarkOnboardingCompleteUseCase>(
        () => _i6.MarkOnboardingCompleteUseCase(gh<_i4.AuthRepository>()));
    gh.lazySingleton<_i8.RoadmapLocalDataSource>(
        () => _i8.RoadmapLocalDataSource(gh<_i7.IsarProvider>()));
    gh.lazySingleton<_i4.RoadmapRepository>(
        () => _i9.RoadmapRepositoryImpl(gh<_i8.RoadmapLocalDataSource>()));
    gh.factory<_i6.SignInWithEmailUseCase>(
        () => _i6.SignInWithEmailUseCase(gh<_i4.AuthRepository>()));
    gh.factory<_i6.SignInWithGoogleUseCase>(
        () => _i6.SignInWithGoogleUseCase(gh<_i4.AuthRepository>()));
    gh.factory<_i6.SignOutUseCase>(
        () => _i6.SignOutUseCase(gh<_i4.AuthRepository>()));
    gh.factory<_i6.SignUpWithEmailUseCase>(
        () => _i6.SignUpWithEmailUseCase(gh<_i4.AuthRepository>()));
    gh.singleton<_i10.SmsListenerService>(
        () => _i10.SmsListenerService(gh<_i7.IsarProvider>()));
    gh.factory<_i11.TransactionLocalDataSource>(
        () => _i11.TransactionLocalDataSource(gh<_i7.IsarProvider>()));
    gh.factory<_i4.TransactionRepository>(() =>
        _i12.TransactionRepositoryImpl(gh<_i11.TransactionLocalDataSource>()));
    gh.singleton<_i13.AuthBloc>(() => _i13.AuthBloc(
          gh<_i6.GetAuthStateChangesUseCase>(),
          gh<_i6.GetCurrentUserUseCase>(),
          gh<_i6.SignInWithEmailUseCase>(),
          gh<_i6.SignUpWithEmailUseCase>(),
          gh<_i6.SignInWithGoogleUseCase>(),
          gh<_i6.MarkOnboardingCompleteUseCase>(),
          gh<_i6.MarkBudgetSetupCompleteUseCase>(),
          gh<_i6.SignOutUseCase>(),
        ));
    gh.factory<_i14.BudgetCategoryLocalDataSource>(
        () => _i14.BudgetCategoryLocalDataSource(gh<_i7.IsarProvider>()));
    gh.factory<_i4.BudgetCategoryRepository>(() =>
        _i14.BudgetCategoryRepositoryImpl(
            gh<_i14.BudgetCategoryLocalDataSource>()));
    gh.singleton<_i15.FirestoreSyncService>(
        () => _i15.FirestoreSyncService(gh<_i7.IsarProvider>()));
    gh.factory<_i16.IncomeLocalDataSource>(
        () => _i16.IncomeLocalDataSource(gh<_i7.IsarProvider>()));
    gh.factory<_i4.IncomeRepository>(
        () => _i16.IncomeRepositoryImpl(gh<_i16.IncomeLocalDataSource>()));
    gh.factory<_i17.LedgerBloc>(
        () => _i17.LedgerBloc(gh<_i4.TransactionRepository>()));
    gh.factory<_i4.SyncRepository>(() => _i15.SyncRepositoryImpl(
          gh<_i15.FirestoreSyncService>(),
          gh<_i4.AuthRepository>(),
        ));
    gh.singleton<_i18.AppRouter>(() => _i18.AppRouter(gh<_i13.AuthBloc>()));
    gh.factory<_i19.CalculateMonthlySurplusUseCase>(
        () => _i19.CalculateMonthlySurplusUseCase(
              gh<_i4.IncomeRepository>(),
              gh<_i4.BudgetCategoryRepository>(),
              gh<_i4.TransactionRepository>(),
            ));
    gh.factory<_i20.GenerateRoadmapUseCase>(() => _i20.GenerateRoadmapUseCase(
          gh<_i4.RoadmapRepository>(),
          gh<_i4.IncomeRepository>(),
          gh<_i4.BudgetCategoryRepository>(),
        ));
    gh.factory<_i21.GetCategoryVariancesUseCase>(
        () => _i21.GetCategoryVariancesUseCase(
              gh<_i4.BudgetCategoryRepository>(),
              gh<_i4.TransactionRepository>(),
              gh<_i19.CalculateMonthlySurplusUseCase>(),
            ));
    gh.factory<_i22.GetWealthHistoryUseCase>(() => _i22.GetWealthHistoryUseCase(
        gh<_i19.CalculateMonthlySurplusUseCase>()));
    gh.factory<_i23.InsightsBloc>(() => _i23.InsightsBloc(
          gh<_i21.GetCategoryVariancesUseCase>(),
          gh<_i4.TransactionRepository>(),
          gh<_i22.GetWealthHistoryUseCase>(),
        ));
    gh.factory<_i24.RoadmapBloc>(() => _i24.RoadmapBloc(
          gh<_i20.GenerateRoadmapUseCase>(),
          gh<_i4.RoadmapRepository>(),
        ));
    gh.factory<_i25.DashboardBloc>(() => _i25.DashboardBloc(
          gh<_i19.CalculateMonthlySurplusUseCase>(),
          gh<_i21.GetCategoryVariancesUseCase>(),
          gh<_i4.TransactionRepository>(),
          gh<_i22.GetWealthHistoryUseCase>(),
          gh<_i4.AuthRepository>(),
        ));
    return this;
  }
}
