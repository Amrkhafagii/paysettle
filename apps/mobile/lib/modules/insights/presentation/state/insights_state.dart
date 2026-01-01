import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/insight.dart';
import '../../domain/value_objects/insights_range.dart';

class InsightsState {
  const InsightsState({
    required this.dashboard,
    required this.range,
  });

  factory InsightsState.initial() => InsightsState(
        dashboard: const AsyncValue.loading(),
        range: InsightsRange.days30,
      );

  final AsyncValue<InsightsDashboard> dashboard;
  final InsightsRange range;

  InsightsState copyWith({
    AsyncValue<InsightsDashboard>? dashboard,
    InsightsRange? range,
  }) {
    return InsightsState(
      dashboard: dashboard ?? this.dashboard,
      range: range ?? this.range,
    );
  }
}
