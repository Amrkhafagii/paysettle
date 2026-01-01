import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../src/theme/tokens.dart';
import '../../domain/entities/wallet_overview.dart';
import '../controllers/wallet_controller.dart';
import '../state/wallet_state.dart';
import '../utils/wallet_share_message.dart';

class WalletPage extends ConsumerWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(walletControllerProvider);
    final controller = ref.watch(walletControllerProvider.notifier);

    final overview = state.overview.valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: overview == null
                ? null
                : () => Share.share(buildWalletShareMessage(overview)),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refresh,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: state.overview.when(
          loading: () => const _WalletLoadingView(),
          error: (error, stack) => _WalletErrorView(
            message: error.toString(),
            onRetry: controller.refresh,
          ),
          data: (overview) => _WalletContent(
            state: state,
            overview: overview,
            onChangeTimeframe: controller.selectTimeframe,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.currency_exchange_rounded),
        label: const Text('Settle All Payments'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _WalletLoadingView extends StatelessWidget {
  const _WalletLoadingView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: const [
        SizedBox(height: 220),
        Center(child: CircularProgressIndicator()),
      ],
    );
  }
}

class _WalletErrorView extends StatelessWidget {
  const _WalletErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 200),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
          child: Column(
            children: [
              Text('Something went wrong',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: Spacing.sm),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: Spacing.md),
              FilledButton(onPressed: onRetry, child: const Text('Try again')),
            ],
          ),
        ),
      ],
    );
  }
}

class _WalletContent extends StatelessWidget {
  const _WalletContent({
    required this.state,
    required this.overview,
    required this.onChangeTimeframe,
  });

  final WalletState state;
  final WalletOverview overview;
  final void Function(WalletTimeframe timeframe) onChangeTimeframe;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: 'EGP ');

    return ListView(
      padding: const EdgeInsets.fromLTRB(Spacing.lg, Spacing.lg, Spacing.lg, 120),
      children: [
        _WalletSummaryCard(overview: overview, formatter: formatter),
        const SizedBox(height: Spacing.lg),
        _WalletTimeframeSelector(
          selected: state.timeframe,
          onSelected: onChangeTimeframe,
        ),
        const SizedBox(height: Spacing.md),
        _WalletTrendChart(points: overview.trend),
        const SizedBox(height: Spacing.lg),
        _CounterpartySection(
          title: 'Collect From',
          entries: overview.collectFrom,
          formatter: formatter,
          positive: true,
        ),
        const SizedBox(height: Spacing.md),
        _CounterpartySection(
          title: 'Pay To',
          entries: overview.payTo,
          formatter: formatter,
          positive: false,
        ),
        const SizedBox(height: Spacing.lg),
        _SettlementLogSection(entries: overview.settlementLog, formatter: formatter),
        const SizedBox(height: Spacing.lg),
        _PaymentMethodsSection(methods: overview.paymentMethods),
      ],
    );
  }
}

class _WalletSummaryCard extends StatelessWidget {
  const _WalletSummaryCard({required this.overview, required this.formatter});

  final WalletOverview overview;
  final NumberFormat formatter;

  @override
  Widget build(BuildContext context) {
    final netColor = overview.totalBalance >= 0
        ? AppColors.chartWalletPositive
        : AppColors.chartWalletNegative;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radii.card),
      ),
      color: AppColors.brandMint50,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Balance', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: Spacing.sm),
            Text(
              formatter.format(overview.totalBalance),
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: netColor, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: Spacing.md),
            Row(
              children: [
                Expanded(
                  child: _SummaryTile(
                    label: 'Total Owed',
                    value: formatter.format(overview.totalOwed),
                  ),
                ),
                const SizedBox(width: Spacing.sm),
                Expanded(
                  child: _SummaryTile(
                    label: 'Total Due',
                    value: formatter.format(overview.totalDue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.md),
        color: AppColors.neutral0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: Spacing.xs),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _WalletTimeframeSelector extends StatelessWidget {
  const _WalletTimeframeSelector({
    required this.selected,
    required this.onSelected,
  });

  final WalletTimeframe selected;
  final void Function(WalletTimeframe timeframe) onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Spacing.sm,
      children: WalletTimeframe.values
          .map(
            (timeframe) => ChoiceChip(
              label: Text(timeframe.label),
              selected: timeframe == selected,
              onSelected: (_) => onSelected(timeframe),
              selectedColor: AppColors.brandMint200,
            ),
          )
          .toList(),
    );
  }
}

class _WalletTrendChart extends StatelessWidget {
  const _WalletTrendChart({required this.points});

  final List<WalletTrendPoint> points;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return const SizedBox.shrink();
    }
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.card)),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Spending Trends', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: Spacing.md),
            SizedBox(
              height: 180,
              child: CustomPaint(
                painter: _TrendChartPainter(points: points),
                child: const SizedBox.expand(),
              ),
            ),
            const SizedBox(height: Spacing.sm),
            Row(
              children: const [
                _LegendDot(color: AppColors.chartWalletPositive, label: 'Collect'),
                SizedBox(width: Spacing.md),
                _LegendDot(color: AppColors.chartWalletNegative, label: 'Pay'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: Spacing.xs),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _TrendChartPainter extends CustomPainter {
  _TrendChartPainter({required this.points});

  final List<WalletTrendPoint> points;

  @override
  void paint(Canvas canvas, Size size) {
    final maxValue = points
        .map((point) => point.collect > point.pay ? point.collect : point.pay)
        .fold<double>(0, (prev, value) => value > prev ? value : prev);
    final double chartHeight = size.height - 16;
    final int divisor = points.length <= 1 ? 1 : (points.length - 1);
    final double horizontalStep = divisor == 0 ? 0 : size.width / divisor;

    final collectPaint = Paint()
      ..color = AppColors.chartWalletPositive
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final payPaint = Paint()
      ..color = AppColors.chartWalletNegative
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final collectPath = Path();
    final payPath = Path();

    for (var i = 0; i < points.length; i++) {
      final x = i * horizontalStep;
      final collectY = chartHeight - (points[i].collect / (maxValue == 0 ? 1 : maxValue)) * chartHeight;
      final payY = chartHeight - (points[i].pay / (maxValue == 0 ? 1 : maxValue)) * chartHeight;
      if (i == 0) {
        collectPath.moveTo(x, collectY);
        payPath.moveTo(x, payY);
      } else {
        collectPath.lineTo(x, collectY);
        payPath.lineTo(x, payY);
      }
    }

    canvas.drawPath(collectPath, collectPaint);
    canvas.drawPath(payPath, payPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _CounterpartySection extends StatelessWidget {
  const _CounterpartySection({
    required this.title,
    required this.entries,
    required this.formatter,
    this.positive = true,
  });

  final String title;
  final List<WalletCounterparty> entries;
  final NumberFormat formatter;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.sm),
        ...entries.map((entry) => _CounterpartyTile(
              entry: entry,
              formatter: formatter,
              positive: positive,
            )),
      ],
    );
  }
}

class _CounterpartyTile extends StatelessWidget {
  const _CounterpartyTile({
    required this.entry,
    required this.formatter,
    required this.positive,
  });

  final WalletCounterparty entry;
  final NumberFormat formatter;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    final dueDate = entry.dueDate != null
        ? DateFormat('MMM d').format(entry.dueDate!)
        : 'Flexible';
    final issueDate = entry.issueDate != null
        ? DateFormat('MMM d').format(entry.issueDate!)
        : 'Today';

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              positive ? AppColors.brandMint200 : AppColors.neutral100,
          child: Text(entry.name.isNotEmpty ? entry.name[0] : '?'),
        ),
        title: Text(entry.name,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Row(
          children: [
            _InfoChip(label: 'Issue: $issueDate'),
            const SizedBox(width: Spacing.xs),
            _InfoChip(label: 'Due: $dueDate'),
          ],
        ),
        trailing: Text(
          formatter.format(entry.amount),
          style: TextStyle(
            color: positive ? AppColors.chartWalletPositive : AppColors.chartWalletNegative,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.sm, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.chip),
        color: AppColors.neutral50,
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}

class _SettlementLogSection extends StatelessWidget {
  const _SettlementLogSection({required this.entries, required this.formatter});

  final List<WalletSettlementLogEntry> entries;
  final NumberFormat formatter;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Settlements Log', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.sm),
        ...entries.map((entry) => Card(
              child: ListTile(
                leading: Icon(_iconForEvent(entry.eventType), color: AppColors.brandMint600),
                title: Text(entry.counterparty),
                subtitle: Text('${entry.eventType.name.toUpperCase()} • ${DateFormat('MMM d, HH:mm').format(entry.occurredAt)}'),
                trailing: entry.amount == null
                    ? null
                    : Text(formatter.format(entry.amount),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            )),
      ],
    );
  }

  IconData _iconForEvent(WalletSettlementEventType type) {
    switch (type) {
      case WalletSettlementEventType.request:
        return Icons.request_quote_rounded;
      case WalletSettlementEventType.reminder:
        return Icons.alarm_rounded;
      case WalletSettlementEventType.payment:
        return Icons.payments_rounded;
      case WalletSettlementEventType.note:
        return Icons.note_alt_rounded;
    }
  }
}

class _PaymentMethodsSection extends StatelessWidget {
  const _PaymentMethodsSection({required this.methods});

  final List<WalletPaymentMethod> methods;

  @override
  Widget build(BuildContext context) {
    if (methods.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Methods', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.sm),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _PaymentMethodCard(method: methods[index]),
            separatorBuilder: (_, __) => const SizedBox(width: Spacing.sm),
            itemCount: methods.length,
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  const _PaymentMethodCard({required this.method});

  final WalletPaymentMethod method;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.card),
        color: method.isPrimary ? AppColors.brandMint600 : AppColors.neutral50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(method.label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: method.isPrimary ? Colors.white : Colors.black,
                  )),
          const Spacer(),
          Text(method.provider,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: method.isPrimary ? Colors.white70 : AppColors.neutral600,
                  )),
          const SizedBox(height: Spacing.xs),
          Text(method.accountNumber ?? '—',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: method.isPrimary ? Colors.white : AppColors.neutral800,
                    fontWeight: FontWeight.w600,
                  )),
        ],
      ),
    );
  }
}
