import 'package:file_picker/file_picker.dart';
import '../core/base_service.dart';

/// Service for picking files from the device's storage.
class FilePickerService implements BaseService {
  @override
  Future<void> init() async {
    // No initialization needed for FilePicker
  }

  /// Pick a single file and return its filesystem path.
  ///
  /// Note: On Flutter Web, file paths do not exist. Use [pickFileDetails]
  /// if you need web-compatible file bytes and metadata.
  Future<String?> pickSingleFile({List<String>? allowedExtensions}) async {
    try {
      final file = await FilePicker.pickFile(
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
      );
      return file?.path;
    } catch (_) {
      return null;
    }
  }

  /// Pick multiple files and return their filesystem paths.
  ///
  /// Note: On Flutter Web, file paths do not exist. Use [pickMultipleFileDetails]
  /// if you need web-compatible file bytes and metadata.
  Future<List<String>?> pickMultipleFiles({
    List<String>? allowedExtensions,
  }) async {
    try {
      final files = await FilePicker.pickFiles(
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
      );

      if (files.isNotEmpty) {
        return files.map((file) => file.path).whereType<String>().toList();
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Pick a single file and return its [PlatformFile] object, which
  /// contains both metadata and bytes across mobile, desktop, and web.
  Future<PlatformFile?> pickFileDetails({
    List<String>? allowedExtensions,
  }) async {
    try {
      return await FilePicker.pickFile(
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
      );
    } catch (_) {
      return null;
    }
  }

  /// Pick multiple files and return their [PlatformFile] objects, which
  /// contain metadata and bytes across mobile, desktop, and web.
  Future<List<PlatformFile>?> pickMultipleFileDetails({
    List<String>? allowedExtensions,
  }) async {
    try {
      final files = await FilePicker.pickFiles(
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
      );
      return files.isNotEmpty ? files : null;
    } catch (_) {
      return null;
    }
  }
}
