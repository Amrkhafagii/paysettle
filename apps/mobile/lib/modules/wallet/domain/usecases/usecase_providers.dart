import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/wallet_overview.dart';
import '../repositories/wallet_repository.dart';
import '../../data/repositories/wallet_repository_impl.dart';
import 'get_wallet_history.dart';
import 'get_wallet_overview.dart';

final getWalletOverviewUseCaseProvider = Provider<GetWalletOverviewUseCase>((ref) {
  return GetWalletOverviewUseCase(ref.watch(walletRepositoryProvider));
});

final getWalletHistoryUseCaseProvider = Provider<GetWalletHistoryUseCase>((ref) {
  return GetWalletHistoryUseCase(ref.watch(walletRepositoryProvider));
});

final selectedWalletTimeframeProvider = StateProvider<WalletTimeframe>((ref) {
  return WalletTimeframe.month;
});
