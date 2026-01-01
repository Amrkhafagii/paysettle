import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/budget.dart';
import '../../domain/entities/budget_category.dart';
import '../../domain/value_objects/budget_range.dart';

class BudgetingState {
  const BudgetingState({
    required this.overview,
    required this.categories,
    required this.range,
    required this.isCreating,
  });

  factory BudgetingState.initial() => BudgetingState(
        overview: const AsyncValue.loading(),
        categories: const AsyncValue.loading(),
        range: BudgetRange.current,
        isCreating: false,
      );

  final AsyncValue<BudgetOverview> overview;
  final AsyncValue<List<BudgetCategoryOption>> categories;
  final BudgetRange range;
  final bool isCreating;

  BudgetingState copyWith({
    AsyncValue<BudgetOverview>? overview,
    AsyncValue<List<BudgetCategoryOption>>? categories,
    BudgetRange? range,
    bool? isCreating,
  }) {
    return BudgetingState(
      overview: overview ?? this.overview,
      categories: categories ?? this.categories,
      range: range ?? this.range,
      isCreating: isCreating ?? this.isCreating,
    );
  }
}
