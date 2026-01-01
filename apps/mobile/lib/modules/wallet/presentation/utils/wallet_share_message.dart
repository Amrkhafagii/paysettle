import '../../domain/entities/wallet_overview.dart';

String buildWalletShareMessage(WalletOverview overview) {
  final buffer = StringBuffer()
    ..writeln('PaySettle Wallet Summary')
    ..writeln('Total Balance: EGP ${overview.totalBalance.toStringAsFixed(2)}')
    ..writeln('Owed: EGP ${overview.totalOwed.toStringAsFixed(2)} • Due: EGP ${overview.totalDue.toStringAsFixed(2)}');

  if (overview.collectFrom.isNotEmpty) {
    buffer.writeln('\nCollect from:');
    for (final entry in overview.collectFrom.take(3)) {
      buffer.writeln('• ${entry.name} → EGP ${entry.amount.toStringAsFixed(2)}');
    }
  }
  if (overview.payTo.isNotEmpty) {
    buffer.writeln('\nPay to:');
    for (final entry in overview.payTo.take(3)) {
      buffer.writeln('• ${entry.name} → EGP ${entry.amount.toStringAsFixed(2)}');
    }
  }
  buffer.writeln('\nSettle via PaySettle and keep everyone in sync.');
  return buffer.toString();
}
