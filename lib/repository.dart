import 'dart:typed_data';
import 'cache_service.dart';
import 'cache_manager.dart';

class CacheRepository {
  static final Map<String, Uint8List> memoryCache = {};
  static final CustomCacheManager _cacheManager = CustomCacheManager();

  static Future<void> preloadCache() async {
    final keys = CacheService.cacheKeysNotifier.value;

    for (final key in keys) {
      if (memoryCache.containsKey(key)) continue;

      final file = await _cacheManager.getFileFromCache(key);
      if (file != null) {
        final bytes = await file.file.readAsBytes();
        memoryCache[key] = bytes;
      }
    }
  }

  static Future<void> clearMemoryCache() async {
    memoryCache.clear();
    await CacheService.clearCache();
  }
}
