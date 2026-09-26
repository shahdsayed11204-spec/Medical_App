import 'package:dio/dio.dart';

class DioClient {
  static const String _readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMjcwMzkzNmUwNGVhZmRlZDBjMzc0Nzk5Yzg4OGRmNiIsIm5iZiI6MTc4ODIwNTI3OS42MDksInN1YiI6IjZhOTVkOGRmMmM2ZjFkMzhlNzZiYTRiOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2QLvtMvhwJ9d2cCzFzr-Is-WCpFSZ0BP3YI1lAW0cSA';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_readAccessToken',
      },
    ),
  );

  Dio get dio => _dio;

}