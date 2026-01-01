import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/wallet_overview.dart';

class WalletState {
  const WalletState({
    required this.overview,
    required this.history,
    required this.timeframe,
  });

  factory WalletState.initial() => WalletState(
        overview: const AsyncValue.loading(),
        history: const AsyncValue.loading(),
        timeframe: WalletTimeframe.month,
      );

  final AsyncValue<WalletOverview> overview;
  final AsyncValue<List<WalletCounterparty>> history;
  final WalletTimeframe timeframe;

  WalletState copyWith({
    AsyncValue<WalletOverview>? overview,
    AsyncValue<List<WalletCounterparty>>? history,
    WalletTimeframe? timeframe,
  }) {
    return WalletState(
      overview: overview ?? this.overview,
      history: history ?? this.history,
      timeframe: timeframe ?? this.timeframe,
    );
  }
}
