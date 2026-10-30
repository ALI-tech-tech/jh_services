// lib/src/core/base_service.dart

/// Base interface for all services within [jh_services].
abstract class BaseService {
  /// Initializes the service asynchronously.
  Future<void> init();
}
