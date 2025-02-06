import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const String _cacheKey = 'image_cache_keys';
  static final ValueNotifier<List<String>> cacheKeysNotifier =
      ValueNotifier<List<String>>([]);

  static Future<void> init() async {
    cacheKeysNotifier.value = await _loadCacheKeys();
  }

  static Future<List<String>> _loadCacheKeys() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_cacheKey) ?? [];
  }

  static Future<void> saveCacheKey(String key, {int maxItems = 500}) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = await _loadCacheKeys();

    keys.remove(key);
    keys.add(key);

    if (keys.length > maxItems) {
      keys = keys.sublist(keys.length - maxItems);
    }

    await prefs.setStringList(_cacheKey, keys);
    cacheKeysNotifier.value = keys;
  }

  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
    cacheKeysNotifier.value = [];
  }
}
