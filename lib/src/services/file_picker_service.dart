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
      final result = await FilePicker.platform.pickFiles(
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.single.path;
      }
      return null;
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
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files
            .map((file) => file.path)
            .whereType<String>()
            .toList();
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
    bool withData = true,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
        withData: withData,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.single;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Pick multiple files and return their [PlatformFile] objects, which
  /// contain metadata and bytes across mobile, desktop, and web.
  Future<List<PlatformFile>?> pickMultipleFileDetails({
    List<String>? allowedExtensions,
    bool withData = true,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
        withData: withData,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
