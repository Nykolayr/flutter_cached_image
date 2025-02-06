export 'cached_image.dart' show CachedImage;
export 'cache_service.dart';
export 'cache_manager.dart';
export 'repository.dart';

class FlutterCachedImage {
  static Future<void> init() async {
    await CacheRepository().init();
  }
}
