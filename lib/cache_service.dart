import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const String _cacheKey = 'image_cache_keys';

  static Future<List<String>> loadCacheKeys() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_cacheKey) ?? [];
  }

  static Future<void> saveCacheKeys(List<String> keys) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_cacheKey, keys);
  }

  static Future<void> clearAllKeys() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }
}
