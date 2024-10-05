import 'package:dio/dio.dart';

import '../models/error_model.dart';
import 'server_exception.dart';

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
          errorModel: ErrorModel(
              message: e.message!,
              error: e.error.toString(),
              statusCode: 1000));
    case DioExceptionType.sendTimeout:
      throw ServerException(
          errorModel: ErrorModel(
              message: e.message!,
              error: e.error.toString(),
              statusCode: 1000));

    case DioExceptionType.receiveTimeout:
      throw ServerException(
          errorModel: ErrorModel(
              message: e.message!,
              error: e.error.toString(),
              statusCode: 1000));

    case DioExceptionType.badCertificate:
      throw ServerException(
          errorModel: ErrorModel(
              message: e.message!,
              error: e.error.toString(),
              statusCode: 1000));

    case DioExceptionType.cancel:
      throw ServerException(
          errorModel: ErrorModel(
              message: e.message!,
              error: e.error.toString(),
              statusCode: 1000));

    case DioExceptionType.connectionError:
      throw ServerException(
          errorModel: ErrorModel(
              message: e.message!,
              error: e.error.toString(),
              statusCode: 1000));
    case DioExceptionType.unknown:
      throw ServerException(
          errorModel: ErrorModel(
              message: e.message!,
              error: e.error.toString(),
              statusCode: 1000));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: //Bad request
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 401: //unauthorized
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 403: //forbidden
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 404: //not found
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 409: //coffcient
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 422: //Unprocessable Entity
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 504: //server exeption
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
      }
  }
}
