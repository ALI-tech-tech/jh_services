import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

/// Converts an image file to a MultipartFile for API upload.
///
/// This function takes an image file selected by the user via the
/// Image Picker, creates a MultipartFile from the file, and prepares
/// it for uploading to an API.
///
/// Parameters:
/// - [image]: An instance of [XFile] representing the image file to be converted.
///
/// Returns:
/// - A [MultipartFile] that can be used with Dio for the upload process.
///
/// Example usage:
/// ```dart
/// final ImagePicker _picker = ImagePicker();
/// final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
/// if (image != null) {
///   final multipartFile = await convertImageToMultipartFile(image);
///   // Use multipartFile for your API upload
/// }
/// ```
Future<MultipartFile> convertImageToMultipartFile(XFile image) async {
  return MultipartFile.fromFile(
    image.path,
    filename: image.path.split("/").last,
  );
}
