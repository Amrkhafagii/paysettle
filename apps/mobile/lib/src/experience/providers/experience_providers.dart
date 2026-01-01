import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/experience_config.dart';
import '../repositories/experience_config_repository.dart';

final experienceConfigProvider = FutureProvider<ExperienceConfig>((ref) async {
  final repository = ref.watch(experienceConfigRepositoryProvider);
  return repository.fetch();
});

final themeOverrideProvider = Provider<ThemeOverride?>((ref) {
  final config = ref.watch(experienceConfigProvider);
  return config.maybeWhen(
    data: (value) => value.theme,
    orElse: () => null,
  );
});

class FeatureFlagService {
  FeatureFlagService({List<FeatureFlag>? flags})
      : _flags = {for (final flag in flags ?? const []) flag.key: flag};

  final Map<String, FeatureFlag> _flags;

  bool isEnabled(String key) => _flags[key]?.enabled ?? false;

  String variant(String key) => _flags[key]?.variant ?? 'control';

  Map<String, dynamic> payload(String key) =>
      _flags[key]?.payload ?? const <String, dynamic>{};

  FeatureFlag? flag(String key) => _flags[key];
}

final featureFlagServiceProvider = Provider<FeatureFlagService>((ref) {
  final config = ref.watch(experienceConfigProvider);
  return config.maybeWhen(
    data: (value) => FeatureFlagService(flags: value.featureFlags),
    orElse: () => FeatureFlagService(flags: const []),
  );
});
