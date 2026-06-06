import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/app_error.dart';
import '../../../core/theme/app_design.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../domain/usecases/export/export_ledger_usecase.dart';
import '../../blocs/auth/auth_bloc.dart';
import 'package:local_auth/local_auth.dart' as local_auth;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _syncRepo = getIt<SyncRepository>();

  Future<void> _handleSync(bool pullOnly) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Syncing...'), duration: Duration(seconds: 1)),
    );
    
    if (!pullOnly) {
      await _syncRepo.pushPendingWrites();
    }
    final result = await _syncRepo.pullRemoteChanges();
    
    if (mounted) {
      if (result.isOk) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sync completed successfully.'), backgroundColor: AppDesign.success),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sync failed: ${result.error.displayMessage}'), backgroundColor: AppDesign.error),
        );
      }
    }
  }

  void _showExportOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppDesign.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDesign.radiusMedium)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppDesign.s16),
                child: Text('Select Export Format', style: AppDesign.headlineMedium),
              ),
              ListTile(
                leading: const Icon(Icons.table_chart_outlined, color: AppDesign.primary),
                title: const Text('CSV (Spreadsheet)'),
                onTap: () {
                  Navigator.pop(context);
                  _exportLedger(ExportFormat.csv);
                },
              ),
              ListTile(
                leading: const Icon(Icons.grid_on_outlined, color: AppDesign.success),
                title: const Text('Excel (.xlsx)'),
                onTap: () {
                  Navigator.pop(context);
                  _exportLedger(ExportFormat.excel);
                },
              ),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf_outlined, color: AppDesign.error),
                title: const Text('PDF Document'),
                onTap: () {
                  Navigator.pop(context);
                  _exportLedger(ExportFormat.pdf);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _exportLedger(ExportFormat format) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Generating ${format.name.toUpperCase()} export...')),
    );
    final result = await getIt<ExportLedgerUseCase>().call(format);
    if (result.isErr && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed: ${result.error.displayMessage}'), backgroundColor: AppDesign.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesign.background,
      appBar: AppBar(
        backgroundColor: AppDesign.background,
        elevation: 0,
        title: Text('Settings', style: AppDesign.headlineMedium),
      ),
      body: StreamBuilder<SyncStatus>(
        stream: _syncRepo.syncStatusStream,
        builder: (context, snapshot) {
          final isSyncing = snapshot.data == SyncStatus.syncing;
          
          return ListView(
            padding: const EdgeInsets.all(AppDesign.s16),
            children: [
              _Section(title: 'Security', children: [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final user = state.whenOrNull(authenticated: (u) => u);
                    if (user == null) return const SizedBox();

                    return SwitchListTile(
                      title: Text('App Lock', style: AppDesign.bodyMedium.copyWith(color: AppDesign.onSurface)),
                      subtitle: Text('Require biometric authentication to open', style: AppDesign.bodySmall),
                      value: user.isAppLockEnabled,
                      activeColor: AppDesign.primary,
                      onChanged: (val) async {
                        try {
                          final localAuth = getIt<local_auth.LocalAuthentication>();
                          final canAuthenticate = await localAuth.canCheckBiometrics || await localAuth.isDeviceSupported();
                          
                          if (canAuthenticate) {
                            final didAuthenticate = await localAuth.authenticate(
                              localizedReason: 'Please authenticate to toggle App Lock',
                              biometricOnly: false,
                            );
                            
                            if (didAuthenticate) {
                              final repo = getIt<AuthRepository>();
                              await repo.updateAppLockStatus(user.uid, val);
                            }
                          } else {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Device does not support biometrics/lock.'), backgroundColor: AppDesign.error),
                              );
                            }
                          }
                        } catch (e) {
                           if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Authentication failed: $e'), backgroundColor: AppDesign.error),
                              );
                            }
                        }
                      },
                    );
                  },
                ),
              ]),
              _Section(title: 'Account', children: [
                _SettingsTile(
                  icon: Icons.logout_rounded,
                  label: 'Sign Out',
                  color: AppDesign.error,
                  onTap: () => context
                      .read<AuthBloc>()
                      .add(const AuthEvent.signOut()),
                ),
              ]),
              _Section(title: 'Data', children: [
                _SettingsTile(
                  icon: isSyncing ? Icons.sync : Icons.cloud_sync_rounded,
                  label: isSyncing ? 'Syncing...' : 'Sync Now (Push & Pull)',
                  onTap: isSyncing ? null : () => _handleSync(false),
                ),
                _SettingsTile(
                  icon: Icons.download_rounded,
                  label: 'Force Pull from Firebase',
                  onTap: isSyncing ? null : () => _handleSync(true),
                ),
                _SettingsTile(
                  icon: Icons.file_download_outlined,
                  label: 'Export Ledger',
                  onTap: _showExportOptions,
                ),
              ]),
              _Section(title: 'About', children: [
                _SettingsTile(
                  icon: Icons.info_outline_rounded,
                  label: 'Version 1.0.0',
                  onTap: null,
                ),
              ]),
            ],
          );
        }
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              0, AppDesign.s16, 0, AppDesign.s8),
          child: Text(title, style: AppDesign.bodySmall),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppDesign.surface,
            borderRadius: AppDesign.roundMedium,
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.label,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppDesign.onSurface;
    return ListTile(
      leading: Icon(icon, color: c, size: 20),
      title: Text(label,
          style: AppDesign.bodyMedium.copyWith(color: c)),
      trailing: onTap != null
          ? Icon(Icons.chevron_right_rounded,
              color: AppDesign.subtle, size: 18)
          : null,
      onTap: onTap,
    );
  }
}
