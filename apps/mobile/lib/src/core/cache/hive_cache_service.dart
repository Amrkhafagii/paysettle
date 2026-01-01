import 'package:hive_flutter/hive_flutter.dart';

import 'cache_box.dart';
import 'cache_service.dart';

class HiveCacheService implements CacheService {
  HiveCacheService();

  final Map<CacheBox, Box<dynamic>> _boxes = {};

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    for (final cacheBox in CacheBox.values) {
      final box = await Hive.openBox<dynamic>(cacheBox.name);
      _boxes[cacheBox] = box;
    }
  }

  Box<dynamic> _box(CacheBox box) {
    final instance = _boxes[box];
    if (instance == null) {
      throw StateError('Cache box ${box.name} accessed before initialization.');
    }
    return instance;
  }

  @override
  Future<void> write(CacheBox box, String key, Object? value) async {
    await _box(box).put(key, value);
  }

  @override
  T? read<T>(CacheBox box, String key) {
    return _box(box).get(key) as T?;
  }

  @override
  Future<void> delete(CacheBox box, String key) async {
    await _box(box).delete(key);
  }

  @override
  Future<void> clear(CacheBox box) async {
    await _box(box).clear();
  }
}
