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
    on<CartRemoveEvent>(_removeProductFromCart);
    on<CartAddUpdateEvent>(_addUpdateCart);
  }

  List<CartModel> cartDetails = [];

  List<ProductModel> productsAddedInCart = [];

  Future<void> _getCartDetails(
    CartApiCallEvent event,
    Emitter<CartPageState> emit,
  ) async {
    emit(state.copyWith(status: CartStatus.loading));
    try {
      cartDetails.clear();
      final data = service.getAllCart();
      print(data.toString());
      if (data.isNotEmpty) {
        data.forEach((cart) {
          print(cart.runtimeType.toString());
          cartDetails.add(CartModel.fromJson(cart));
        });
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
            error: "Data is empty",
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
      if (event.isLoading) {
        productsAddedInCart.clear();
      }
      for (CartModel cart in cartDetails) {
        if (event.isLoading) {
          final response =
              await service.getSingleProducts(cart.productId.toString());
          if (response.statusCode == 200) {
            productsAddedInCart.add(ProductModel.fromJson(response.data)
              ..quanitity = int.tryParse(cart.quantity.toString()) ?? 0);
          }
        } else {
          for (ProductModel prod in productsAddedInCart) {
            if (prod.id.toString() == cart.productId.toString()) {
              prod.quanitity = int.tryParse(cart.quantity.toString()) ?? 0;
            }
          }
        }
      }
      //
      //
      emit(state.copyWith(
        cartProdStatus: CartProductStatus.completed,
        cartDetails: cartDetails,
      ));
    } catch (error) {
      print(error.toString());
      emit(state.copyWith(
        cartProdStatus: CartProductStatus.error,
        error: error,
      ));
    }
  }

  Future<void> _removeProductFromCart(
    CartRemoveEvent event,
    Emitter<CartPageState> emit,
  ) async {
    try {
      await service.deleteCart(event.productId);
      event.onCompletion();
      emit(state);
    } catch (error) {
      print(error.toString());
      emit(state.copyWith(
        error: error,
      ));
    }
  }

  Future<void> _addUpdateCart(
    CartAddUpdateEvent event,
    Emitter<CartPageState> emit,
  ) async {
    try {
      await service.addUpdateCart(event.cart);
      event.onCompletion();
      emit(state);
    } catch (error) {
      print(error.toString());
      emit(state.copyWith(
        error: error,
      ));
    }
  }
}
