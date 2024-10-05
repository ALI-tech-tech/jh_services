# jh_services 1.0.0

`jh_services` is a Flutter package that provides a collection of services for handling common tasks in your Flutter applications, such as shared preferences, network requests, image and file picking, and checking internet connectivity.

## Features

- **Shared Preferences Service**: Manage local storage using shared preferences.
- **Network Service**: Handle network requests with customizable configurations.
- **Image Picker Service**: Pick images from the device's gallery or camera.
- **File Picker Service**: Select files from the device's file system.
- **Connectivity Service**: Check internet connectivity status and listen for changes.

## Installation

Add `jh_services` to your `pubspec.yaml` file:

```yaml
dependencies:
  jh_services:
    path: path/to/jh_services  # Update with your package path
```

## Usage

### 1. Setup Service Locator

Before using any of the services, you need to set up the service locator in your Flutter application. You can do this in your `main.dart` file:

```dart
import 'package:flutter/material.dart';
import 'package:jh_services/jh_services.dart';

void main() {
  setupServiceLocator(
    baseUrl: 'https://api.example.com',  // Your base URL
    dioHeaders: {
      'Content-Type': 'application/json',
      // Other headers if necessary
    },
  );
  
  runApp(MyApp());
}
```

### 2. Initialize Services

You should initialize the services before using them. This is typically done in your `main.dart` file after setting up the service locator:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator(
    baseUrl: 'https://api.example.com',
    dioHeaders: {
      'Content-Type': 'application/json',
    },
  );

  await initializeServices(); // Initialize all services
  runApp(MyApp());
}
```

### 3. Using the Services

#### Shared Preferences Service

```dart
import 'package:jh_services/jh_services.dart';

final sharedPrefsService = serviceLocator<SharedPrefsService>();

// Example of saving a value
await sharedPrefsService.saveString('key', 'value');

// Example of retrieving a value
String? value = await sharedPrefsService.getString('key');
```

#### Network Service

```dart
import 'package:jh_services/jh_services.dart';

final networkService = serviceLocator<NetworkService>();

// Example of making a GET request
final response = await networkService.get('/endpoint');

// Example of making a POST request
final postResponse = await networkService.post('/endpoint', data: {'key': 'value'});
```

#### Image Picker Service

```dart
import 'package:jh_services/jh_services.dart';

final imagePickerService = serviceLocator<ImagePickerService>();

// Example of picking an image
final imagePath = await imagePickerService.pickImage();
```

#### File Picker Service

```dart
import 'package:jh_services/jh_services.dart';

final filePickerService = serviceLocator<FilePickerService>();

// Example of picking a single file
final filePath = await filePickerService.pickSingleFile(allowedExtensions: ['pdf', 'docx']);

// Example of picking multiple files
final filePaths = await filePickerService.pickMultipleFiles();
```

#### Connectivity Service

```dart
import 'package:jh_services/jh_services.dart';

final connectivityService = serviceLocator<ConnectivityService>();

// Example of checking current connectivity status
final isConnected = await connectivityService.isConnected();

// Listening to connectivity changes
connectivityService.connectionStream.listen((isConnected) {
  print('Connected: $isConnected');
});
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.