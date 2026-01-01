import '../entities/wallet_overview.dart';

abstract class WalletRepository {
  Future<WalletOverview> fetchOverview(WalletTimeframe timeframe);
  Future<List<WalletCounterparty>> fetchHistory({WalletDirection? direction});
}
