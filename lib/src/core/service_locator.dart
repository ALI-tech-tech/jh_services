// lib/src/core/service_locator.dart

import 'package:get_it/get_it.dart';
import '../services/connectivity_service.dart';
import '../services/file_picker_service.dart';
import '../services/image_picker_service.dart';
import '../services/network_service.dart';
import '../services/shared_prefs_service.dart';
import 'service_config.dart';

/// Global service locator instance managed by [GetIt].
final GetIt serviceLocator = GetIt.instance;

/// Registers and initializes all core services with the given configuration.
///
/// If a service is already registered in [serviceLocator], it is safely skipped
/// or updated to prevent registration collisions during hot restarts and testing.
Future<void> setupServiceLocator({
  required NetworkConfig networkConfig,
  SharedPrefsConfig? sharedPrefsConfig,
  ConnectivityConfig? connectivityConfig,
}) async {
  // Register SharedPrefsService
  if (!serviceLocator.isRegistered<SharedPrefsService>()) {
    serviceLocator.registerLazySingleton<SharedPrefsService>(
      () => SharedPrefsService(),
    );
  }

  // Register NetworkService with configuration
  if (serviceLocator.isRegistered<NetworkService>()) {
    serviceLocator.unregister<NetworkService>();
  }
  serviceLocator.registerLazySingleton<NetworkService>(
    () => NetworkService(config: networkConfig),
  );

  // Register ConnectivityService
  if (!serviceLocator.isRegistered<ConnectivityService>()) {
    serviceLocator.registerLazySingleton<ConnectivityService>(
      () => ConnectivityService(),
    );
  }

  // Register ImagePickerService
  if (!serviceLocator.isRegistered<ImagePickerService>()) {
    serviceLocator.registerLazySingleton<ImagePickerService>(
      () => ImagePickerService(),
    );
  }

  // Register FilePickerService
  if (!serviceLocator.isRegistered<FilePickerService>()) {
    serviceLocator.registerLazySingleton<FilePickerService>(
      () => FilePickerService(),
    );
  }

  // Initialize all registered services
  await initializeAllServices();
}

/// Initializes all services registered in [serviceLocator].
Future<void> initializeAllServices() async {
  await Future.wait([
    serviceLocator<SharedPrefsService>().init(),
    serviceLocator<NetworkService>().init(),
    serviceLocator<ConnectivityService>().init(),
    serviceLocator<ImagePickerService>().init(),
    serviceLocator<FilePickerService>().init(),
  ]);
}
