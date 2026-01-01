import '../entities/insight.dart';
import '../repositories/insights_repository.dart';
import '../value_objects/insights_range.dart';

class GetInsightsDashboardUseCase {
  GetInsightsDashboardUseCase(this._repository);

  final InsightsRepository _repository;

  Future<InsightsDashboard> call({
    required InsightsRange range,
    bool forceRefresh = false,
  }) {
    return _repository.fetchDashboard(range: range, forceRefresh: forceRefresh);
  }
}
