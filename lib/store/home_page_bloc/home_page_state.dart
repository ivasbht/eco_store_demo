part of 'home_page_bloc.dart';

enum HomeStatus {
  initializing,
  loading,
  completed,
  error,
}

class HomePageState extends Equatable {
  final HomeStatus status;
  final List<ProductModel>? productModels;
  final dynamic error;

  const HomePageState({required this.status, required this.productModels,this.error});

  static HomePageState initial() => const HomePageState(
        status: HomeStatus.initializing,
        productModels: null,
      );

  HomePageState copyWith({
    HomeStatus? status,
    List<ProductModel>? productModels,
    dynamic error
  }) {
    if(error!=null){
      print(error.toString());
    }
   return  HomePageState(
      status: status ?? this.status,
      productModels: productModels ?? this.productModels,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, productModels];
}
