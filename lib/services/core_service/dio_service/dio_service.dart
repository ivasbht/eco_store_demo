import 'package:dio/dio.dart';

class DioService {
  DioService() {
    _provideServiceObject();
  }

  final Dio dio = Dio();

  void _provideServiceObject() {
    dio.options
      ..baseUrl = "https://fakestoreapi.com"
      ..connectTimeout = Duration(seconds: 10)
      ..receiveTimeout = Duration(seconds: 10);
    ;
  }
}
