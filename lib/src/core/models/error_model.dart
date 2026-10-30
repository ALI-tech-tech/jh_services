/// Model representing an API or server error.
class ErrorModel {
  /// The error message returned by the server or generated locally.
  final String message;

  /// Detailed error string or error code.
  final String error;

  /// The HTTP status code or internal error code.
  final int statusCode;

  /// Creates a new [ErrorModel] instance.
  const ErrorModel({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  /// Constructs an [ErrorModel] from a JSON map or dynamic response.
  factory ErrorModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return ErrorModel(
        message: json['message']?.toString() ??
            json['error']?.toString() ??
            'Unknown error',
        error: json['error']?.toString() ??
            json['detail']?.toString() ??
            'Error',
        statusCode: json['statusCode'] is int
            ? json['statusCode'] as int
            : int.tryParse(json['statusCode']?.toString() ?? '') ?? 0,
      );
    } else if (json is String) {
      return ErrorModel(
        message: json,
        error: json,
        statusCode: 0,
      );
    }
    return const ErrorModel(
      message: 'Unknown error occurred',
      error: 'UnknownError',
      statusCode: 0,
    );
  }

  /// Converts this [ErrorModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'error': error,
      'statusCode': statusCode,
    };
  }

  @override
  String toString() => 'ErrorModel(statusCode: $statusCode, message: $message, error: $error)';
}
