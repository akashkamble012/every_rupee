// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:local_auth/local_auth.dart' as _i8;

import '../../data/datasources/local/isar_provider.dart' as _i7;
import '../../data/datasources/local/roadmap_local_datasource.dart' as _i9;
import '../../data/datasources/local/transaction_local_datasource.dart' as _i12;
import '../../data/datasources/remote/auth_remote_datasource.dart' as _i3;
import '../../data/datasources/remote/firestore_sync_service.dart' as _i17;
import '../../data/repositories/auth_repository_impl.dart' as _i5;
import '../../data/repositories/budget_category_repository_impl.dart' as _i15;
import '../../data/repositories/income_repository_impl.dart' as _i18;
import '../../data/repositories/roadmap_repository_impl.dart' as _i10;
import '../../data/repositories/transaction_repository_impl.dart' as _i13;
import '../../domain/repositories/repositories.dart' as _i4;
import '../../domain/usecases/auth/auth_usecases.dart' as _i6;
import '../../domain/usecases/budget/calculate_monthly_surplus.dart' as _i21;
import '../../domain/usecases/budget/get_category_variances.dart' as _i23;
import '../../domain/usecases/budget/get_wealth_history.dart' as _i24;
import '../../domain/usecases/export/export_ledger_usecase.dart' as _i16;
import '../../domain/usecases/roadmap/generate_roadmap_usecase.dart' as _i22;
import '../../presentation/blocs/auth/auth_bloc.dart' as _i14;
import '../../presentation/blocs/dashboard/dashboard_bloc.dart' as _i27;
import '../../presentation/blocs/insights/insights_bloc.dart' as _i25;
import '../../presentation/blocs/roadmap/roadmap_bloc.dart' as _i26;
import '../../presentation/screens/ledger/ledger_screen.dart' as _i19;
import '../notifications/sms_listener_service.dart' as _i11;
import '../router/app_router.dart' as _i20;
import 'register_module.dart' as _i28;

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
    final registerModule = _$RegisterModule();
    gh.singleton<_i3.AuthRemoteDataSource>(() => _i3.AuthRemoteDataSource());
    gh.factory<_i4.AuthRepository>(
        () => _i5.AuthRepositoryImpl(gh<_i3.AuthRemoteDataSource>()));
    gh.factory<_i6.GetAuthStateChangesUseCase>(
        () => _i6.GetAuthStateChangesUseCase(gh<_i4.AuthRepository>()));
    gh.factory<_i6.GetCurrentUserUseCase>(
        () => _i6.GetCurrentUserUseCase(gh<_i4.AuthRepository>()));
    gh.singleton<_i7.IsarProvider>(() => _i7.IsarProvider());
    gh.lazySingleton<_i8.LocalAuthentication>(
        () => registerModule.localAuthentication);
    gh.factory<_i6.MarkBudgetSetupCompleteUseCase>(
        () => _i6.MarkBudgetSetupCompleteUseCase(gh<_i4.AuthRepository>()));
    gh.factory<_i6.MarkOnboardingCompleteUseCase>(
        () => _i6.MarkOnboardingCompleteUseCase(gh<_i4.AuthRepository>()));
    gh.lazySingleton<_i9.RoadmapLocalDataSource>(
        () => _i9.RoadmapLocalDataSource(gh<_i7.IsarProvider>()));
    gh.lazySingleton<_i4.RoadmapRepository>(
        () => _i10.RoadmapRepositoryImpl(gh<_i9.RoadmapLocalDataSource>()));
    gh.factory<_i6.SignInWithEmailUseCase>(
        () => _i6.SignInWithEmailUseCase(gh<_i4.AuthRepository>()));
    gh.factory<_i6.SignInWithGoogleUseCase>(
        () => _i6.SignInWithGoogleUseCase(gh<_i4.AuthRepository>()));
    gh.factory<_i6.SignOutUseCase>(() => _i6.SignOutUseCase(
          gh<_i4.AuthRepository>(),
          gh<_i7.IsarProvider>(),
        ));
    gh.factory<_i6.SignUpWithEmailUseCase>(
        () => _i6.SignUpWithEmailUseCase(gh<_i4.AuthRepository>()));
    gh.singleton<_i11.SmsListenerService>(
        () => _i11.SmsListenerService(gh<_i7.IsarProvider>()));
    gh.factory<_i12.TransactionLocalDataSource>(
        () => _i12.TransactionLocalDataSource(gh<_i7.IsarProvider>()));
    gh.factory<_i4.TransactionRepository>(() =>
        _i13.TransactionRepositoryImpl(gh<_i12.TransactionLocalDataSource>()));
    gh.singleton<_i14.AuthBloc>(() => _i14.AuthBloc(
          gh<_i6.GetAuthStateChangesUseCase>(),
          gh<_i6.GetCurrentUserUseCase>(),
          gh<_i6.SignInWithEmailUseCase>(),
          gh<_i6.SignUpWithEmailUseCase>(),
          gh<_i6.SignInWithGoogleUseCase>(),
          gh<_i6.MarkOnboardingCompleteUseCase>(),
          gh<_i6.MarkBudgetSetupCompleteUseCase>(),
          gh<_i6.SignOutUseCase>(),
        ));
    gh.factory<_i15.BudgetCategoryLocalDataSource>(
        () => _i15.BudgetCategoryLocalDataSource(gh<_i7.IsarProvider>()));
    gh.factory<_i4.BudgetCategoryRepository>(() =>
        _i15.BudgetCategoryRepositoryImpl(
            gh<_i15.BudgetCategoryLocalDataSource>()));
    gh.factory<_i16.ExportLedgerUseCase>(() => _i16.ExportLedgerUseCase(
          gh<_i4.TransactionRepository>(),
          gh<_i4.BudgetCategoryRepository>(),
        ));
    gh.singleton<_i17.FirestoreSyncService>(
        () => _i17.FirestoreSyncService(gh<_i7.IsarProvider>()));
    gh.factory<_i18.IncomeLocalDataSource>(
        () => _i18.IncomeLocalDataSource(gh<_i7.IsarProvider>()));
    gh.factory<_i4.IncomeRepository>(
        () => _i18.IncomeRepositoryImpl(gh<_i18.IncomeLocalDataSource>()));
    gh.factory<_i19.LedgerBloc>(
        () => _i19.LedgerBloc(gh<_i4.TransactionRepository>()));
    gh.factory<_i4.SyncRepository>(() => _i17.SyncRepositoryImpl(
          gh<_i17.FirestoreSyncService>(),
          gh<_i4.AuthRepository>(),
        ));
    gh.singleton<_i20.AppRouter>(() => _i20.AppRouter(gh<_i14.AuthBloc>()));
    gh.factory<_i21.CalculateMonthlySurplusUseCase>(
        () => _i21.CalculateMonthlySurplusUseCase(
              gh<_i4.IncomeRepository>(),
              gh<_i4.BudgetCategoryRepository>(),
              gh<_i4.TransactionRepository>(),
            ));
    gh.factory<_i22.GenerateRoadmapUseCase>(() => _i22.GenerateRoadmapUseCase(
          gh<_i4.RoadmapRepository>(),
          gh<_i4.IncomeRepository>(),
          gh<_i4.BudgetCategoryRepository>(),
        ));
    gh.factory<_i23.GetCategoryVariancesUseCase>(
        () => _i23.GetCategoryVariancesUseCase(
              gh<_i4.BudgetCategoryRepository>(),
              gh<_i4.TransactionRepository>(),
              gh<_i21.CalculateMonthlySurplusUseCase>(),
            ));
    gh.factory<_i24.GetWealthHistoryUseCase>(() => _i24.GetWealthHistoryUseCase(
        gh<_i21.CalculateMonthlySurplusUseCase>()));
    gh.factory<_i25.InsightsBloc>(() => _i25.InsightsBloc(
          gh<_i23.GetCategoryVariancesUseCase>(),
          gh<_i4.TransactionRepository>(),
          gh<_i24.GetWealthHistoryUseCase>(),
        ));
    gh.factory<_i26.RoadmapBloc>(() => _i26.RoadmapBloc(
          gh<_i22.GenerateRoadmapUseCase>(),
          gh<_i4.RoadmapRepository>(),
        ));
    gh.factory<_i27.DashboardBloc>(() => _i27.DashboardBloc(
          gh<_i21.CalculateMonthlySurplusUseCase>(),
          gh<_i23.GetCategoryVariancesUseCase>(),
          gh<_i4.TransactionRepository>(),
          gh<_i24.GetWealthHistoryUseCase>(),
          gh<_i4.AuthRepository>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i28.RegisterModule {}
