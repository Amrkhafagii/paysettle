import '../entities/budget.dart';

class BudgetRequest {
  BudgetRequest({
    required this.label,
    required this.amount,
    required this.thresholdPercent,
    required this.currency,
    required this.recurrence,
    this.categoryId,
  });

  final String label;
  final double amount;
  final double thresholdPercent;
  final String currency;
  final BudgetRecurrence recurrence;
  final String? categoryId;
}
