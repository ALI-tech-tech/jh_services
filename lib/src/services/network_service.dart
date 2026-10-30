// lib/src/services/network_service.dart

import 'package:dio/dio.dart';
import '../core/base_service.dart';
import '../core/exceptions/handle_dio_exeptions.dart';
import '../core/service_config.dart';

/// Service for executing HTTP/REST network requests using [Dio].
class NetworkService implements BaseService {
  /// The network configuration containing base URL, timeouts, and headers.
  final NetworkConfig config;

  late Dio _dio;

  /// Creates a [NetworkService] instance with the specified [config].
  NetworkService({required this.config});

  /// Exposes the underlying [Dio] instance for advanced customizations.
  Dio get dio => _dio;

  @override
  Future<void> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: Duration(milliseconds: config.connectTimeout),
        receiveTimeout: Duration(milliseconds: config.receiveTimeout),
        headers: config.defaultHeaders,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) => handler.next(options),
        onResponse: (response, handler) => handler.next(response),
        onError: (DioException e, handler) => handler.next(e),
      ),
    );
  }

  dynamic _prepareData(dynamic data, bool isFormData) {
    if (data is FormData) return data;
    if (isFormData && data is Map<String, dynamic>) {
      return FormData.fromMap(data);
    }
    return data;
  }

  /// Sends a GET request to the specified [path].
  Future<dynamic> get(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  /// Sends a POST request to the specified [path].
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: _prepareData(data, isFormData),
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  /// Sends a PUT request to the specified [path].
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: _prepareData(data, isFormData),
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  /// Sends a PATCH request to the specified [path].
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: _prepareData(data, isFormData),
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  /// Sends a DELETE request to the specified [path].
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: _prepareData(data, isFormData),
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
