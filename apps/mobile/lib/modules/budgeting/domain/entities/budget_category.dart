import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_category.freezed.dart';

@freezed
class BudgetCategoryOption with _$BudgetCategoryOption {
  const factory BudgetCategoryOption({
    required String id,
    required String label,
    String? icon,
    String? color,
    @Default(false) bool isSystem,
  }) = _BudgetCategoryOption;
}
