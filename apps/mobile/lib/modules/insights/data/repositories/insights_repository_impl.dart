import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/cache/cache_box.dart';
import '../../../../src/core/cache/cache_keys.dart';
import '../../../../src/core/cache/cache_service.dart';
import '../../domain/entities/insight.dart';
import '../../domain/repositories/insights_repository.dart';
import '../../domain/value_objects/insights_range.dart';
import '../datasources/insights_remote_data_source.dart';
import '../dtos/insights_dashboard_dto.dart';

class InsightsRepositoryImpl implements InsightsRepository {
  InsightsRepositoryImpl({
    required InsightsRemoteDataSource remoteDataSource,
    required CacheService cacheService,
  })  : _remoteDataSource = remoteDataSource,
        _cacheService = cacheService;

  final InsightsRemoteDataSource _remoteDataSource;
  final CacheService _cacheService;

  @override
  Future<InsightsDashboard> fetchDashboard({
    required InsightsRange range,
    bool forceRefresh = false,
  }) async {
    final cacheKey = '${CacheKeys.insightsDashboard}_${range.rpcValue}';
    try {
      final dto = await _remoteDataSource.fetchDashboard(
        range: range,
        forceRefresh: forceRefresh,
      );
      await _cacheService.write(CacheBox.core, cacheKey, dto.toJson());
      return dto.toDomain();
    } catch (_) {
      final cached =
          _cacheService.read<Map<dynamic, dynamic>>(CacheBox.core, cacheKey);
      if (cached == null) {
        rethrow;
      }
      final normalized = cached.map<String, dynamic>(
          (key, value) => MapEntry(key.toString(), value));
      return InsightsDashboardDto.fromMap(normalized).toDomain();
    }
  }
}
