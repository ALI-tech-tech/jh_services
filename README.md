# jh_services 0.0.1

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
  jh_services: ^0.0.1
```

## Usage

### 1. Setup Service Locator

Before using any of the services, you need to set up the service locator in your Flutter application. You can do this in your `main.dart` file:

```dart
import 'package:flutter/material.dart';
import 'package:jh_services/jh_services.dart';

void main() {
   setupServiceLocator(
    sharedPrefsConfig:SharedPrefsConfig() ,
    connectivityConfig: ConnectivityConfig(),
    networkConfig: NetworkConfig(baseUrl: 'https://api.example.com',
     defaultHeaders:  {
      'Content-Type': 'application/json',
      // Other headers if necessary
    },),
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
    sharedPrefsConfig:SharedPrefsConfig() ,
    connectivityConfig: ConnectivityConfig(),
    networkConfig: NetworkConfig(baseUrl: 'https://api.example.com',
     defaultHeaders:  {
      'Content-Type': 'application/json',
      // Other headers if necessary
    },),
  );
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
String? value =  sharedPrefsService.getString('key');
```

#### Network Service

```dart
import 'package:jh_services/jh_services.dart';

final networkService = serviceLocator<NetworkService>();

// Example of making a GET request
final response = await networkService.get('/endpoint');

// Example of making a POST request
final postResponse = await networkService.post('/endpoint', data: {'key': 'value'});

// Making a POST request with FormData
final formDataResponse = await networkService.post(
  '/upload',
  data: {
    'file': await convertImageToMultipartFile(image), // Example of using FormData
  },
  isFormData: true,
);

```
## Exception Handling in `jh_services`

The `jh_services` package provides a robust error-handling mechanism when making network requests using Dio. Each type of network error throws a `ServerException`, which contains details such as an error message, the specific error type, and a status code.

### Error Handling

The following table outlines the status codes returned for each `DioExceptionType` in case of an error:

| Dio Exception Type                   | Status Code | Description                                                |
| ------------------------------------- | ----------- | ---------------------------------------------------------- |
| `DioExceptionType.connectionTimeout`  | 408         | The request timed out while connecting to the server.       |
| `DioExceptionType.sendTimeout`        | 504         | The request timed out while sending data to the server.     |
| `DioExceptionType.receiveTimeout`     | 504         | The request timed out while receiving data from the server. |
| `DioExceptionType.badCertificate`     | 495         | The SSL certificate is invalid.                             |
| `DioExceptionType.cancel`             | 499         | The client canceled the request.                            |
| `DioExceptionType.connectionError`    | 503         | There was a network connection error.                       |
| `DioExceptionType.unknown`            | 520         | An unknown error occurred.                                  |
| `DioExceptionType.badResponse`        | Varies      | Depends on the status code from the server (e.g., 400, 401, 403, 404, 409, 422, 504). |

### Example of Handling Exceptions

When you make a network request and an error occurs, a `ServerException` is thrown, which you can catch and process as follows:

```dart
try {
  final response = await networkService.get('/endpoint');
  print(response);
} on ServerException catch (e) {
  // Handle the exception
  print('Error: ${e.errorModel.message}');
  print('Status Code: ${e.errorModel.statusCode}');
}
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


```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.