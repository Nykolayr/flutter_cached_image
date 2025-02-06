<<<<<<< HEAD
# Flutter Cached Image

[![Pub Version](https://img.shields.io/pub/v/flutter_cached_image)](https://pub.dev/packages/flutter_cached_image)
![License](https://img.shields.io/github/license/yourname/flutter_cached_image)

Умный кэш изображений с двойным хранилищем (память + диск) и автоматическим управлением ресурсами.

## Особенности
- 🚀 Мгновенная загрузка из памяти
- 💾 Автосохранение в дисковой кэш
- 🔄 Автоочистка старых записей
- 📱 Оптимизация для слабых устройств
- 🔒 Поддержка кастомных ключей

## Установка
Добавьте в `pubspec.yaml`:
```yaml
dependencies:
  flutter_cached_image: 
    git:
      url: https://github.com/Nykolayr/flutter_cached_image.git
      ref: main
```

## Использование
```dart
CachedImage(
  imageUrl: 'https://example.com/image.jpg',
  cacheKey: 'unique_image_key',
  width: 200,
  height: 150,
  maxCacheItems: 500, // Максимум изображений в памяти
)
```

## API
| Параметр       | Тип              | Обязательный | По умолчанию   |
|----------------|-------------------|--------------|-----------------|
| imageUrl       | String            | Да           | -               |
| cacheKey       | String            | Да           | -               |
| width          | double?           | Нет          | null            |
| height         | double?           | Нет          | null            |
| fit            | BoxFit            | Нет          | BoxFit.cover    |
| maxCacheItems  | int               | Нет          | 500             |

## Локализация кэша
```dart
// Очистка кэша
await CacheService.clearCache();

// Предзагрузка изображений
await CacheRepository.preloadCache();

// Ручное управление
CacheRepository.memoryCache.remove('key');
```

## Лицензия
MIT
=======
# flutter_cached_image
Advanced image caching for Flutter
>>>>>>> 79d65e027a570fa1f6b27ed4f5f0d685118d86b3
