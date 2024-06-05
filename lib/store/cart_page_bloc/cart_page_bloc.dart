import 'package:eco_store_demo/model/cart_model/cart_model.dart';
import 'package:eco_store_demo/model/product_model/product_model.dart';
import 'package:eco_store_demo/services/app_service/app_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_page_state.dart';
part 'cart_page_events.dart';

class CartPageBloc extends Bloc<CartPageEvent, CartPageState> {
  final AppServices service;
  CartPageBloc({required this.service}) : super(CartPageState.initial()) {
    on<CartApiCallEvent>(_getCartDetails);
    on<CartProductApiCallEvent>(_getCartProductList);
  }

  CartModel? cartDetails;
  List<ProductModel> products = [];

  Future<void> _getCartDetails(
    CartApiCallEvent event,
    Emitter<CartPageState> emit,
  ) async {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      final response = await service.getUserCartList();
      if (response.statusCode == 200) {
        // print("Data Type : ${response.data.runtimeType} \n");
        final data = response.data;
        // print("\n $data");
        cartDetails = CartModel.fromJson(data);

        // final List<ProductModel> products = [];

        emit(
          state.copyWith(
            status: CartStatus.completed,
            cart: cartDetails,
          ),
        );
        event.callProduct();
      } else {
        emit(
          state.copyWith(
            status: CartStatus.error,
            error: response.statusMessage,
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: CartStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _getCartProductList(
    CartProductApiCallEvent event,
    Emitter<CartPageState> emit,
  ) async {
    products.clear();
    emit(
      state.copyWith(
        cartProdStatus: CartProductStatus.loading,
        cartProducts: [],
      ),
    );
    try {
      //
      //
      await Future.forEach<ProductInCartModel>(event.cartModel.products,
          (prod) async {
        final response =
            await service.getSingleProducts(prod.productId.toString());
        if (response.statusCode == 200) {
          final productAdd = ProductModel.fromJson(response.data);
          print(prod.toString());
          productAdd.quanitiy = int.tryParse(prod.quantity.toString()) ?? 0;
          products.add(productAdd);
        }
      });
      //
      print("Complete");
      emit(state.copyWith(
        cartProdStatus: CartProductStatus.completed,
        cartProducts: products,
      ));
      // print(state.props.toString());
      //
      //
    } catch (error) {
      print(error.toString());
      emit(state.copyWith(
        cartProdStatus: CartProductStatus.error,
        error: error,
      ));
    }
  }
}
