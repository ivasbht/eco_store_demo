part of "cart_page_bloc.dart";

@immutable
abstract class CartPageEvent extends Equatable {
  const CartPageEvent();
  @override
  List<Object?> get props => [];
}

class CartApiCallEvent extends CartPageEvent {
  final void Function() callProduct;
  final bool isLoading;
  const CartApiCallEvent(this.callProduct, {this.isLoading = true});
}

class CartProductApiCallEvent extends CartPageEvent {
  final bool isLoading;
  const CartProductApiCallEvent({this.isLoading = true});
}

class CartAddUpdateEvent extends CartPageEvent {
  final CartModel cart;
  final void Function() onCompletion;
  const CartAddUpdateEvent(this.cart, this.onCompletion);
}

class CartRemoveEvent extends CartPageEvent {
  final String productId;
  final void Function() onCompletion;
  const CartRemoveEvent(this.productId, this.onCompletion);
}
