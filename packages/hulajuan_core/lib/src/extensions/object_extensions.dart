import 'dart:developer' as dev;

/// Convenient extension for objects.
extension ObjectX on Object {
  /// For object logging.
  void log() => dev.log(toString());
}
