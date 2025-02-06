library flutter_cached_image;

import 'package:flutter/material.dart';
import 'package:flutter_cached_image/cache_service.dart';
import 'package:flutter_cached_image/cached_image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Cached Image Demo')),
        body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) => CachedImage(
            imageUrl: 'https://picsum.photos/200/300?random=$index',
            cacheKey: 'image_$index',
            width: 200,
            height: 200,
            maxCacheItems: 100,
          ),
        ),
      ),
    );
  }
}
