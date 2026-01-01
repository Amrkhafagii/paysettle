import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget.freezed.dart';

enum BudgetStatus { ok, warning, exceeded }

enum BudgetRecurrence { weekly, monthly, quarterly, yearly, custom }

extension BudgetRecurrenceX on BudgetRecurrence {
  String get label {
    switch (this) {
      case BudgetRecurrence.weekly:
        return 'Weekly';
      case BudgetRecurrence.monthly:
        return 'Monthly';
      case BudgetRecurrence.quarterly:
        return 'Quarterly';
      case BudgetRecurrence.yearly:
        return 'Yearly';
      case BudgetRecurrence.custom:
        return 'Custom';
    }
  }

  String get rpcValue {
    switch (this) {
      case BudgetRecurrence.weekly:
        return 'weekly';
      case BudgetRecurrence.monthly:
        return 'monthly';
      case BudgetRecurrence.quarterly:
        return 'quarterly';
      case BudgetRecurrence.yearly:
        return 'yearly';
      case BudgetRecurrence.custom:
        return 'custom';
    }
  }
}

extension BudgetStatusX on BudgetStatus {
  String get label {
    switch (this) {
      case BudgetStatus.ok:
        return 'On track';
      case BudgetStatus.warning:
        return 'Approaching limit';
      case BudgetStatus.exceeded:
        return 'Exceeded';
    }
  }
}

@freezed
class BudgetAlert with _$BudgetAlert {
  const factory BudgetAlert({
    required String id,
    required String type,
    required String status,
    required double? amount,
    required double? thresholdPercent,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) = _BudgetAlert;
}

@freezed
class BudgetTrendPoint with _$BudgetTrendPoint {
  const factory BudgetTrendPoint({
    required String label,
    required double value,
  }) = _BudgetTrendPoint;
}

@freezed
class BudgetSummary with _$BudgetSummary {
  const factory BudgetSummary({
    required String id,
    required String label,
    required double amount,
    required double spent,
    required double remaining,
    required double threshold,
    required double thresholdPercent,
    required double progress,
    required BudgetStatus status,
    required BudgetRecurrence recurrence,
    required DateTime periodStart,
    required DateTime periodEnd,
    DateTime? resetOn,
    String? categoryId,
    String? categoryLabel,
    String? categoryColor,
    required List<BudgetAlert> alerts,
    required List<BudgetTrendPoint> trend,
    Map<String, dynamic>? metadata,
  }) = _BudgetSummary;
}

@freezed
class BudgetOverview with _$BudgetOverview {
  const factory BudgetOverview({
    required DateTime periodStart,
    required DateTime periodEnd,
    required double totalLimit,
    required double totalSpent,
    required double remaining,
    required int warningCount,
    required int criticalCount,
    required List<BudgetSummary> budgets,
  }) = _BudgetOverview;
}
