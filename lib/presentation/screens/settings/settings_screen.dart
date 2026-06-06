import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/app_error.dart';
import '../../../core/theme/app_design.dart';
import '../../../domain/repositories/repositories.dart';
import '../../blocs/auth/auth_bloc.dart';

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
