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
      return await _picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print("Error picking image from gallery: $e");
      return null;
    }
  }

  /// Capture an image from the camera
  Future<XFile?> pickImageFromCamera() async {
    try {
      return await _picker.pickImage(source: ImageSource.camera);
    } catch (e) {
      print("Error capturing image from camera: $e");
      return null;
    }
  }

  /// Pick multiple images from the gallery
  Future<List<XFile>?> pickMultipleImages() async {
    try {
      return await _picker.pickMultiImage();
    } catch (e) {
      print("Error picking multiple images: $e");
      return null;
    }
  }

  /// Pick a video from the gallery
  Future<XFile?> pickVideoFromGallery() async {
    try {
      return await _picker.pickVideo(source: ImageSource.gallery);
    } catch (e) {
      print("Error picking video from gallery: $e");
      return null;
    }
  }

  /// Capture a video from the camera
  Future<XFile?> pickVideoFromCamera() async {
    try {
      return await _picker.pickVideo(source: ImageSource.camera);
    } catch (e) {
      print("Error capturing video from camera: $e");
      return null;
    }
  }
}
