import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'cache_manager.dart';
import 'cache_service.dart';

class CacheRepository {
  static final CacheRepository _instance = CacheRepository._internal();
  final Map<String, Uint8List> memoryCache = {};
  final CustomCacheManager _cacheManager = CustomCacheManager();
  Color color = Colors.white;

  factory CacheRepository() => _instance;

  CacheRepository._internal();

  Future<void> init({Color? newColor}) async {
    color = newColor ?? Colors.white;
    await _preloadCache();
  }

  Future<void> _preloadCache() async {
    final keys = await CacheService.loadCacheKeys();
    for (final key in keys) {
      final file = await _cacheManager.getFileFromCache(key);
      if (file != null) {
        memoryCache[key] = await file.file.readAsBytes();
      }
    }
  }

  Future<void> addImage(String key, Uint8List bytes) async {
    memoryCache[key] = bytes;
    final keys = await CacheService.loadCacheKeys();
    if (!keys.contains(key)) {
      keys.add(key);
      await CacheService.saveCacheKeys(keys);
    }
  }

  Future<void> clearCache() async {
    memoryCache.clear();
    await CacheService.clearAllKeys();
    await _cacheManager.emptyCache();
  }
}
