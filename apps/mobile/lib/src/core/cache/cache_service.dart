import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cache_box.dart';

abstract class CacheService {
  Future<void> init();
  Future<void> write(CacheBox box, String key, Object? value);
  T? read<T>(CacheBox box, String key);
  Future<void> delete(CacheBox box, String key);
  Future<void> clear(CacheBox box);
}

final cacheServiceProvider =
    Provider<CacheService>((ref) => throw UnimplementedError());
