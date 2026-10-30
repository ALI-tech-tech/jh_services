import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../core/base_service.dart';

/// Service for monitoring device internet connectivity.
class ConnectivityService implements BaseService {
  final InternetConnection _connectionChecker = InternetConnection();

  @override
  Future<void> init() async {
    // No initialization needed for InternetConnection
  }

  /// Check if the device currently has internet access.
  Future<bool> isConnected() async {
    return await _connectionChecker.hasInternetAccess;
  }

  /// Stream of connectivity status changes.
  Stream<InternetStatus> get onStatusChange => _connectionChecker.onStatusChange;
}
