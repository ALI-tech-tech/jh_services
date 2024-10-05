// lib/src/core/service_config.dart

/// Configuration for NetworkService.
class NetworkConfig {
  final String baseUrl;
  final Map<String, String>? defaultHeaders;
  final int connectTimeout;
  final int receiveTimeout;

  NetworkConfig({
    required this.baseUrl,
    this.defaultHeaders,
    this.connectTimeout = 5000,
    this.receiveTimeout = 3000,
  });
}

/// Configuration for SharedPrefsService.
/// (If any specific configurations are needed in the future)
class SharedPrefsConfig {
  // Add fields if needed
}

/// Configuration for ConnectivityService.
/// (If any specific configurations are needed in the future)
class ConnectivityConfig {
  // Add fields if needed
}
