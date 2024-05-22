import 'package:bloc/bloc.dart';
import 'package:eco_store_demo/store/home_page_store/home_page_store.dart';

sealed class HomePageEvents {}

// Events Created
final class HomePageInitiate extends HomePageEvents {}

final class HomePageError extends HomePageEvents {}
//

class HomePageBloc extends Bloc<HomePageEvents, HomePageStore> {
  HomePageBloc() : super(HomePageStore());
}
