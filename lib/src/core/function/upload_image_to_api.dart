import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

/// Converts an image file to a [MultipartFile] for API upload.
///
/// This function reads the image bytes and creates a [MultipartFile]
/// compatible with all platforms including Flutter Web, Mobile, and Desktop.
///
/// Parameters:
/// - [image]: An instance of [XFile] representing the image file.
///
/// Returns:
/// - A [MultipartFile] that can be used with Dio for form data uploads.
///
/// Example usage:
/// ```dart
/// final ImagePicker picker = ImagePicker();
/// final XFile? image = await picker.pickImage(source: ImageSource.gallery);
/// if (image != null) {
///   final multipartFile = await convertImageToMultipartFile(image);
///   // Use multipartFile in your FormData
/// }
/// ```
Future<MultipartFile> convertImageToMultipartFile(XFile image) async {
  final bytes = await image.readAsBytes();
  return MultipartFile.fromBytes(
    bytes,
    filename: image.name,
  );
}
