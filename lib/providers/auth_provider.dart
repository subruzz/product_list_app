import 'package:flutter/material.dart';
import 'package:product_list_app/model/login_responce.dart';
import 'package:product_list_app/services/auth_service.dart';
import 'package:product_list_app/services/sharedpf.dart';
import 'package:product_list_app/utils/erros/main_exception.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;
  bool _isLogged = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLogged;

  /// Logs in a user with the provided [username] and [password].
  Future<LoginResponse?> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;

    notifyListeners();

    try {
      final response = await _authService.login(username, password);
      _isLogged = true;

      await SharedPrefs.setLoggedIn(true);

      return response;
    } on MainException catch (e) {
      _errorMessage = e.toString();
      return null;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: ${e.toString()}';
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


}
