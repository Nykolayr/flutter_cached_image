import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager extends CacheManager with ImageCacheManager {
  static const key = 'customImageCache';

  static final CustomCacheManager _instance = CustomCacheManager._();
  factory CustomCacheManager() => _instance;

  CustomCacheManager._()
      : super(Config(
          key,
          stalePeriod: const Duration(days: 365),
          maxNrOfCacheObjects: 10000,
        ));
  Future<bool> isImageInMemory(String url) async {
    final provider = CachedNetworkImageProvider(url);
    final key = await provider.obtainKey(ImageConfiguration.empty);
    return PaintingBinding.instance.imageCache.containsKey(key);
  }
}
