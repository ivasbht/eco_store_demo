import 'package:eco_store_demo/model/product_model/product_model.dart';
import 'package:eco_store_demo/services/app_service/app_service.dart';

class HomePageStore extends AppServices {
  List<ProductModel> products = [];
  HomePageStore() {}

  Future<void> getAllProducts() async {
    final response = await getProducts();
    final data = response.data;

    (data as List<Map<String,dynamic>>).forEach((json) { 
      products.add(ProductModel.fromJson(json));
    });
  }
}
