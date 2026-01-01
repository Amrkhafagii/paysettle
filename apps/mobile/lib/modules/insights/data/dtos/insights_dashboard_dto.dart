import '../../../../src/core/utils/parsing.dart';
import '../../domain/entities/insight.dart';

class InsightsDashboardDto {
  InsightsDashboardDto({
    required this.timeframe,
    required this.periodStart,
    required this.periodEnd,
    required this.totalSpent,
    required this.averageDaily,
    required this.changePercent,
    required this.currency,
    required this.trend,
    required this.categories,
    required this.recentActivities,
  });

  factory InsightsDashboardDto.fromMap(Map<String, dynamic> map) {
    return InsightsDashboardDto(
      timeframe: '${map['timeframe'] ?? '30d'}',
      periodStart: parseDate(map['periodStart'] ?? map['period_start']) ??
          DateTime.now(),
      periodEnd:
          parseDate(map['periodEnd'] ?? map['period_end']) ?? DateTime.now(),
      totalSpent: parseDouble(map['totalSpent'] ?? map['total_spent']),
      averageDaily: parseDouble(map['averageDaily'] ?? map['avgDaily']),
      changePercent: map['changePercent'] == null
          ? null
          : parseDouble(map['changePercent']),
      currency: '${map['currency'] ?? 'EGP'}',
      trend: _parseTrend(map['trend']),
      categories:
          _parseCategories(map['categoryBreakdown'] ?? map['categories']),
      recentActivities: _parseActivities(map['recentActivities']),
    );
  }

  final String timeframe;
  final DateTime periodStart;
  final DateTime periodEnd;
  final double totalSpent;
  final double averageDaily;
  final double? changePercent;
  final String currency;
  final List<InsightsTrendPoint> trend;
  final List<InsightCategoryBreakdown> categories;
  final List<InsightActivity> recentActivities;

  Map<String, dynamic> toJson() {
    return {
      'timeframe': timeframe,
      'periodStart': periodStart.toIso8601String(),
      'periodEnd': periodEnd.toIso8601String(),
      'totalSpent': totalSpent,
      'averageDaily': averageDaily,
      'changePercent': changePercent,
      'currency': currency,
      'trend': trend
          .map((point) => {'label': point.label, 'value': point.value})
          .toList(growable: false),
      'categoryBreakdown': categories
          .map((category) => {
                'categoryId': category.categoryId,
                'label': category.label,
                'color': category.color,
                'value': category.value,
                'percent': category.percent,
              })
          .toList(growable: false),
      'recentActivities': recentActivities
          .map((activity) => {
                'id': activity.id,
                'label': activity.label,
                'amount': activity.amount,
                'currency': activity.currency,
                'occurredOn': activity.occurredOn.toIso8601String(),
                'notes': activity.notes,
              })
          .toList(growable: false),
    };
  }

  InsightsDashboard toDomain() {
    return InsightsDashboard(
      timeframe: timeframe,
      periodStart: periodStart,
      periodEnd: periodEnd,
      totalSpent: totalSpent,
      averageDaily: averageDaily,
      changePercent: changePercent,
      currency: currency,
      trend: trend,
      categories: categories,
      recentActivities: recentActivities,
    );
  }

  static List<InsightsTrendPoint> _parseTrend(Object? raw) {
    if (raw is! List) {
      return const [];
    }
    return raw
        .whereType<Map>()
        .map((entry) => InsightsTrendPoint(
              label: entry['label']?.toString() ?? '',
              value: parseDouble(entry['value']),
            ))
        .toList(growable: false);
  }

  static List<InsightCategoryBreakdown> _parseCategories(Object? raw) {
    if (raw is! List) {
      return const [];
    }
    return raw
        .whereType<Map>()
        .map((entry) => InsightCategoryBreakdown(
              categoryId: entry['categoryId']?.toString(),
              label: entry['label']?.toString() ?? 'Unknown',
              color: entry['color']?.toString(),
              value: parseDouble(entry['value']),
              percent: parseDouble(entry['percent']),
            ))
        .toList(growable: false);
  }

  static List<InsightActivity> _parseActivities(Object? raw) {
    if (raw is! List) {
      return const [];
    }
    return raw
        .whereType<Map>()
        .map((entry) => InsightActivity(
              id: '${entry['id'] ?? ''}',
              label: entry['label']?.toString() ?? 'Recent spend',
              amount: parseDouble(entry['amount']),
              currency: entry['currency']?.toString() ?? 'EGP',
              occurredOn:
                  parseDateTime(entry['occurredOn'] ?? entry['occurred_on']) ??
                      DateTime.now(),
              notes: entry['notes']?.toString(),
            ))
        .toList(growable: false);
  }
}
