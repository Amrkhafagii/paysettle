import '../entities/wallet_overview.dart';
import '../repositories/wallet_repository.dart';

class GetWalletHistoryUseCase {
  const GetWalletHistoryUseCase(this._repository);

  final WalletRepository _repository;

  Future<List<WalletCounterparty>> call({WalletDirection? direction}) {
    return _repository.fetchHistory(direction: direction);
  }
}
