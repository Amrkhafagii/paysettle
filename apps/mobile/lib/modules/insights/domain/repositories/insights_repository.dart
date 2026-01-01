import '../entities/insight.dart';
import '../value_objects/insights_range.dart';

abstract class InsightsRepository {
  Future<InsightsDashboard> fetchDashboard({
    required InsightsRange range,
    bool forceRefresh,
  });
}
