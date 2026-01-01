import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/cache/cache_service.dart';
import '../../data/datasources/insights_remote_data_source.dart';
import '../../data/repositories/insights_repository_impl.dart';
import '../repositories/insights_repository.dart';
import 'get_insights_dashboard.dart';

final insightsRepositoryProvider = Provider<InsightsRepository>((ref) {
  return InsightsRepositoryImpl(
    remoteDataSource: ref.watch(insightsRemoteDataSourceProvider),
    cacheService: ref.watch(cacheServiceProvider),
  );
});

final getInsightsDashboardUseCaseProvider =
    Provider<GetInsightsDashboardUseCase>((ref) {
  return GetInsightsDashboardUseCase(ref.watch(insightsRepositoryProvider));
});
