import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/wallet_overview.dart';
import '../../domain/usecases/get_wallet_history.dart';
import '../../domain/usecases/get_wallet_overview.dart';
import '../../domain/usecases/usecase_providers.dart';
import '../state/wallet_state.dart';

class WalletController extends StateNotifier<WalletState> {
  WalletController({
    required GetWalletOverviewUseCase getWalletOverview,
    required GetWalletHistoryUseCase getWalletHistory,
  })  : _getWalletOverview = getWalletOverview,
        _getWalletHistory = getWalletHistory,
        super(WalletState.initial()) {
    load();
  }

  final GetWalletOverviewUseCase _getWalletOverview;
  final GetWalletHistoryUseCase _getWalletHistory;

  Future<void> load({WalletTimeframe? timeframe}) async {
    final effectiveTimeframe = timeframe ?? state.timeframe;
    state = state.copyWith(
      timeframe: effectiveTimeframe,
      overview: const AsyncValue.loading(),
      history: const AsyncValue.loading(),
    );

    final overview = await AsyncValue.guard(
      () => _getWalletOverview(timeframe: effectiveTimeframe),
    );
    final history = await AsyncValue.guard(() => _getWalletHistory());

    state = state.copyWith(overview: overview, history: history);
  }

  Future<void> refresh() => load(timeframe: state.timeframe);

  void selectTimeframe(WalletTimeframe timeframe) {
    if (timeframe == state.timeframe) {
      return;
    }
    load(timeframe: timeframe);
  }
}

final walletControllerProvider =
    StateNotifierProvider<WalletController, WalletState>((ref) {
  return WalletController(
    getWalletOverview: ref.watch(getWalletOverviewUseCaseProvider),
    getWalletHistory: ref.watch(getWalletHistoryUseCaseProvider),
  );
});
