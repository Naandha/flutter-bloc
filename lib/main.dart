import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocs/counter/count_bloc.dart';


void main() {
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider<CountBloc>(
            create: (BuildContext context) => CountBloc(),
          ),
        ],
        child: MaterialApp(home: MyApp(),)
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter App')),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     context.read<CountBloc>().add(decrement());
      //   },
      //   child: const Text("-"),
      // ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){ context.read<CountBloc>().add(increment());},
                child: Text("Add")),

            ElevatedButton(onPressed: (){ context.read<CountBloc>().add(decrement());},
                child: Text("Minimize")),
            BlocBuilder<CountBloc, CountState>(
              builder: (context, state) {
                return Text(
                  "${state.count}",
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}