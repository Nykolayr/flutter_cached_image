import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'cache_service.dart';
import 'cache_manager.dart';
import 'repository.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final String cacheKey;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget Function(BuildContext)? placeholder;
  final Widget Function(BuildContext)? errorWidget;
  final int maxCacheItems;

  const CachedImage({
    super.key,
    required this.imageUrl,
    required this.cacheKey,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.maxCacheItems = 500,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: CacheService.cacheKeysNotifier,
      builder: (context, keys, _) {
        return CacheRepository.memoryCache.containsKey(cacheKey)
            ? Image.memory(
                CacheRepository.memoryCache[cacheKey]!,
                width: width,
                height: height,
                fit: fit,
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                width: width,
                height: height,
                fit: fit,
                cacheKey: cacheKey,
                cacheManager: CustomCacheManager(),
                imageBuilder: (context, imageProvider) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    CacheService.saveCacheKey(cacheKey,
                        maxItems: maxCacheItems);
                  });
                  return Image(image: imageProvider, fit: fit);
                },
                placeholder: placeholder != null
                    ? (ctx, url) => placeholder!(ctx)
                    : (ctx, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                errorWidget: errorWidget != null
                    ? (ctx, url, err) => errorWidget!(ctx)
                    : (ctx, url, err) => const Icon(Icons.error),
              );
      },
    );
  }
}
