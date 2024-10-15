// lib/src/core/service_locator.dart

import 'package:get_it/get_it.dart';
import 'package:jh_services/src/services/image_picker_service.dart';
import '../services/file_picker_service.dart';
import '../services/shared_prefs_service.dart';
import '../services/network_service.dart';
import '../services/connectivity_service.dart';
import 'service_config.dart';

final GetIt serviceLocator = GetIt.instance;

/// Initializes all services with the provided configurations.
Future<void> setupServiceLocator({
  required NetworkConfig networkConfig,
  SharedPrefsConfig? sharedPrefsConfig,
  ConnectivityConfig? connectivityConfig,
}) async {
  // Register SharedPrefsService
  serviceLocator.registerLazySingleton<SharedPrefsService>(
    () => SharedPrefsService(),
  );

  // Register NetworkService with configuration
  serviceLocator.registerLazySingleton<NetworkService>(
    () => NetworkService(config: networkConfig),
  );

  // Register ConnectivityService
  serviceLocator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityService(),
  );
  serviceLocator
      .registerLazySingleton<ImagePickerService>(() => ImagePickerService());
  serviceLocator
      .registerLazySingleton<FilePickerService>(() => FilePickerService());
  // Initialize all services
  await initializeAllServices();
}

/// Initializes each registered service.
Future<void> initializeAllServices() async {
  // Assuming init() returns Future<void> for each service
  await Future.wait([
    serviceLocator<SharedPrefsService>().init(),
    serviceLocator<NetworkService>().init(),
    serviceLocator<ConnectivityService>().init(),
    serviceLocator<ImagePickerService>().init(),
    serviceLocator<FilePickerService>().init(),
  ]);
}
