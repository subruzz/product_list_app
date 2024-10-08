
import 'package:dio/dio.dart';
import '../model/login_responce.dart';
import '../utils/erros/exception_handler.dart';
import '../utils/erros/main_exception.dart';

/// The AuthService class is responsible for handling authentication
/// through the API, including login operations and error management.
class AuthService {
  /// A Dio instance for making network requests.
  final Dio _dio = Dio();

  /// Logs in a user with the provided [username] and [password].
  ///
  /// Returns a [Future] containing a [LoginResponse] on successful login,
  /// or an error message on failure.
  ///
  /// Throws [MainException] if an unexpected error occurs while processing.
  /// Throws a [DioException] if a network error occurs.
  Future<LoginResponse> login(String username, String password) async {
    try {
      // Making a POST request to the login API endpoint
      final response = await _dio.post(
        'https://dummyjson.com/auth/login',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          'username': username,
          'password': password,
          'expiresInMins': 30, 
        },
      );

      // Check if the login was successful
      if (response.statusCode == 200) {
        return LoginResponse(
          status: true,
          data: response.data,
        );
      } else {
        // Handle non-200 response codes with a custom error handler
        throw ExceptionHandlers.handleBadResponse(response);
      }
    } on DioException catch (e) {
      // Handle Dio-specific exceptions using the custom error handler
      throw ExceptionHandlers.handleDioExceptions(e);
    } catch (e) {
      // Catch any unexpected exceptions and throw a MainException
      throw MainException('An unexpected error occurred: ${e.toString()}');
    }
  }
}
