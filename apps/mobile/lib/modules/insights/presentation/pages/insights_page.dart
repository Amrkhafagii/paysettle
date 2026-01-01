import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/theme/tokens.dart';
import '../../../../src/core/utils/color_utils.dart';
import '../../domain/entities/insight.dart';
import '../../domain/value_objects/insights_range.dart';
import '../controllers/insights_controller.dart';
import '../state/insights_state.dart';

class InsightsPage extends ConsumerWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(insightsControllerProvider);
    final controller = ref.read(insightsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Insights & Reports')),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: state.dashboard.when(
          loading: () => const _InsightsLoading(),
          error: (error, _) => _InsightsError(
            message: error.toString(),
            onRetry: controller.refresh,
          ),
          data: (dashboard) => _InsightsContent(
            dashboard: dashboard,
            state: state,
            onRangeChanged: controller.selectRange,
          ),
        ),
      ),
    );
  }
}

class _InsightsLoading extends StatelessWidget {
  const _InsightsLoading();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Spacing.lg),
      children: const [
        LinearProgressIndicator(),
        SizedBox(height: Spacing.lg),
        LinearProgressIndicator(),
      ],
    );
  }
}

class _InsightsError extends StatelessWidget {
  const _InsightsError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Spacing.lg),
      children: [
        Text('Insights unavailable',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.xs),
        Text(message),
        const SizedBox(height: Spacing.md),
        FilledButton(onPressed: onRetry, child: const Text('Retry')),
      ],
    );
  }
}

class _InsightsContent extends StatelessWidget {
  const _InsightsContent({
    required this.dashboard,
    required this.state,
    required this.onRangeChanged,
  });

  final InsightsDashboard dashboard;
  final InsightsState state;
  final void Function(InsightsRange range) onRangeChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding:
          const EdgeInsets.fromLTRB(Spacing.lg, Spacing.lg, Spacing.lg, 120),
      children: [
        _InsightsRangeSelector(
          selected: state.range,
          onChanged: onRangeChanged,
        ),
        const SizedBox(height: Spacing.md),
        _InsightsHero(dashboard: dashboard),
        const SizedBox(height: Spacing.lg),
        Text('Spending trend', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.sm),
        SizedBox(
          height: 220,
          child: _TrendChart(points: dashboard.trend),
        ),
        const SizedBox(height: Spacing.lg),
        Text('Category breakdown',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.sm),
        _CategoryBreakdownChart(categories: dashboard.categories),
        const SizedBox(height: Spacing.lg),
        Text('Recent activity', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.sm),
        ...dashboard.recentActivities.map(
          (activity) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: AppColors.neutral100,
              child: Text(activity.label.substring(0, 1)),
            ),
            title: Text(activity.label),
            subtitle: Text(
                '${activity.occurredOn.day}/${activity.occurredOn.month} • ${activity.notes ?? 'No notes'}'),
            trailing: Text(
              '${activity.amount.toStringAsFixed(0)} ${activity.currency}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }
}

class _InsightsRangeSelector extends StatelessWidget {
  const _InsightsRangeSelector({
    required this.selected,
    required this.onChanged,
  });

  final InsightsRange selected;
  final void Function(InsightsRange range) onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<InsightsRange>(
      segments: InsightsRange.values
          .map((range) => ButtonSegment(
                value: range,
                label: Text(range.label),
              ))
          .toList(growable: false),
      selected: {selected},
      onSelectionChanged: (value) => onChanged(value.first),
    );
  }
}

class _InsightsHero extends StatelessWidget {
  const _InsightsHero({required this.dashboard});

  final InsightsDashboard dashboard;

  @override
  Widget build(BuildContext context) {
    final change = dashboard.changePercent;
    final changeColor = change == null
        ? AppColors.neutral600
        : (change >= 0 ? AppColors.error : AppColors.brandMint500);
    final changeLabel = change == null
        ? 'No baseline'
        : '${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}% vs previous';

    return Wrap(
      spacing: Spacing.md,
      runSpacing: Spacing.md,
      children: [
        _HeroCard(
          label: 'Total spent',
          value: dashboard.totalSpent,
          currency: dashboard.currency,
        ),
        _HeroCard(
          label: 'Avg / day',
          value: dashboard.averageDaily,
          currency: dashboard.currency,
        ),
        Container(
          width: 160,
          padding: const EdgeInsets.all(Spacing.md),
          decoration: BoxDecoration(
            color: AppColors.neutral50,
            borderRadius: BorderRadius.circular(Radii.card),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Change', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: Spacing.xs),
              Text(
                changeLabel,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: changeColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.label,
    required this.value,
    required this.currency,
  });

  final String label;
  final double value;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceAccent,
        borderRadius: BorderRadius.circular(Radii.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: Spacing.xs),
          Text(
            '${value.toStringAsFixed(0)} $currency',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppColors.brandMint700),
          ),
        ],
      ),
    );
  }
}

class _TrendChart extends StatelessWidget {
  const _TrendChart({required this.points});

  final List<InsightsTrendPoint> points;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return const Center(child: Text('No trend data yet'));
    }
    final spots = <FlSpot>[];
    for (var i = 0; i < points.length; i++) {
      spots.add(FlSpot(i.toDouble(), points[i].value));
    }
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              interval: spots.isEmpty ? 1 : null,
            ),
          ),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= points.length) {
                  return const SizedBox.shrink();
                }
                final shouldShow = index == 0 ||
                    index == points.length - 1 ||
                    index == (points.length ~/ 2);
                return shouldShow
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(points[index].label,
                            style: const TextStyle(fontSize: 10)),
                      )
                    : const SizedBox.shrink();
              },
            ),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: const LineTouchData(enabled: true),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: AppColors.brandMint500,
            barWidth: 3,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.brandMint200.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryBreakdownChart extends StatelessWidget {
  const _CategoryBreakdownChart({required this.categories});

  final List<InsightCategoryBreakdown> categories;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(Spacing.lg),
          child: Text('No categories recorded this period'),
        ),
      );
    }
    final sections = categories.map((category) {
      final color =
          parseHexColor(category.color, fallback: AppColors.brandMint400);
      return PieChartSectionData(
        color: color,
        value: category.value,
        title: '${category.percent.toStringAsFixed(0)}%',
        radius: 60,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      );
    }).toList(growable: false);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: Spacing.md),
            Wrap(
              spacing: Spacing.md,
              runSpacing: Spacing.sm,
              children: categories
                  .map(
                    (category) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: parseHexColor(category.color,
                                fallback: AppColors.brandMint400),
                          ),
                        ),
                        const SizedBox(width: Spacing.xs),
                        Text(
                            '${category.label} (${category.value.toStringAsFixed(0)})'),
                      ],
                    ),
                  )
                  .toList(growable: false),
            ),
          ],
        ),
      ),
    );
  }
}
