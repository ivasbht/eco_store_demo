part of "cart_page_bloc.dart";

enum CartStatus {
  initializing,
  loading,
  completed,
  error,
}

enum CartProductStatus {
  initializing,
  loading,
  completed,
  error,
}

class CartPageState extends Equatable {
  final CartStatus status;
  final CartProductStatus cartProdStatus;
  final CartModel? cart;
  final List<ProductModel> cartProducts;
  final dynamic error;

  const CartPageState({
    required this.status,
    required this.cartProdStatus,
    this.cart,
    this.cartProducts = const [],
    this.error,
  });

  static CartPageState initial() => const CartPageState(
        cartProdStatus: CartProductStatus.initializing,
        status: CartStatus.initializing,
        cart: null,
        cartProducts: [],
        error: null,
      );

  CartPageState copyWith({
    CartStatus? status,
    CartProductStatus? cartProdStatus,
    CartModel? cart,
    List<ProductModel>? cartProducts,
    dynamic error,
  }) {
    return CartPageState(
      status: status ?? this.status,
      cartProdStatus: cartProdStatus ?? this.cartProdStatus,
      cart: cart ?? this.cart,
      cartProducts: cartProducts ?? this.cartProducts,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, cart];
}
