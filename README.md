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
      ref: f515daf6f20ccfcc7c284deef2dae0f2f6b64afe 
```

## Инициализация
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Используйте newColor для кастомного цвета или удалите параметр для белого по умолчанию
  await CachedImage.init(newColor: Colors.orange); // newColor необязателен
  runApp(MyApp());
}
```

## Использование
```dart
CachedImage(
  imageUrl: 'https://example.com/image.jpg',
  cacheKey: 'unique_image_key',
  width: 200,
  height: 150,
  maxCacheItems: 500,
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


## Лицензия
MIT