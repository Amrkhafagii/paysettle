import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/cache/cache_box.dart';
import '../../core/cache/cache_keys.dart';
import '../../core/cache/cache_service.dart';
import '../../core/network/supabase_client_provider.dart';
import '../models/experience_config.dart';

class ExperienceConfigRepository {
  ExperienceConfigRepository(this._client, this._cache);

  final SupabaseClient _client;
  final CacheService _cache;
  final Logger _logger = Logger('ExperienceConfigRepository');

  Future<ExperienceConfig> fetch({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = _cache.read<Map>(CacheBox.core, CacheKeys.experienceConfig);
      if (cached is Map<String, dynamic>) {
        return ExperienceConfig.fromJson(cached);
      }
    }

    try {
      final response = await _client.rpc('experience_config');
      if (response is Map<String, dynamic>) {
        final config = ExperienceConfig.fromJson(response);
        await _cache.write(
            CacheBox.core, CacheKeys.experienceConfig, config.toJson());
        return config;
      }
    } catch (error, stack) {
      _logger.warning('experience_config RPC failed', error, stack);
    }

    final fallback =
        _cache.read<Map>(CacheBox.core, CacheKeys.experienceConfig);
    if (fallback is Map<String, dynamic>) {
      return ExperienceConfig.fromJson(fallback);
    }
    return const ExperienceConfig();
  }

}

final experienceConfigRepositoryProvider = Provider<ExperienceConfigRepository>((ref) {
  return ExperienceConfigRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(cacheServiceProvider),
  );
});
