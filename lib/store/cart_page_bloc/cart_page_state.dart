part of "cart_page_bloc.dart";

enum CartStatus {
  initializing,
  loading,
  completed,
  error,
}

class CartPageState extends Equatable {
  final CartStatus status;
  final CartModel? cart;
  final dynamic error;

  const CartPageState({
    required this.status,
    this.cart,
    this.error,
  });

  static CartPageState initial() => const CartPageState(
        status: CartStatus.initializing,
        cart: null,
        error: null,
      );

  CartPageState copyWith({
    CartStatus? status,
    CartModel? cart,
    dynamic error,
  }) {
    return CartPageState(
      status: status ?? this.status,
      cart: cart ?? this.cart,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, cart];

}
