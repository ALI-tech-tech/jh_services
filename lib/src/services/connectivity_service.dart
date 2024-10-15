import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../core/base_service.dart';

class ConnectivityService implements BaseService {
  final InternetConnection _connectionChecker = InternetConnection();

  @override
  Future<void> init() async {
    // No initialization needed for InternetConnectionCheckerPlus
  }

  /// Check if the device is connected to the internet
  Future<bool> isConnected() async {
    return await _connectionChecker.hasInternetAccess;
  }
}
