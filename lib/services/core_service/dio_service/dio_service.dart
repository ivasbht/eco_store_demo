import 'package:dio/dio.dart';

class DioService {
  DioService() {
    _provideServiceObject();
  }

  final Dio dio = Dio();

  void _provideServiceObject() {
    dio.options
      ..baseUrl = "https://fakestoreapi.com"
      ..connectTimeout = Duration(seconds: 5)
      ..receiveTimeout = Duration(seconds: 3);
    ;
  }
}
