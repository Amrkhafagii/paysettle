enum BudgetRange { previous, current, upcoming }

extension BudgetRangeX on BudgetRange {
  String get label {
    switch (this) {
      case BudgetRange.previous:
        return 'Last month';
      case BudgetRange.current:
        return 'This month';
      case BudgetRange.upcoming:
        return 'Next month';
    }
  }

  DateTime resolveStart(DateTime now) {
    final firstOfMonth = DateTime(now.year, now.month, 1);
    switch (this) {
      case BudgetRange.previous:
        final prev = DateTime(firstOfMonth.year, firstOfMonth.month - 1, 1);
        return prev;
      case BudgetRange.current:
        return firstOfMonth;
      case BudgetRange.upcoming:
        return DateTime(firstOfMonth.year, firstOfMonth.month + 1, 1);
    }
  }
}
