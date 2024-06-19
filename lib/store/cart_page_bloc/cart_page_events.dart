part of "cart_page_bloc.dart";

@immutable
abstract class CartPageEvent extends Equatable {
  const CartPageEvent();
  @override
  List<Object?> get props => [];
}

class CartApiCallEvent extends CartPageEvent {
  final void Function() callProduct;
  const CartApiCallEvent(this.callProduct);
}


class CartProductApiCallEvent extends CartPageEvent {
  const CartProductApiCallEvent();
}

class CartAddEvent extends CartPageEvent {
  const CartAddEvent();
}

class CartUpdateEvent extends CartPageEvent {
  const CartUpdateEvent();
}

class CartRemoveEvent extends CartPageEvent {
  final String cartId;
  final void Function() onCompletion;
  const CartRemoveEvent(this.cartId,this.onCompletion);
}