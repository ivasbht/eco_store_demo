part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
  @override
  List<Object?> get props => [];
}

class HomeProductListCallEvent extends HomePageEvent {
  const HomeProductListCallEvent();
}

class HomeProductDetailCallEvent extends HomePageEvent {
  final String prodId;
  const HomeProductDetailCallEvent(this.prodId);
}