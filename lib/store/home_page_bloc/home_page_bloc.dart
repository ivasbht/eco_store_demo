import 'package:eco_store_demo/model/product_model/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eco_store_demo/services/app_service/app_service.dart';

part "home_page_events.dart";
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final AppServices service;
  HomePageBloc({required this.service}) : super(HomePageState.initial()) {
    on<HomeProductListCallEvent>(_getAllProducts);
    on<HomeProductDetailCallEvent>(_getProductDetail);
  }

  Future<void> _getAllProducts(
    HomeProductListCallEvent event,
    Emitter<HomePageState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final response = await service.getProducts();
      if (response.statusCode == 200) {
        // print("Data Type : ${response.data.runtimeType} \n");
        final data = response.data;
        final List<ProductModel> products = [];

        (data as List).forEach((json) {
          // print("\n $json");
          products.add(ProductModel.fromJson(json));
        });
        emit(
          state.copyWith(
            status: HomeStatus.completed,
            productModels: products,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: HomeStatus.error,
            error: response.statusMessage,
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _getProductDetail(
    HomeProductDetailCallEvent event,
    Emitter<HomePageState> emit,
  ) async {
    emit(state.copyWith(productStatus: ProductDetailStatus.loading));
    try {
      final response = await service.getSingleProducts(event.prodId);
      if (response.statusCode == 200) {
        // print("${response.data}");
        // throw "Product cant be processed";
        final productDetails = ProductModel.fromJson(response.data);
        emit(
          state.copyWith(
            productStatus: ProductDetailStatus.completed,
            productDetails: productDetails,
          ),
        );
      } else {
        emit(
          state.copyWith(
            productStatus: ProductDetailStatus.error,
            error: response.statusMessage,
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          productStatus: ProductDetailStatus.error,
          error: error,
        ),
      );
    }
  }
}
