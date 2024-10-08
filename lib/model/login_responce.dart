class LoginResponse {
  final bool status;
  final dynamic data;
  final String? message;

  LoginResponse({
    required this.status,
    this.data,
    this.message,
  });

 
}
