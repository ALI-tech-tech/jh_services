import 'package:file_picker/file_picker.dart';
import '../core/base_service.dart';

class FilePickerService implements BaseService {
  @override
  Future<void> init() async {
    // No initialization needed for FilePicker
  }

  /// Pick a single file
  Future<String?> pickSingleFile({List<String>? allowedExtensions}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.single.path; // Return the file path
      } else {
        return null; // No file selected
      }
    } catch (e) {
      // Handle errors (e.g., user denied permission)
      return null;
    }
  }

  /// Pick multiple files
  Future<List<String>?> pickMultipleFiles(
      {List<String>? allowedExtensions}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files
            .map((file) => file.path!)
            .toList(); // Return a list of file paths
      } else {
        return null; // No files selected
      }
    } catch (e) {
      // Handle errors (e.g., user denied permission)
      return null;
    }
  }
}
