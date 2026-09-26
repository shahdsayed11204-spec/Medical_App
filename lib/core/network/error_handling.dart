import 'package:dio/dio.dart';

import 'failures.dart';

class ErrorHandling {
  static Failures handleError(DioException error) {
    switch (error.type){
      case DioExceptionType.connectionError:
      return NetworkFailure();
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: "Time out , Try again");
      case DioExceptionType.badResponse:
        throw handleBadResponse(error);
      case DioExceptionType.cancel:
        return ServerFailure(message: "Canceled");
      case DioExceptionType.badCertificate:
        throw UnimplementedError();
      case DioExceptionType.unknown:
        throw UnimplementedError();
      case DioExceptionType.transformTimeout:
        throw UnimplementedError();
    }
  }

  static Failures handleBadResponse(DioException error){
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    switch (statusCode){
      case 400:
        return ServerFailure(message: data?['message'] ?? 'Bad Request');
      case 401:
        return UnauthorizedFailure();
      case 403:
        return ServerFailure(message: 'Forbidden request. ');

      case 404:
        return NotFoundFailure();

      case 500:
        return ServerFailure(message: 'Server error. Try again later.');

      default:
        return ServerFailure(
          message: data?['message'] ?? 'Unexpected error occurred',
        );
    }
  }

}