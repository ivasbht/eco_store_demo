import 'package:dio/dio.dart';

mixin DioService {


  final Dio dio = Dio();

  void provideServiceObject() {
    dio.options
      ..baseUrl = "https://fakestoreapi.com"
      ..connectTimeout = Duration(seconds: 10)
      ..receiveTimeout = Duration(seconds: 10);
    ;
  }
}
