import '../../domain/entities/budget_category.dart';

class BudgetCategoryDto {
  BudgetCategoryDto({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
    required this.isSystem,
  });

  factory BudgetCategoryDto.fromMap(Map<String, dynamic> map) {
    return BudgetCategoryDto(
      id: '${map['id']}',
      label: '${map['label'] ?? ''}',
      icon: map['icon']?.toString(),
      color: map['color']?.toString(),
      isSystem: (map['kind'] ?? 'system') == 'system',
    );
  }

  final String id;
  final String label;
  final String? icon;
  final String? color;
  final bool isSystem;

  BudgetCategoryOption toDomain() {
    return BudgetCategoryOption(
      id: id,
      label: label,
      icon: icon,
      color: color,
      isSystem: isSystem,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'icon': icon,
      'color': color,
      'kind': isSystem ? 'system' : 'custom',
    };
  }
}
