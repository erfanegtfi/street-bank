import 'package:dio/dio.dart';

class AppDio {
  Dio getDio() {
    var dio = Dio();
    dio.options = BaseOptions(
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      headers: {
        "Connection": "keep-alive",
        "Accept-Encoding": "gzip, deflate",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
    return dio;
  }
}
