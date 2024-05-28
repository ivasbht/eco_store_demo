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
    on<HomeApiCallEvent>(_getAllProducts);
  }

  List<ProductModel> products = [];

  Future<void> _getAllProducts(
    HomeApiCallEvent event,
    Emitter<HomePageState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final response = await service.getProducts();
      if (response.statusCode == 200) {
        print("Data Type : ${response.data.runtimeType} \n");
        final data = response.data;

        (data as List).forEach((json) {
          print("\n $json");
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
}
