part of "cart_page_bloc.dart";

@immutable
abstract class CartPageEvent extends Equatable {
  const CartPageEvent();
  @override
  List<Object?> get props => [];
}

class CartApiCallEvent extends CartPageEvent {
  const CartApiCallEvent();
}