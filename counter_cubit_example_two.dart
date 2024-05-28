import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CounterCubit(),
        child: CounterScreen(),
      ),
    );
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cubit Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<CounterCubit, CounterStore>(
              builder: (context, state) {
                return Text(
                  state.countState == CounterState.increased
                      ? 'Counter Increased!'
                      : 'Initial State',
                  style: TextStyle(fontSize: 24),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<CounterCubit>().increment();
              },
              child: Text('Increment Counter'),
            ),
          ],
        ),
      ),
    );
  }
}

enum CounterState { initial, increased }

class CounterCubit extends Cubit<CounterStore> {
  CounterCubit() : super(CounterStore());

  void increment() {
    state.countState = CounterState.increased;
    emit(state);
  }
}

class CounterStore{
  CounterState countState = CounterState.initial;
}
