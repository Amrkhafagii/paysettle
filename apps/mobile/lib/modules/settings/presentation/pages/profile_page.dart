import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../src/theme/tokens.dart';
import '../../../wallet/domain/entities/wallet_overview.dart';
import '../../../wallet/presentation/controllers/wallet_controller.dart';
import '../../../wallet/presentation/utils/wallet_share_message.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletControllerProvider);
    final formatter = NumberFormat.currency(symbol: 'EGP ');

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: walletState.overview.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
        data: (overview) => ListView(
          padding: const EdgeInsets.all(Spacing.lg),
          children: [
            _ProfileHeader(overview: overview),
            const SizedBox(height: Spacing.lg),
            _TotalsCard(overview: overview, formatter: formatter),
            const SizedBox(height: Spacing.lg),
            _PendingOrders(overview: overview, formatter: formatter),
            const SizedBox(height: Spacing.lg),
            _PaymentMethodsList(methods: overview.paymentMethods),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.overview});

  final WalletOverview overview;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(radius: 32, child: Icon(Icons.person)),
        title: const Text('Amr Khafagi', style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: const Text('PaySettle Pro Member'),
        trailing: IconButton(
          icon: const Icon(Icons.share_rounded),
          onPressed: () => Share.share(buildWalletShareMessage(overview)),
        ),
      ),
    );
  }
}

class _TotalsCard extends StatelessWidget {
  const _TotalsCard({required this.overview, required this.formatter});

  final WalletOverview overview;
  final NumberFormat formatter;

  @override
  Widget build(BuildContext context) {
    final netColor = overview.totalBalance >= 0
        ? AppColors.chartWalletPositive
        : AppColors.chartWalletNegative;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.card)),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Wallet Totals', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: Spacing.md),
            _SummaryRow(label: 'Total Owed', value: formatter.format(overview.totalOwed)),
            _SummaryRow(label: 'Total Due', value: formatter.format(overview.totalDue)),
            Divider(color: AppColors.neutral100, height: Spacing.lg),
            Row(
              children: [
                const Text('Net Value', style: TextStyle(fontWeight: FontWeight.w600)),
                const Spacer(),
                Text(
                  formatter.format(overview.totalBalance),
                  style: TextStyle(color: netColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: Spacing.md),
            FilledButton(
              onPressed: overview.payTo.isEmpty ? null : () {},
              child: Text(
                overview.payTo.isEmpty
                    ? 'All Settled'
                    : 'Settle with ${overview.payTo.first.name.split(' ').first}',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.xs),
      child: Row(
        children: [
          Text(label),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _PendingOrders extends StatelessWidget {
  const _PendingOrders({required this.overview, required this.formatter});

  final WalletOverview overview;
  final NumberFormat formatter;

  @override
  Widget build(BuildContext context) {
    if (overview.collectFrom.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pending Orders', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.sm),
        ...overview.collectFrom.map((entry) => Card(
              child: ListTile(
                title: Text(entry.name,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('Due ${_formatDate(entry.dueDate)}'),
                trailing: Text(formatter.format(entry.amount)),
              ),
            )),
      ],
    );
  }

  static String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Soon';
    }
    return DateFormat('MMM d').format(date);
  }
}

class _PaymentMethodsList extends StatelessWidget {
  const _PaymentMethodsList({required this.methods});

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
        ...methods.map((method) => Card(
              child: ListTile(
                leading: Icon(Icons.account_balance_wallet,
                    color: method.isPrimary
                        ? AppColors.brandMint600
                        : AppColors.neutral500),
                title: Text(method.label),
                subtitle: Text(method.provider),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(method.accountNumber ?? '—'),
                    if (method.isPrimary)
                      const Text('Primary',
                          style: TextStyle(
                              color: AppColors.brandMint600,
                              fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
