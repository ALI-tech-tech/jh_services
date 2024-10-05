// lib/src/services/shared_prefs_service.dart

import 'package:shared_preferences/shared_preferences.dart';
import '../core/base_service.dart';

class SharedPrefsService implements BaseService {
  SharedPreferences? _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Saves a string value.
  Future<bool> saveString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  /// Retrieves a string value.
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// Removes a value.
  Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  /// Clears all values.
  Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }
}
