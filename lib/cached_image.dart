import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    Future<void> saveImage() async {
      final repository = CacheRepository();
      final file = await CustomCacheManager().getSingleFile(imageUrl);
      final bytes = await file.readAsBytes();
      await repository.addImage(cacheKey, bytes);
    }

    final repository = CacheRepository();
    return repository.memoryCache.containsKey(cacheKey)
        ? Image.memory(
            repository.memoryCache[cacheKey]!,
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
              saveImage();
              return Image(image: imageProvider, fit: fit);
            },
            placeholder: placeholder != null
                ? (ctx, url) => placeholder!(ctx)
                : (ctx, url) => const Center(
                      child: CircularProgressIndicator(color: Colors.orange),
                    ),
            errorWidget: errorWidget != null
                ? (ctx, url, err) => errorWidget!(ctx)
                : (ctx, url, err) => const Icon(Icons.error),
          );
  }

  static Future<void> init() async {
    await CacheRepository().init();
  }
}
