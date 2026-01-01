import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/theme/tokens.dart';
import '../../../../src/core/utils/color_utils.dart';
import '../../domain/entities/budget.dart';
import '../../domain/entities/budget_category.dart';
import '../../domain/value_objects/budget_range.dart';
import '../../domain/value_objects/budget_request.dart';
import '../controllers/budgeting_controller.dart';
import '../state/budgeting_state.dart';

class BudgetingPage extends ConsumerWidget {
  const BudgetingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(budgetingControllerProvider);
    final controller = ref.read(budgetingControllerProvider.notifier);
    final categories = state.categories.maybeWhen(
      data: (items) => items,
      orElse: () => const <BudgetCategoryOption>[],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: controller.refresh,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: state.overview.when(
          loading: () => const _BudgetLoading(),
          error: (error, _) => _BudgetError(
            message: error.toString(),
            onRetry: controller.refresh,
          ),
          data: (overview) => _BudgetContent(
            overview: overview,
            state: state,
            onRangeChanged: controller.selectRange,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: state.isCreating
            ? null
            : () => _showAddBudgetSheet(
                  context,
                  categories: categories,
                  onSubmit: (request) => controller.createBudget(request),
                ),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add budget'),
      ),
    );
  }

  Future<void> _showAddBudgetSheet(
    BuildContext context, {
    required List<BudgetCategoryOption> categories,
    required Future<void> Function(BudgetRequest request) onSubmit,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
        ),
        child: AddBudgetSheet(
          categories: categories,
          onSubmit: onSubmit,
        ),
      ),
    );
  }
}

class _BudgetLoading extends StatelessWidget {
  const _BudgetLoading();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(Spacing.lg),
      itemCount: 3,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.only(bottom: Spacing.md),
        child: const ListTile(
          title: LinearProgressIndicator(),
          subtitle: SizedBox(height: 48),
        ),
      ),
    );
  }
}

class _BudgetError extends StatelessWidget {
  const _BudgetError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Spacing.lg),
      children: [
        Icon(Icons.error_outline_rounded,
            color: Theme.of(context).colorScheme.error, size: 48),
        const SizedBox(height: Spacing.sm),
        Text('Unable to load budgets',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.xs),
        Text(message, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: Spacing.md),
        FilledButton(onPressed: onRetry, child: const Text('Try again')),
      ],
    );
  }
}

class _BudgetContent extends StatelessWidget {
  const _BudgetContent({
    required this.overview,
    required this.state,
    required this.onRangeChanged,
  });

  final BudgetOverview overview;
  final BudgetingState state;
  final void Function(BudgetRange range) onRangeChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding:
          const EdgeInsets.fromLTRB(Spacing.lg, Spacing.lg, Spacing.lg, 120),
      children: [
        _BudgetRangeSelector(
          selected: state.range,
          onChanged: onRangeChanged,
        ),
        const SizedBox(height: Spacing.md),
        _BudgetOverviewHeader(overview: overview),
        const SizedBox(height: Spacing.lg),
        Text('Category budgets',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.sm),
        ...overview.budgets.map(
          (budget) => Padding(
            padding: const EdgeInsets.only(bottom: Spacing.md),
            child: _BudgetCard(budget: budget),
          ),
        ),
        if (overview.budgets.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Column(
                children: [
                  const Icon(Icons.blur_on_rounded, size: 48),
                  const SizedBox(height: Spacing.sm),
                  Text(
                    'No budgets yet',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: Spacing.xs),
                  Text(
                    'Create a budget to keep tabs on each spending category.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _BudgetRangeSelector extends StatelessWidget {
  const _BudgetRangeSelector({
    required this.selected,
    required this.onChanged,
  });

  final BudgetRange selected;
  final void Function(BudgetRange range) onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<BudgetRange>(
      style: SegmentedButton.styleFrom(
        backgroundColor: AppColors.neutral50,
      ),
      segments: BudgetRange.values
          .map((range) => ButtonSegment(
                value: range,
                label: Text(range.label),
              ))
          .toList(),
      selected: {selected},
      onSelectionChanged: (value) => onChanged(value.first),
    );
  }
}

class _BudgetOverviewHeader extends StatelessWidget {
  const _BudgetOverviewHeader({required this.overview});

  final BudgetOverview overview;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cards = [
      _OverviewTile(
        label: 'Total limit',
        value: overview.totalLimit,
        color: AppColors.brandMint600,
      ),
      _OverviewTile(
        label: 'Spent',
        value: overview.totalSpent,
        color: AppColors.chartWalletNegative,
      ),
      _OverviewTile(
        label: 'Remaining',
        value: overview.remaining,
        color: AppColors.chartWalletPositive,
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: Spacing.md,
          runSpacing: Spacing.md,
          children: cards,
        ),
        const SizedBox(height: Spacing.md),
        Row(
          children: [
            _StatusPill(
              icon: Icons.warning_rounded,
              label: '${overview.warningCount} near limit',
              color: AppColors.warning,
            ),
            const SizedBox(width: Spacing.sm),
            _StatusPill(
              icon: Icons.error_outline_rounded,
              label: '${overview.criticalCount} exceeded',
              color: AppColors.error,
            ),
          ],
        ),
        const SizedBox(height: Spacing.xs),
        Text(
          'Period ${_formatDate(overview.periodStart)} – ${_formatDate(overview.periodEnd)}',
          style: textTheme.labelMedium,
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}';
  }
}

class _OverviewTile extends StatelessWidget {
  const _OverviewTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(Radii.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: Spacing.xs),
          Text(
            '${value.toStringAsFixed(0)} EGP',
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Spacing.xs,
        horizontal: Spacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(Radii.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: Spacing.xs),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}

class _BudgetCard extends StatelessWidget {
  const _BudgetCard({required this.budget});

  final BudgetSummary budget;

  @override
  Widget build(BuildContext context) {
    final percent = (budget.progress / 100).clamp(0, 1);
    final indicatorColor = switch (budget.status) {
      BudgetStatus.ok => AppColors.brandMint500,
      BudgetStatus.warning => AppColors.warning,
      BudgetStatus.exceeded => AppColors.error,
    };
    final categoryColor =
        parseHexColor(budget.categoryColor, fallback: AppColors.neutral200);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radii.card),
        side: BorderSide(color: AppColors.neutral100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(budget.label,
                          style: Theme.of(context).textTheme.titleMedium),
                      if (budget.categoryLabel != null) ...[
                        const SizedBox(height: Spacing.xs),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: categoryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: Spacing.xs),
                            Text(
                              budget.categoryLabel!,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ]
                    ],
                  ),
                ),
                _StatusChip(status: budget.status),
              ],
            ),
            const SizedBox(height: Spacing.md),
            ClipRRect(
              borderRadius: BorderRadius.circular(Radii.pill),
              child: LinearProgressIndicator(
                value: percent,
                minHeight: 8,
                backgroundColor: AppColors.neutral100,
                color: indicatorColor,
              ),
            ),
            const SizedBox(height: Spacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${budget.spent.toStringAsFixed(0)} spent'),
                Text('${budget.remaining.toStringAsFixed(0)} remaining'),
              ],
            ),
            const SizedBox(height: Spacing.sm),
            Text(
              'Threshold ${budget.thresholdPercent.toStringAsFixed(0)}% • reset ${_resetLabel(budget)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (budget.alerts.isNotEmpty) ...[
              const Divider(height: Spacing.xl),
              Wrap(
                spacing: Spacing.sm,
                runSpacing: Spacing.sm,
                children: budget.alerts
                    .map((alert) => _AlertChip(alert: alert))
                    .toList(growable: false),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _resetLabel(BudgetSummary budget) {
    if (budget.resetOn == null) {
      return budget.recurrence.label;
    }
    return '${budget.resetOn!.day}/${budget.resetOn!.month}';
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final BudgetStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      BudgetStatus.ok => AppColors.brandMint500,
      BudgetStatus.warning => AppColors.warning,
      BudgetStatus.exceeded => AppColors.error,
    };
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Spacing.sm, vertical: Spacing.xs),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(Radii.chip),
      ),
      child: Text(
        status.label,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _AlertChip extends StatelessWidget {
  const _AlertChip({required this.alert});

  final BudgetAlert alert;

  @override
  Widget build(BuildContext context) {
    final isCritical = alert.type == 'critical';
    final color = isCritical ? AppColors.error : AppColors.warning;
    final text = isCritical
        ? 'Limit exceeded'
        : 'Reached ${alert.thresholdPercent?.toStringAsFixed(0) ?? '80'}%';
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Spacing.xs,
        horizontal: Spacing.sm,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.chip),
        color: color.withOpacity(0.12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCritical ? Icons.error_rounded : Icons.warning_amber_rounded,
            size: 14,
            color: color,
          ),
          const SizedBox(width: Spacing.xs),
          Text(text, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}

class AddBudgetSheet extends StatefulWidget {
  const AddBudgetSheet({
    super.key,
    required this.categories,
    required this.onSubmit,
  });

  final List<BudgetCategoryOption> categories;
  final Future<void> Function(BudgetRequest request) onSubmit;

  @override
  State<AddBudgetSheet> createState() => _AddBudgetSheetState();
}

class _AddBudgetSheetState extends State<AddBudgetSheet> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _amountController = TextEditingController();
  final _thresholdController = TextEditingController(text: '80');
  BudgetRecurrence _recurrence = BudgetRecurrence.monthly;
  String? _selectedCategoryId;
  bool _submitting = false;

  @override
  void dispose() {
    _labelController.dispose();
    _amountController.dispose();
    _thresholdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          Spacing.lg, Spacing.lg, Spacing.lg, Spacing.xl),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('New budget', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: Spacing.md),
            TextFormField(
              controller: _labelController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter a label' : null,
            ),
            const SizedBox(height: Spacing.sm),
            DropdownButtonFormField<String>(
              value: _selectedCategoryId,
              decoration: const InputDecoration(labelText: 'Category'),
              items: widget.categories
                  .map((category) => DropdownMenuItem(
                        value: category.id,
                        child: Text(category.label),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedCategoryId = value),
            ),
            const SizedBox(height: Spacing.sm),
            TextFormField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Amount (EGP)',
              ),
              validator: (value) {
                final amount = double.tryParse(value ?? '');
                if (amount == null || amount <= 0) {
                  return 'Enter a positive amount';
                }
                return null;
              },
            ),
            const SizedBox(height: Spacing.sm),
            TextFormField(
              controller: _thresholdController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Alert threshold %',
              ),
              validator: (value) {
                final percent = double.tryParse(value ?? '');
                if (percent == null || percent <= 0 || percent > 100) {
                  return '0 - 100';
                }
                return null;
              },
            ),
            const SizedBox(height: Spacing.sm),
            DropdownButtonFormField<BudgetRecurrence>(
              value: _recurrence,
              decoration: const InputDecoration(labelText: 'Recurrence'),
              items: BudgetRecurrence.values
                  .map((recurrence) => DropdownMenuItem(
                        value: recurrence,
                        child: Text(recurrence.label),
                      ))
                  .toList(),
              onChanged: (value) => setState(
                  () => _recurrence = value ?? BudgetRecurrence.monthly),
            ),
            const SizedBox(height: Spacing.lg),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _submitting ? null : _handleSubmit,
                child: _submitting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Create budget'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _submitting = true);
    final request = BudgetRequest(
      label: _labelController.text.trim(),
      amount: double.parse(_amountController.text.trim()),
      thresholdPercent: double.parse(_thresholdController.text.trim()),
      currency: 'EGP',
      recurrence: _recurrence,
      categoryId: _selectedCategoryId,
    );
    try {
      await widget.onSubmit(request);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }
}
