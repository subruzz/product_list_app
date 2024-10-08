import 'package:dio/dio.dart';
import 'package:product_list_app/utils/erros/main_exception.dart';

class ExceptionHandlers {
  static MainException handleBadResponse(Response? response) {
    if (response == null) {
      return MainException(
          'Oops! No response from the server. Please try again.');
    }

    switch (response.statusCode) {
      case 400:
        return MainException(
            'It looks like something went wrong with the request. Please check and try again.');
      case 401:
        return MainException(
            'You\'re not authorized. Please check your API key or login details.');
      case 403:
        return MainException(
            'Access denied! You don’t have permission to access this resource.');
      case 404:
        return MainException(
            'We couldn’t find what you were looking for. Please check the resource and try again.');
      case 429:
        return MainException(
            'Slow down! You’ve made too many requests. Please wait a bit and try again.');
      case 500:
        return MainException(
            'The server encountered an issue. Please try again later.');
      case 503:
        return MainException(
            'The service is currently unavailable. Please try again in a few moments.');
      default:
        return MainException(
            'Unexpected error occurred. Please try again later. (Error code: ${response.statusCode})');
    }
  }

  static MainException handleDioExceptions(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return MainException(
              'Connection timeout. Please check your internet connection and try again.');
        case DioExceptionType.sendTimeout:
          return MainException(
              'Send timeout. The request took too long to send. Please try again.');
        case DioExceptionType.receiveTimeout:
          return MainException(
              'Receive timeout. The server took too long to respond. Please try again.');
        case DioExceptionType.badCertificate:
          return MainException(
              'Bad certificate. There\'s an issue with the server\'s security certificate.');
        case DioExceptionType.badResponse:
          return handleBadResponse(error.response);
        case DioExceptionType.cancel:
          return MainException('The request was cancelled. Please try again.');
        case DioExceptionType.connectionError:
          return MainException(
              'Connection error. Please check your internet connection and try again.');
        case DioExceptionType.unknown:
          return MainException('An unknown error occurred. Please try again.');
      }
    } else if (error is MainException) {
      return error;
    } else {
      return MainException('An unexpected error occurred: ${error.toString()}');
    }
  }
}