import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/theme/tokens.dart';
import '../../../../src/theme/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _SettingsSection(
            title: 'Account Settings',
            items: const [
              _SettingsTile(
                  title: 'Personal Information', icon: Icons.person_outline),
              _SettingsTile(title: 'Linked Accounts', icon: Icons.link),
              _SettingsTile(
                  title: 'Subscription Plan', icon: Icons.stars_rounded),
            ],
          ),
          const SizedBox(height: Spacing.lg),
          _SettingsSection(
            title: 'App Preferences',
            items: [
              const _SettingsTile(
                  title: 'Currency', icon: Icons.currency_exchange_rounded),
              _SettingsTile(
                title: 'Dark Mode',
                icon: Icons.nightlight_rounded,
                trailing: Switch(
                  value: mode == ThemeMode.dark,
                  onChanged: (value) => ref
                      .read(themeModeProvider.notifier)
                      .state = value ? ThemeMode.dark : ThemeMode.light,
                ),
              ),
              const _SettingsTile(
                  title: 'Notifications', icon: Icons.notifications_active),
            ],
          ),
          const SizedBox(height: Spacing.lg),
          const _SettingsSection(
            title: 'Security',
            items: [
              _SettingsTile(title: 'Change Password', icon: Icons.lock_outline),
              _SettingsTile(
                  title: 'FaceID Login', icon: Icons.face_retouching_natural),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.items});

  final String title;
  final List<_SettingsTile> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.sm),
        ...items,
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.title, required this.icon, this.trailing});

  final String title;
  final IconData icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.card)),
      child: ListTile(
        leading: Icon(icon, color: AppColors.brandMint700),
        title: Text(title),
        trailing: trailing ?? const Icon(Icons.chevron_right_rounded),
        onTap: () {},
      ),
    );
  }
}
