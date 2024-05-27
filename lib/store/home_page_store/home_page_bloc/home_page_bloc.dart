import 'package:bloc/bloc.dart';
import 'package:eco_store_demo/model/product_model/product_model.dart';
import 'package:eco_store_demo/store/home_page_store/home_page_events/home_page_events.dart';
import 'package:eco_store_demo/store/home_page_store/home_page_state/home_page_state.dart';
import 'package:eco_store_demo/services/app_service/app_service.dart';

class HomePageBloc extends Bloc<HomePageEvents, HomePageState> {
  AppServices service = AppServices();
  HomePageBloc() : super(HomePageState.initial()){
    _getAllProducts();
  }

  List<ProductModel> products = [];

  Future<void> _getAllProducts() async {
    state = HomePageState.loading;
    final response = await service.getProducts();
    final data = response.data;

    (data as List<Map<String, dynamic>>).forEach((json) {
      products.add(ProductModel.fromJson(json));
    });
  }
}
