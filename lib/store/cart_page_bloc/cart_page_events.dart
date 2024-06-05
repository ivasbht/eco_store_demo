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
  final CartModel cartModel;
  const CartProductApiCallEvent(this.cartModel);
}