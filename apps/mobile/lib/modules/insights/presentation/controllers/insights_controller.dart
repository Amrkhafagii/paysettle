import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/insight.dart';
import '../../domain/usecases/get_insights_dashboard.dart';
import '../../domain/usecases/usecase_providers.dart';
import '../../domain/value_objects/insights_range.dart';
import '../state/insights_state.dart';

class InsightsController extends StateNotifier<InsightsState> {
  InsightsController({required GetInsightsDashboardUseCase getDashboard})
      : _getDashboard = getDashboard,
        super(InsightsState.initial()) {
    load();
  }

  final GetInsightsDashboardUseCase _getDashboard;

  Future<void> load({InsightsRange? range, bool forceRefresh = false}) async {
    final target = range ?? state.range;
    state = state.copyWith(
      range: target,
      dashboard: const AsyncValue.loading(),
    );
    final result = await AsyncValue.guard(
      () => _getDashboard(range: target, forceRefresh: forceRefresh),
    );
    state = state.copyWith(dashboard: result);
  }

  Future<void> refresh() => load(range: state.range, forceRefresh: true);

  void selectRange(InsightsRange range) {
    if (range == state.range) {
      return;
    }
    load(range: range);
  }
}

final insightsControllerProvider =
    StateNotifierProvider<InsightsController, InsightsState>((ref) {
  return InsightsController(
    getDashboard: ref.watch(getInsightsDashboardUseCaseProvider),
  );
});
