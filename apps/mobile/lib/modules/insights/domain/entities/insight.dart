import 'package:freezed_annotation/freezed_annotation.dart';

part 'insight.freezed.dart';

@freezed
class InsightsTrendPoint with _$InsightsTrendPoint {
  const factory InsightsTrendPoint({
    required String label,
    required double value,
  }) = _InsightsTrendPoint;
}

@freezed
class InsightCategoryBreakdown with _$InsightCategoryBreakdown {
  const factory InsightCategoryBreakdown({
    String? categoryId,
    required String label,
    String? color,
    required double value,
    required double percent,
  }) = _InsightCategoryBreakdown;
}

@freezed
class InsightActivity with _$InsightActivity {
  const factory InsightActivity({
    required String id,
    required String label,
    required double amount,
    required String currency,
    required DateTime occurredOn,
    String? notes,
  }) = _InsightActivity;
}

@freezed
class InsightsDashboard with _$InsightsDashboard {
  const factory InsightsDashboard({
    required String timeframe,
    required DateTime periodStart,
    required DateTime periodEnd,
    required double totalSpent,
    required double averageDaily,
    double? changePercent,
    required String currency,
    required List<InsightsTrendPoint> trend,
    required List<InsightCategoryBreakdown> categories,
    required List<InsightActivity> recentActivities,
  }) = _InsightsDashboard;
}
