import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../src/theme/tokens.dart';
import '../../domain/entities/settings_overview.dart';
import '../../domain/value_objects/preferences_update.dart';
import '../../domain/value_objects/update_profile_request.dart';
import '../controllers/settings_controller.dart';
import '../state/settings_state.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsControllerProvider);
    final controller = ref.watch(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: state.overview.when(
          loading: () => const _SettingsLoadingView(),
          error: (error, _) => _SettingsErrorView(
            message: error.toString(),
            onRetry: controller.refresh,
          ),
          data: (overview) => _SettingsContent(
            overview: overview,
            state: state,
            controller: controller,
          ),
        ),
      ),
    );
  }
}

class _SettingsLoadingView extends StatelessWidget {
  const _SettingsLoadingView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(Spacing.lg),
      children: const [
        SizedBox(height: 120),
        LinearProgressIndicator(),
      ],
    );
  }
}

class _SettingsErrorView extends StatelessWidget {
  const _SettingsErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(Spacing.lg),
      children: [
        const SizedBox(height: 120),
        Icon(Icons.error_outline,
            size: 48, color: Theme.of(context).colorScheme.error),
        const SizedBox(height: Spacing.md),
        Text('Unable to load settings',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.xs),
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: Spacing.md),
        FilledButton(onPressed: onRetry, child: const Text('Retry')),
      ],
    );
  }
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent({
    required this.overview,
    required this.state,
    required this.controller,
  });

  final SettingsOverview overview;
  final SettingsState state;
  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding:
          const EdgeInsets.fromLTRB(Spacing.lg, Spacing.lg, Spacing.lg, 120),
      children: [
        TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search_rounded),
            hintText: 'Search settings...',
            filled: true,
            fillColor: AppColors.surfaceCardAlt,
          ),
          readOnly: true,
          onTap: () =>
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Search coming soon'),
          )),
        ),
        const SizedBox(height: Spacing.lg),
        _SettingsSection(
          title: 'Account Settings',
          children: [
            _SettingsTile(
              icon: Icons.person_outline,
              title: 'Personal Information',
              subtitle: overview.profile.fullName,
              onTap: () => _showProfileSheet(context),
            ),
            _SettingsTile(
              icon: Icons.link,
              title: 'Linked Accounts',
              subtitle:
                  '${overview.linkedAccounts.length} connected accounts',
            ),
            _SettingsTile(
              icon: Icons.stars_rounded,
              title: 'Subscription Plan',
              subtitle:
                  '${overview.subscription.planName} • ${overview.subscription.status}',
            ),
          ],
        ),
        const SizedBox(height: Spacing.lg),
        _PreferencesSection(
          overview: overview,
          state: state,
          controller: controller,
        ),
        const SizedBox(height: Spacing.lg),
        _SecuritySection(
          overview: overview,
          state: state,
          controller: controller,
        ),
        const SizedBox(height: Spacing.lg),
        _IntegrationsSection(
          overview: overview,
          state: state,
          controller: controller,
        ),
        const SizedBox(height: Spacing.lg),
        Text('App Version 1.0.2',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Future<void> _showProfileSheet(BuildContext context) async {
    final profile = overview.profile;
    final nameController = TextEditingController(text: profile.fullName);
    final phoneController = TextEditingController(text: profile.phone ?? '');
    final jobTitleController = TextEditingController(text: profile.jobTitle ?? '');
    final countryController = TextEditingController(text: profile.country ?? '');
    final timezoneController =
        TextEditingController(text: profile.timezone ?? '');
    final formKey = GlobalKey<FormState>();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + Spacing.lg,
            left: Spacing.lg,
            right: Spacing.lg,
            top: Spacing.lg,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: Spacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.neutral200,
                    borderRadius: BorderRadius.circular(Radii.card),
                  ),
                ),
                Text('Edit Profile',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: Spacing.md),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Full name'),
                  validator: (value) =>
                      value != null && value.trim().isNotEmpty
                          ? null
                          : 'Please enter your name',
                ),
                const SizedBox(height: Spacing.sm),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: Spacing.sm),
                TextFormField(
                  controller: jobTitleController,
                  decoration: const InputDecoration(labelText: 'Job title'),
                ),
                const SizedBox(height: Spacing.sm),
                TextFormField(
                  controller: countryController,
                  decoration: const InputDecoration(labelText: 'Country'),
                ),
                const SizedBox(height: Spacing.sm),
                TextFormField(
                  controller: timezoneController,
                  decoration: const InputDecoration(labelText: 'Timezone'),
                ),
                const SizedBox(height: Spacing.lg),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: state.isUpdatingProfile
                        ? null
                        : () async {
                            if (!(formKey.currentState?.validate() ?? false)) {
                              return;
                            }
                            await controller.saveProfile(
                              UpdateProfileRequest(
                                fullName: nameController.text.trim(),
                                phone: phoneController.text.trim().isEmpty
                                    ? null
                                    : phoneController.text.trim(),
                                jobTitle: jobTitleController.text.trim().isEmpty
                                    ? null
                                    : jobTitleController.text.trim(),
                                country: countryController.text.trim().isEmpty
                                    ? null
                                    : countryController.text.trim(),
                                timezone:
                                    timezoneController.text.trim().isEmpty
                                        ? null
                                        : timezoneController.text.trim(),
                              ),
                            );
                            if (sheetContext.mounted) {
                              Navigator.of(sheetContext).pop();
                            }
                          },
                    child: state.isUpdatingProfile
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save changes'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PreferencesSection extends StatelessWidget {
  const _PreferencesSection({
    required this.overview,
    required this.state,
    required this.controller,
  });

  final SettingsOverview overview;
  final SettingsState state;
  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    final currencies = overview.preferences.availableCurrencies;
    final formatter = NumberFormat.simpleCurrency(
        name: overview.preferences.preferredCurrency);

    return _SettingsSection(
      title: 'App Preferences',
      children: [
        _SettingsTile(
          icon: Icons.currency_exchange_rounded,
          title: 'Currency',
          subtitle:
              '${overview.preferences.preferredCurrency} • ${formatter.currencySymbol}',
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => _showCurrencyPicker(context, currencies),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Theme'),
                const SizedBox(height: Spacing.sm),
                SegmentedButton<ThemePreference>(
                  segments: ThemePreference.values
                      .map(
                        (theme) => ButtonSegment(
                          value: theme,
                          label: Text(theme.apiValue.toUpperCase()),
                        ),
                      )
                      .toList(),
                  selected: {overview.preferences.darkMode},
                  onSelectionChanged: state.isUpdatingPreferences
                      ? null
                      : (value) => controller.savePreferences(
                          PreferencesUpdate(theme: value.first)),
                ),
              ],
            ),
          ),
        ),
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          title: const Text('Notifications'),
          subtitle: const Text('Enable push and realtime alerts'),
          value: overview.preferences.notificationsEnabled,
          onChanged: state.isUpdatingPreferences
              ? null
              : (value) => controller.savePreferences(
                    PreferencesUpdate(notificationsEnabled: value),
                  ),
        ),
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          title: const Text('FaceID Login'),
          value: overview.preferences.faceIdEnabled,
          onChanged: state.isUpdatingPreferences
              ? null
              : (value) => controller.savePreferences(
                    PreferencesUpdate(faceIdEnabled: value),
                  ),
        ),
      ],
    );
  }

  Future<void> _showCurrencyPicker(
    BuildContext context,
    List<String> currencies,
  ) async {
    if (currencies.isEmpty) {
      return;
    }
    await showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => ListView(
        shrinkWrap: true,
        children: currencies
            .map(
              (currency) => ListTile(
                title: Text(currency),
                trailing: overview.preferences.preferredCurrency == currency
                    ? const Icon(Icons.check, color: AppColors.brandMint600)
                    : null,
                onTap: () {
                  controller.savePreferences(
                    PreferencesUpdate(currency: currency),
                  );
                  Navigator.of(sheetContext).pop();
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SecuritySection extends StatelessWidget {
  const _SecuritySection({
    required this.overview,
    required this.state,
    required this.controller,
  });

  final SettingsOverview overview;
  final SettingsState state;
  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return _SettingsSection(
      title: 'Security',
      children: [
        _SettingsTile(
          icon: Icons.lock_outline,
          title: 'Change Password',
          subtitle: 'Reset via email',
          trailing: const Icon(Icons.open_in_new_rounded),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Change password via web')),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Active Sessions',
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: Spacing.sm),
                ...overview.sessions.map(
                  (session) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      session.isCurrent
                          ? Icons.phone_iphone_rounded
                          : Icons.devices_other_rounded,
                      color: session.isCurrent
                          ? AppColors.brandMint600
                          : AppColors.neutral400,
                    ),
                    title: Text(session.deviceName),
                    subtitle: Text(
                      '${session.platform ?? 'Unknown'} • ${session.location ?? 'Unknown'}',
                    ),
                    trailing: session.status == 'revoked'
                        ? const Text('Revoked',
                            style: TextStyle(color: AppColors.error))
                        : TextButton(
                            onPressed: state.revokingSessions
                                    .contains(session.id)
                                ? null
                                : () =>
                                    controller.revokeSession(session.id),
                            child: state.revokingSessions.contains(session.id)
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child:
                                        CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Text('Revoke'),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _IntegrationsSection extends StatelessWidget {
  const _IntegrationsSection({
    required this.overview,
    required this.state,
    required this.controller,
  });

  final SettingsOverview overview;
  final SettingsState state;
  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    final primaryConnector =
        overview.connectors.isEmpty ? null : overview.connectors.first;
    final isSyncingPrimary = primaryConnector != null &&
        state.syncingConnectors.contains(primaryConnector.id);

    return _SettingsSection(
      title: 'Integrations',
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data Exports',
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: Spacing.sm),
                Text(
                    'Generate CSV or PDF exports for wallets, journeys, or budgets.'),
                const SizedBox(height: Spacing.sm),
                FilledButton.icon(
                  onPressed:
                      state.isRequestingExport ? null : () => _showExportSheet(context),
                  icon: const Icon(Icons.download_rounded),
                  label: state.isRequestingExport
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Export Data'),
                ),
                const SizedBox(height: Spacing.sm),
                ...overview.exports.map(
                  (job) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('${job.type.label} • ${job.format.label}'),
                    subtitle: Text(job.status),
                    trailing: job.downloadUrl != null
                        ? IconButton(
                            icon: const Icon(Icons.link),
                            onPressed: () => ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text('Download via dashboard'))),
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Accounting Connectors',
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: Spacing.sm),
                Wrap(
                  spacing: Spacing.sm,
                  runSpacing: Spacing.sm,
                  children: overview.connectors
                      .map(
                        (connector) => Chip(
                          avatar: Icon(Icons.cloud_sync_rounded,
                              color: connector.status == 'connected'
                                  ? AppColors.brandMint600
                                  : AppColors.warning),
                          label: Text(
                              '${connector.provider.toUpperCase()} • ${connector.status}'),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: Spacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: state.isConnecting
                            ? null
                            : () => controller.connectAccounting('xero'),
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Connect Provider'),
                      ),
                    ),
                    const SizedBox(width: Spacing.sm),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: primaryConnector == null
                            ? null
                            : () => controller
                                .triggerConnectorSync(primaryConnector.id),
                        icon: isSyncingPrimary
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.sync),
                        label: const Text('Sync Now'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showExportSheet(BuildContext context) async {
    DataExportType selectedType = DataExportType.full;
    DataExportFormat selectedFormat = DataExportFormat.pdf;

    await showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setState) => Padding(
            padding: const EdgeInsets.all(Spacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Create Export',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: Spacing.md),
                Wrap(
                  spacing: Spacing.sm,
                  children: DataExportType.values
                      .map(
                        (type) => ChoiceChip(
                          label: Text(type.label),
                          selected: selectedType == type,
                          onSelected: (_) =>
                              setState(() => selectedType = type),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: Spacing.md),
                SegmentedButton<DataExportFormat>(
                  segments: DataExportFormat.values
                      .map((format) => ButtonSegment(
                            value: format,
                            label: Text(format.label),
                          ))
                      .toList(),
                  selected: {selectedFormat},
                  onSelectionChanged: (value) =>
                      setState(() => selectedFormat = value.first),
                ),
                const SizedBox(height: Spacing.lg),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      await controller.requestExport(
                        selectedType,
                        selectedFormat,
                      );
                      if (context.mounted) {
                        Navigator.of(sheetContext).pop();
                      }
                    },
                    child: const Text('Generate'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.sm),
        ...children.map((child) => Padding(
              padding: const EdgeInsets.only(bottom: Spacing.sm),
              child: child,
            )),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.brandMint50,
          child: Icon(icon, color: AppColors.brandMint700),
        ),
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle!),
        trailing: trailing ?? const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
