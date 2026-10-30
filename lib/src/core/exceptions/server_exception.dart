import '../models/error_model.dart';

/// Exception thrown when a network or server request fails.
class ServerException implements Exception {
  /// The structured error model containing error details.
  final ErrorModel errorModel;

  /// Creates a new [ServerException] with the given [errorModel].
  const ServerException({required this.errorModel});

  @override
  String toString() =>
      'ServerException: ${errorModel.message} (status: ${errorModel.statusCode})';
}
