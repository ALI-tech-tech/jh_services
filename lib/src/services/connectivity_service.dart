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

  /// Get the connectivity status as a stream
  Stream<bool> get connectionStream {
    return _connectionChecker.onStatusChange.map((status)  {
      return status.name ==  _connectionChecker.hasInternetAccess.toString();
    });
  }


}
