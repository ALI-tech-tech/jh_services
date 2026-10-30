import 'package:dio/dio.dart';

import '../models/error_model.dart';
import 'server_exception.dart';

/// Handles [DioException] and maps it to a standardized [ServerException].
void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
        errorModel: ErrorModel(
          message: e.message ?? 'Connection timed out',
          error: e.error?.toString() ?? 'ConnectionTimeout',
          statusCode: 408,
        ),
      );

    case DioExceptionType.sendTimeout:
      throw ServerException(
        errorModel: ErrorModel(
          message: e.message ?? 'Send request timed out',
          error: e.error?.toString() ?? 'SendTimeout',
          statusCode: 504,
        ),
      );

    case DioExceptionType.receiveTimeout:
      throw ServerException(
        errorModel: ErrorModel(
          message: e.message ?? 'Receive response timed out',
          error: e.error?.toString() ?? 'ReceiveTimeout',
          statusCode: 504,
        ),
      );

    case DioExceptionType.badCertificate:
      throw ServerException(
        errorModel: ErrorModel(
          message: e.message ?? 'Invalid SSL certificate',
          error: e.error?.toString() ?? 'BadCertificate',
          statusCode: 495,
        ),
      );

    case DioExceptionType.cancel:
      throw ServerException(
        errorModel: ErrorModel(
          message: e.message ?? 'Request was cancelled',
          error: e.error?.toString() ?? 'RequestCancelled',
          statusCode: 499,
        ),
      );

    case DioExceptionType.connectionError:
      throw ServerException(
        errorModel: ErrorModel(
          message: e.message ?? 'Connection error. Please check your network.',
          error: e.error?.toString() ?? 'ConnectionError',
          statusCode: 503,
        ),
      );

    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode ?? 500;
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        throw ServerException(errorModel: ErrorModel.fromJson(data));
      } else if (data != null) {
        throw ServerException(
          errorModel: ErrorModel(
            message: data.toString(),
            error: 'BadResponse',
            statusCode: statusCode,
          ),
        );
      } else {
        throw ServerException(
          errorModel: ErrorModel(
            message: e.message ?? 'Server responded with status $statusCode',
            error: 'BadResponse',
            statusCode: statusCode,
          ),
        );
      }

    case DioExceptionType.unknown:
      throw ServerException(
        errorModel: ErrorModel(
          message: e.message ?? 'An unknown network error occurred',
          error: e.error?.toString() ?? 'UnknownError',
          statusCode: 520,
        ),
      );
  }
}
