import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/cache/cache_box.dart';
import '../../../../src/core/cache/cache_service.dart';
import '../../domain/entities/wallet_overview.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_demo_data_source.dart';
import '../datasources/wallet_remote_data_source.dart';
import '../dtos/wallet_overview_dto.dart';

class WalletRepositoryImpl implements WalletRepository {
  WalletRepositoryImpl({
    required WalletRemoteDataSource remoteDataSource,
    required WalletDemoDataSource demoDataSource,
    required CacheService cacheService,
  })  : _remoteDataSource = remoteDataSource,
        _demoDataSource = demoDataSource,
        _cacheService = cacheService;

  final WalletRemoteDataSource _remoteDataSource;
  final WalletDemoDataSource _demoDataSource;
  final CacheService _cacheService;

  static const String _overviewCachePrefix = 'wallet_overview_v1_';
  static const String _historyCacheKey = 'wallet_history_v1';

  @override
  Future<WalletOverview> fetchOverview(WalletTimeframe timeframe) async {
    final cacheKey = '$_overviewCachePrefix${timeframe.name}';
    try {
      final dto = await _remoteDataSource.fetchOverview(timeframe: timeframe);
      if (dto != null) {
        await _cacheService.write(CacheBox.core, cacheKey, dto.toJson());
        return dto.toDomain(timeframe);
      }
    } catch (_) {
      final cached = _cacheService.read<Map<dynamic, dynamic>>(CacheBox.core, cacheKey);
      if (cached != null) {
        final normalized = cached.map<String, dynamic>(
            (key, value) => MapEntry(key.toString(), value));
        return WalletOverviewDto.fromMap(normalized).toDomain(timeframe);
      }
    }

    final fallback = await _demoDataSource.loadOverview(timeframe: timeframe);
    return fallback.toDomain(timeframe);
  }

  @override
  Future<List<WalletCounterparty>> fetchHistory({WalletDirection? direction}) async {
    try {
      final history = await _remoteDataSource.fetchHistory(direction: direction);
      if (direction == null) {
        await _cacheService.write(
          CacheBox.core,
          _historyCacheKey,
          history
              .map((entry) => {
                    'transactionId': entry.transactionId,
                    'contactId': entry.contactId,
                    'journeyId': entry.journeyId,
                    'name': entry.name,
                    'amount': entry.amount,
                    'status': entry.status,
                    'direction': entry.direction.name,
                    'issueDate': entry.issueDate?.toIso8601String(),
                    'dueDate': entry.dueDate?.toIso8601String(),
                  })
              .toList(growable: false),
        );
      }
      return history;
    } catch (_) {
      final cached =
          _cacheService.read<List<dynamic>>(CacheBox.core, _historyCacheKey);
      if (cached == null) {
        return const [];
      }
      return cached
          .whereType<Map>()
          .map((entry) => WalletCounterparty(
                transactionId: '${entry['transactionId'] ?? ''}',
                contactId: entry['contactId']?.toString(),
                journeyId: entry['journeyId']?.toString(),
                name: '${entry['name'] ?? 'Unassigned'}',
                amount: walletDtoToDouble(entry['amount']),
                status: '${entry['status'] ?? 'open'}',
                direction: _directionFrom(entry['direction']),
                issueDate: walletDtoParseDate(entry['issueDate']),
                dueDate: walletDtoParseDate(entry['dueDate']),
              ))
          .toList(growable: false);
    }
  }

  WalletDirection _directionFrom(dynamic raw) {
    final value = raw?.toString().toLowerCase();
    return value == 'pay' ? WalletDirection.pay : WalletDirection.collect;
  }
}

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return WalletRepositoryImpl(
    remoteDataSource: ref.watch(walletRemoteDataSourceProvider),
    demoDataSource: WalletDemoDataSource(),
    cacheService: ref.watch(cacheServiceProvider),
  );
});
