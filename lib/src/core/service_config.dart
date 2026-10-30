// lib/src/core/service_config.dart

/// Configuration settings for [NetworkService].
class NetworkConfig {
  /// Base endpoint URL for all network requests.
  final String baseUrl;

  /// Default HTTP headers included with every request.
  final Map<String, String>? defaultHeaders;

  /// Connection timeout in milliseconds. Default is 5000ms.
  final int connectTimeout;

  /// Receive timeout in milliseconds. Default is 3000ms.
  final int receiveTimeout;

  /// Creates a new [NetworkConfig] instance.
  const NetworkConfig({
    required this.baseUrl,
    this.defaultHeaders,
    this.connectTimeout = 5000,
    this.receiveTimeout = 3000,
  });
}

/// Configuration options for [SharedPrefsService].
class SharedPrefsConfig {
  /// Creates a new [SharedPrefsConfig] instance.
  const SharedPrefsConfig();
}

/// Configuration options for [ConnectivityService].
class ConnectivityConfig {
  /// Creates a new [ConnectivityConfig] instance.
  const ConnectivityConfig();
}
