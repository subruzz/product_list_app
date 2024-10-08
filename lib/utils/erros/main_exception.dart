/// A custom exception class for handling errors in the application.
///
/// This class extends the built-in [Exception] class to provide a more
/// descriptive error message for exceptions related to the application.
class MainException implements Exception {
  /// The message associated with the exception.
  final String message;

  /// Creates an instance of [MainException] with the provided [message].
  MainException(this.message);

  /// Returns a string representation of the exception.
  ///
  /// Overrides the [toString] method to provide a clear description of the
  /// exception, which can be useful for debugging purposes.
  @override
  String toString() => 'MainException: $message';
}
