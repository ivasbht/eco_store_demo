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

  List<CartModel> cartDetails = [];

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
        (data as List).forEach((cart) {
          cartDetails.add(CartModel.fromJson(cart));
        });

        // final List<ProductModel> products = [];

        emit(
          state.copyWith(
            status: CartStatus.completed,
            cartDetails: cartDetails,
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
    emit(
      state.copyWith(
        cartProdStatus: CartProductStatus.loading,
      ),
    );
    try {
      //
      //
      String prodId = "";
      int quantity = 0;
      ProductModel productAdd;

      for (CartModel cart in event.cartModel) {
        // for (ProductModel productInCart in cart.products)
          for (int i = 0; i < cart.products.length; i++) {
            ProductModel productInCart = cart.products[0];
            prodId = productInCart.id.toString();
            quantity = int.tryParse(productInCart.quanitity.toString()) ?? 0;
            final response = await service.getSingleProducts(prodId);
            if (response.statusCode == 200) {
              print("\nData: " + response.data.toString());
              productInCart = ProductModel.fromJson(response.data);
              print("Product: " + productInCart.toString());
              // productInCart = productAdd;
              productInCart.quanitity = quantity;
              print("\nResult: " + productInCart.toString());
              print("\Cart: " + cart.products.toString());
              print('-------------------------------------------------');
            }
          }
      }

      // await Future.forEach(event.cartModel, (cart) async {
      //   await Future.forEach(cart.products, (productInCart) async {
      //     prodId = productInCart.id.toString();
      //     quantity = int.tryParse(productInCart.quanitity.toString()) ?? 0;
      //     final response = await service.getSingleProducts(prodId);
      //     if (response.statusCode == 200) {
      //       print("\nData: " + response.data.toString());
      //       productAdd = ProductModel.fromJson(response.data);
      //       print("Product: " + productInCart.toString());
      //       productInCart = productAdd;
      //       productInCart.quanitity = quantity;
      //       print("\nResult: " + productInCart.toString());
      //       print("\Cart: " + cart.products.toString());
      //       print('-------------------------------------------------');
      //     }
      //   });
      // });
      emit(state.copyWith(
        cartProdStatus: CartProductStatus.completed,
        cartDetails: cartDetails,
      ));
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
