import 'package:dio/dio.dart';

import 'failures.dart';

class ErrorHandling {
  static Failures handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
        return const NetworkFailure();
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(message: 'timeout');
      case DioExceptionType.badResponse:
        return handleBadResponse(error);
      case DioExceptionType.cancel:
        return const ServerFailure(message: 'canceled');
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
      case DioExceptionType.transformTimeout:
        return const UnExpectedFailure();
    }
  }

  static Failures handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    switch (statusCode) {
      case 400:
        return ServerFailure(
          message: data is Map ? (data['message']?.toString() ?? 'bad-request') : 'bad-request',
          statusCode: 400,
        );
      case 401:
        return const UnauthorizedFailure();
      case 403:
        return const ServerFailure(message: 'forbidden', statusCode: 403);
      case 404:
        return const NotFoundFailure();
      case 500:
        return const ServerFailure(message: 'server', statusCode: 500);
      default:
        return ServerFailure(
          message: data is Map ? (data['message']?.toString() ?? 'unexpected') : 'unexpected',
          statusCode: statusCode,
        );
    }
  }
}