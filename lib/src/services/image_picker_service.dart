import 'package:image_picker/image_picker.dart';
import '../core/base_service.dart';

class ImagePickerService implements BaseService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<void> init() async {
    // No initialization needed for ImagePicker
  }

  /// Pick an image from the gallery
  Future<XFile?> pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      return pickedFile;
    } catch (e) {
      // Handle errors (e.g., user denied permission)
      return null;
    }
  }

  /// Capture an image from the camera
  Future<XFile?> pickImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      return pickedFile;
    } catch (e) {
      // Handle errors (e.g., user denied permission)
      return null;
    }
  }

  /// Pick multiple images from the gallery
  Future<List<XFile>?> pickMultipleImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage();
      return pickedFiles;
    } catch (e) {
      // Handle errors (e.g., user denied permission)
      return null;
    }
  }
}
