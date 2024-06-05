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
  final List<CartModel>? cartDetails;
  final dynamic error;

  const CartPageState({
    required this.status,
    required this.cartProdStatus,
    this.cartDetails,
    this.error,
  });

  static CartPageState initial() => const CartPageState(
        cartProdStatus: CartProductStatus.initializing,
        status: CartStatus.initializing,
        cartDetails: null,
        error: null,
      );

  CartPageState copyWith({
    CartStatus? status,
    CartProductStatus? cartProdStatus,
    List<CartModel>? cartDetails,
    dynamic error,
  }) {
    return CartPageState(
      status: status ?? this.status,
      cartProdStatus: cartProdStatus ?? this.cartProdStatus,
      cartDetails: cartDetails ?? this.cartDetails,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [status, cartProdStatus, cartDetails, error];
}
