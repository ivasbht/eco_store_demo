import 'package:eco_store_demo/model/product_model/product_model.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus {
  initializing,
  loading,
  completed,
  error,
}

class HomePageState extends Equatable {
  final HomeStatus status;
  final ProductModel? photosModel;

  const HomePageState({required this.status, required this.photosModel});

  static HomePageState initial() => const HomePageState(
        status: HomeStatus.initializing,
        photosModel: null,
      );

  HomePageState copyWith({
    HomeStatus? status,
    ProductModel? photosModel,
  }) =>
      HomePageState(
        status: status ?? this.status,
        photosModel: photosModel ?? this.photosModel,
      );

  @override
  List<Object?> get props => [status, photosModel];
}