import '../entities/wallet_overview.dart';
import '../repositories/wallet_repository.dart';

class GetWalletOverviewUseCase {
  const GetWalletOverviewUseCase(this._repository);

  final WalletRepository _repository;

  Future<WalletOverview> call({required WalletTimeframe timeframe}) {
    return _repository.fetchOverview(timeframe);
  }
}
