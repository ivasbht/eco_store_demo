part of 'home_page_bloc.dart';

enum HomeStatus {
  initializing,
  loading,
  completed,
  error,
}

enum ProductDetailStatus {
  initializing,
  loading,
  completed,
  error,
}

class HomePageState extends Equatable {
  final HomeStatus status;
  final ProductDetailStatus productStatus;
  final ProductModel? productDetails;
  final List<ProductModel>? productModels;
  final dynamic error;

  const HomePageState({
    required this.status,
    required this.productStatus,
    this.productDetails,
    this.productModels,
    this.error,
  });

  static HomePageState initial() => const HomePageState(
        status: HomeStatus.initializing,
        productStatus: ProductDetailStatus.initializing,
        productModels: null,
        productDetails: null,
      );

  HomePageState copyWith({
    HomeStatus? status,
    ProductDetailStatus? productStatus,
    ProductModel? productDetails,
    List<ProductModel>? productModels,
    dynamic error,
  }) {
    if (error != null) {
      print(error.toString());
    }
    return HomePageState(
      status: status ?? this.status,
      productModels: productModels ?? this.productModels,
      productStatus: productStatus ?? this.productStatus,
      productDetails: productDetails ?? this.productDetails,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, productModels, productStatus];
}
