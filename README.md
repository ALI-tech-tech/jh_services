# jh_services

A lightweight, robust Flutter service suite to manage network requests, local persistent storage, media picking, and internet connectivity seamlessly with best practices.

[![pub package](https://img.shields.io/pub/v/jh_services.svg)](https://pub.dev/packages/jh_services)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

---

## Features

- **Network Service**: Perform REST requests (`GET`, `POST`, `PUT`, `PATCH`, `DELETE`) with typed error handling and interceptors via [Dio](https://pub.dev/packages/dio).
- **Shared Preferences Service**: Store and retrieve typed values, DateTime, JSON objects, lists, and bulk key-values via [shared_preferences](https://pub.dev/packages/shared_preferences).
- **Connectivity Service**: Check network reachability and subscribe to real-time connection status streams via [internet_connection_checker_plus](https://pub.dev/packages/internet_connection_checker_plus).
- **Image Picker Service**: Pick images or videos from the gallery or camera cross-platform via [image_picker](https://pub.dev/packages/image_picker).
- **File Picker Service**: Pick files or file data cross-platform via [file_picker](https://pub.dev/packages/file_picker).
- **Dependency Injection**: Seamless service registration and resolution using [get_it](https://pub.dev/packages/get_it).

---

## Installation

Add `jh_services` to your project's `pubspec.yaml`:

```yaml
dependencies:
  jh_services: ^0.2.1
```

Then run:

```bash
flutter pub get
```

---

## Getting Started

### 1. Initialize Services

Call `setupServiceLocator` during application startup, typically in `main()`:

```dart
import 'package:flutter/material.dart';
import 'package:jh_services/jh_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator(
    networkConfig: const NetworkConfig(
      baseUrl: 'https://api.example.com',
      defaultHeaders: {
        'Content-Type': 'application/json',
      },
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
    sharedPrefsConfig: const SharedPrefsConfig(),
    connectivityConfig: const ConnectivityConfig(),
  );

  runApp(const MyApp());
}
```

---

## Usage Guide

### Shared Preferences Service

Retrieve the service instance anywhere:

```dart
final sharedPrefsService = serviceLocator<SharedPrefsService>();

// Primitives
await sharedPrefsService.saveString('username', 'ali');
final String? username = sharedPrefsService.getString('username');

await sharedPrefsService.saveBool('is_dark_mode', true);
final bool? isDarkMode = sharedPrefsService.getBool('is_dark_mode');

// DateTime storage
await sharedPrefsService.saveDateTime('last_login', DateTime.now());
final DateTime? lastLogin = sharedPrefsService.getDateTime('last_login');

// JSON Objects
await sharedPrefsService.saveJson('profile', {'id': 1, 'role': 'admin'});
final Map<String, dynamic>? profile = sharedPrefsService.getJson('profile');

// Lists
await sharedPrefsService.addToStringList('tags', 'flutter');
await sharedPrefsService.updateOrAppendToStringList('tags', ['dart', 'mobile']);

// Bulk actions & increments
await sharedPrefsService.saveBulk({'theme': 'dark', 'volume': 80});
final data = sharedPrefsService.getBulk(['theme', 'volume']);
await sharedPrefsService.incrementOrInitInt('launch_count', incrementBy: 1);
```

---

### Network Service & Error Handling

```dart
final networkService = serviceLocator<NetworkService>();

// GET request
try {
  final response = await networkService.get('/posts/1');
  debugPrint('Post title: ${response['title']}');
} on ServerException catch (e) {
  debugPrint('Error: ${e.errorModel.message} (HTTP ${e.errorModel.statusCode})');
}

// POST request with JSON
final postResult = await networkService.post(
  '/posts',
  data: {'title': 'New Post', 'userId': 1},
);

// File upload with FormData (fully cross-platform on Web, Mobile, & Desktop)
final imagePickerService = serviceLocator<ImagePickerService>();
final XFile? image = await imagePickerService.pickImageFromGallery();

if (image != null) {
  final multipartFile = await convertImageToMultipartFile(image);
  await networkService.post(
    '/upload',
    data: {'file': multipartFile},
    isFormData: true,
  );
}
```

#### Exception Mapping

Network errors are mapped into a standardized `ServerException`:

| Dio Exception Type | Status Code | Description |
| :--- | :--- | :--- |
| `connectionTimeout` | 408 | Request timed out while connecting. |
| `sendTimeout` | 504 | Request timed out while sending data. |
| `receiveTimeout` | 504 | Request timed out while awaiting response. |
| `badCertificate` | 495 | SSL certificate validation failure. |
| `cancel` | 499 | Request was cancelled by the client. |
| `connectionError` | 503 | Network connection error. |
| `badResponse` | 400..504 | Server returned an error status code. |
| `unknown` | 520 | Unspecified network error. |

---

### Connectivity Service

Check connectivity on demand or listen to connection status changes:

```dart
final connectivityService = serviceLocator<ConnectivityService>();

// Check current connectivity
final bool isConnected = await connectivityService.isConnected();

// Listen to status changes
connectivityService.onStatusChange.listen((status) {
  if (status == InternetStatus.connected) {
    debugPrint('Connected to the internet');
  } else {
    debugPrint('Lost internet connection');
  }
});
```

---

### Image Picker Service

```dart
final imagePickerService = serviceLocator<ImagePickerService>();

// Pick from gallery
final XFile? image = await imagePickerService.pickImageFromGallery();

// Capture from camera
final XFile? photo = await imagePickerService.pickImageFromCamera();

// Pick multiple images
final List<XFile>? photos = await imagePickerService.pickMultipleImages();

// Pick video
final XFile? video = await imagePickerService.pickVideoFromGallery();
```

---

### File Picker Service

```dart
final filePickerService = serviceLocator<FilePickerService>();

// Pick single file path (Mobile / Desktop)
final String? filePath = await filePickerService.pickSingleFile(
  allowedExtensions: ['pdf', 'doc'],
);

// Pick file details with bytes (Cross-platform including Web)
final PlatformFile? file = await filePickerService.pickFileDetails();
if (file != null) {
  debugPrint('Picked ${file.name} (${file.size} bytes)');
}
```

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
