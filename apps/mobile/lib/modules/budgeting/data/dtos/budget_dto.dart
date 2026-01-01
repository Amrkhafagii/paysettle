import '../../../../src/core/utils/parsing.dart';
import '../../domain/entities/budget.dart';

class BudgetDto {
  BudgetDto({
    required this.id,
    required this.label,
    required this.amount,
    required this.spent,
    required this.remaining,
    required this.progress,
    required this.threshold,
    required this.thresholdPercent,
    required this.status,
    required this.recurrence,
    required this.periodStart,
    required this.periodEnd,
    required this.resetOn,
    required this.categoryId,
    required this.categoryLabel,
    required this.categoryColor,
    required this.alerts,
    required this.trend,
    required this.metadata,
  });

  factory BudgetDto.fromMap(Map<String, dynamic> map) {
    return BudgetDto(
      id: '${map['budget_id'] ?? map['budgetId']}',
      label: '${map['label'] ?? ''}',
      amount: parseDouble(map['amount']),
      spent: parseDouble(map['spent']),
      remaining: parseDouble(map['remaining']),
      progress: parseDouble(map['progress']),
      threshold: parseDouble(map['threshold']),
      thresholdPercent:
          parseDouble(map['threshold_percent'] ?? map['thresholdPercent']),
      status: _parseStatus(map['status']),
      recurrence: _parseRecurrence(map['recurrence']),
      periodStart: parseDate(map['period_start'] ?? map['periodStart']) ??
          DateTime.now(),
      periodEnd:
          parseDate(map['period_end'] ?? map['periodEnd']) ?? DateTime.now(),
      resetOn: parseDate(map['reset_on'] ?? map['resetOn']),
      categoryId: map['category_id']?.toString(),
      categoryLabel: map['category_label']?.toString(),
      categoryColor: map['category_color']?.toString(),
      alerts: _parseAlerts(map['alerts']),
      trend: _parseTrend(map['trend']),
      metadata: _parseMetadata(map['metadata']),
    );
  }

  final String id;
  final String label;
  final double amount;
  final double spent;
  final double remaining;
  final double progress;
  final double threshold;
  final double thresholdPercent;
  final BudgetStatus status;
  final BudgetRecurrence recurrence;
  final DateTime periodStart;
  final DateTime periodEnd;
  final DateTime? resetOn;
  final String? categoryId;
  final String? categoryLabel;
  final String? categoryColor;
  final List<BudgetAlert> alerts;
  final List<BudgetTrendPoint> trend;
  final Map<String, dynamic>? metadata;

  Map<String, dynamic> toJson() {
    return {
      'budget_id': id,
      'label': label,
      'amount': amount,
      'spent': spent,
      'remaining': remaining,
      'progress': progress,
      'threshold': threshold,
      'threshold_percent': thresholdPercent,
      'status': status.name,
      'recurrence': recurrence.rpcValue,
      'period_start': periodStart.toIso8601String(),
      'period_end': periodEnd.toIso8601String(),
      'reset_on': resetOn?.toIso8601String(),
      'category_id': categoryId,
      'category_label': categoryLabel,
      'category_color': categoryColor,
      'alerts': alerts
          .map((alert) => {
                'id': alert.id,
                'type': alert.type,
                'status': alert.status,
                'amount': alert.amount,
                'thresholdPercent': alert.thresholdPercent,
                'createdAt': alert.createdAt.toIso8601String(),
                'resolvedAt': alert.resolvedAt?.toIso8601String(),
              })
          .toList(growable: false),
      'trend': trend
          .map((point) => {
                'label': point.label,
                'value': point.value,
              })
          .toList(growable: false),
      'metadata': metadata,
    };
  }

  BudgetSummary toDomain() {
    return BudgetSummary(
      id: id,
      label: label,
      amount: amount,
      spent: spent,
      remaining: remaining,
      threshold: threshold,
      thresholdPercent: thresholdPercent,
      progress: progress,
      status: status,
      recurrence: recurrence,
      periodStart: periodStart,
      periodEnd: periodEnd,
      resetOn: resetOn,
      categoryId: categoryId,
      categoryLabel: categoryLabel,
      categoryColor: categoryColor,
      alerts: alerts,
      trend: trend,
      metadata: metadata,
    );
  }

  static BudgetStatus _parseStatus(Object? raw) {
    final value = raw?.toString().toLowerCase();
    switch (value) {
      case 'warning':
        return BudgetStatus.warning;
      case 'exceeded':
        return BudgetStatus.exceeded;
      default:
        return BudgetStatus.ok;
    }
  }

  static BudgetRecurrence _parseRecurrence(Object? raw) {
    final value = raw?.toString().toLowerCase();
    return BudgetRecurrence.values.firstWhere(
      (recurrence) => recurrence.rpcValue == value,
      orElse: () => BudgetRecurrence.monthly,
    );
  }

  static List<BudgetAlert> _parseAlerts(Object? raw) {
    if (raw is! List) {
      return const [];
    }
    return raw
        .whereType<Map>()
        .map((entry) => BudgetAlert(
              id: '${entry['id'] ?? ''}',
              type: '${entry['type'] ?? 'threshold'}',
              status: '${entry['status'] ?? 'open'}',
              amount:
                  entry['amount'] == null ? null : parseDouble(entry['amount']),
              thresholdPercent: entry['thresholdPercent'] == null
                  ? null
                  : parseDouble(entry['thresholdPercent']),
              createdAt:
                  parseDateTime(entry['createdAt'] ?? entry['created_at']) ??
                      DateTime.now(),
              resolvedAt:
                  parseDateTime(entry['resolvedAt'] ?? entry['resolved_at']),
            ))
        .toList(growable: false);
  }

  static List<BudgetTrendPoint> _parseTrend(Object? raw) {
    if (raw is! List) {
      return const [];
    }
    return raw
        .whereType<Map>()
        .map((entry) => BudgetTrendPoint(
              label: entry['label']?.toString() ?? '',
              value: parseDouble(entry['value']),
            ))
        .toList(growable: false);
  }

  static Map<String, dynamic>? _parseMetadata(Object? raw) {
    if (raw is Map<String, dynamic>) {
      return raw;
    }
    if (raw is Map) {
      return normalizeMap(raw);
    }
    return null;
  }
}
