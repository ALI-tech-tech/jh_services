# Changelog

## [0.2.0] - 2026-10-30

### Changed
- **Dependencies**: Converted all exact dependency pins to flexible semantic version caret constraints (`^...`), preventing version-solving conflicts for consuming apps.
- **SDK Support**: Updated SDK constraints to Dart `^3.0.0` and Flutter `>=3.10.0`.
- **Linter & Code Quality**: Upgraded to `flutter_lints: ^5.0.0` and resolved all static analysis issues across the library and example.
- **Cross-Platform Compatibility**:
  - `convertImageToMultipartFile`: Converted to byte-based multipart serialization with `image.name`, providing full compatibility across Web, iOS, Android, macOS, Linux, and Windows.
  - `FilePickerService`: Prevented null-path assertion errors on Flutter Web and introduced `pickFileDetails` / `pickMultipleFileDetails` returning `PlatformFile`.
  - `NetworkService`: Added `put` HTTP method and exposed `dio` getter for custom interceptors and tokens.
  - `ConnectivityService`: Added `onStatusChange` stream for reactive connectivity listening.
  - `handleDioExceptions`: Fixed null unwraps (`e.message!`) and added complete handling for 500+ server responses.
  - `ErrorModel`: Made fields immutable and deserialization resilient to arbitrary/null error bodies.
  - `setupServiceLocator`: Ensured service locator registration is idempotent and safe during hot reload/restart and testing.

### Added
- Comprehensive unit test suite with 15 automated test cases covering local storage, error handling, configuration, and service locator lifecycle.
- Metadata topics in `pubspec.yaml` for enhanced discovery on pub.dev.

## [0.1.1] - 2024-11-02

### Fixed
- Dependency version adjustments and stability fixes.

## [0.1.0] - 2024-11-02

### Added on `SharedPrefsService`
- **saveDateTime**: Method to save a `DateTime` value as a string.
- **getDateTime**: Method to retrieve a `DateTime` value.
- **updateOrAppendToStringList**: Method to update or append to a string list.
- **saveBulk**: Method to save multiple key-value pairs in one go.
- **getBulk**: Method to retrieve multiple values for a list of keys.
- **incrementOrInitInt**: Method to increment or initialize an integer value.
- **decrementInt**: Method to decrement an integer value.
- **toggleBool**: Method to toggle a boolean value.
- **addToStringList**: Method to add a single item to a list of strings.
- **removeFromStringList**: Method to remove a single item from a list of strings.
- **getAll**: Method to retrieve all key-value pairs.
- **saveJson**: Method to save a JSON object by encoding it as a string.
- **getJson**: Method to retrieve a JSON object by decoding a stored string.
- **resetToDefaults**: Method to reset a list of keys to specified default values.
- **getKeysByPrefix**: Method to retrieve all keys that start with a specified prefix.
- **getItemCount**: Method to count the number of stored items.
- **batchIncrementInts**: Method for batch update to increment multiple integer keys by specified values.
- **retrieveAndRemove**: Method to retrieve and remove values for a list of keys.
- **getValue**: Method to retrieve a value by type.
- **getKeys**: Method to retrieve all keys.
