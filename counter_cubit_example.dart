import 'package:bloc/bloc.dart';

Future<void> main() async {
  final cubit = CounterCubit();
  print(cubit.state.count); // 0
  cubit.increment();
  print(cubit.state.count); // 1
  cubit.close();
}

class CounterCubit extends Cubit<CounterStore> {
  CounterCubit() : super(CounterStore());

  void increment() {
    state.count = state.count + 1;
    emit(state);
  }
}

class CounterStore {
  int count = 0;
}