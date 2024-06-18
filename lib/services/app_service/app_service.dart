import 'package:dio/dio.dart';
import 'package:eco_store_demo/services/core_service/dio_service/dio_service.dart';

class AppServices extends  DioService {

  final userId = 1; // for demo purpose until login is made
  final id = 1;

  Future<Response> getProducts({int limit = 20, bool sortDesc = true}) async {
    final _response = await dio
        .get("/products?limit=$limit&sort=${sortDesc ? "desc" : "asc"}");
    return _response;
  }

  Future<Response> getSingleProducts(String id) async {
    final _response = await dio.get("/products/$id");
    return _response;
  }

  Future<Response> getAllCategories() async {
    final _response = await dio.get("/products/categories");
    return _response;
  }

  Future<Response> getSpecificProductCategory(String categoryName) async {
    final _response = await dio.get("/products/categories/$categoryName");
    return _response;
  }

  Future<Response> getUserCartList() async {
    final _response = await dio.get("/carts/user/$userId");
    return _response;
  }

  Future<Response> updateUserCartList(String id) async {
    final _response = await dio.put("/carts/user/$userId");
    return _response;
  }

}
