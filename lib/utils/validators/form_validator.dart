/// A utility class that provides static methods for validating user input.
///
/// This class contains methods to validate various fields such as name,
/// email, password, and phone number. Each validation method returns an
/// error message if the input is invalid; otherwise, it returns null.
class Validator {
  /// Validates the provided [value] for the name field.
  ///
  /// Returns an error message if the name is null or empty,
  /// otherwise returns null.
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  /// Validates the provided [value] for the password field.
  ///
  /// Returns an error message if the password is null or empty,
  /// or if it is shorter than 6 characters. Otherwise, returns null.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}
