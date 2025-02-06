import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class CustomCacheManager extends CacheManager {
  static const key = 'customImageCache';

  static final CustomCacheManager _instance = CustomCacheManager._();
  factory CustomCacheManager() => _instance;

  CustomCacheManager._()
      : super(Config(
          key,
          stalePeriod: const Duration(days: 30),
          maxNrOfCacheObjects: 1000,
          repo: JsonCacheInfoRepository(databaseName: key),
          fileSystem: IOFileSystem(key),
          fileService: HttpFileService(),
        ));

  Future<String> getFilePath(String url) async {
    final dir = await getTemporaryDirectory();
    return p.join(dir.path, key, _getFileName(url));
  }

  String _getFileName(String url) {
    final uri = Uri.parse(url);
    return p.basename(uri.path);
  }
}
