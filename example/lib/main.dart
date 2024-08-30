import 'package:flutter/material.dart';
import 'package:simple_state/simple_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MySimplePage extends StatelessWidget {
  MySimplePage({super.key});

  final counter = SimpleState<int>(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("'Flutter Demo Home Page'"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            SimpleBuilder(
                state: counter,
                builder: (context, count) {
                  return Text(
                    '$count',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.value += 1,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final counter = SimpleState<int>(10);
  final isLoading = SimpleState<bool>(false);
  final username = SimpleState<String>("Guest");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: CombinedStateBuilder(
          stateStreams: [
            counter.stream,
            isLoading.stream,
            username.stream,
          ],
          builder: (context, values) {
            final count = values[0] as int? ?? 0;
            final loading = values[1] as bool? ?? false;
            final user = values[2] as String? ?? "Guest";

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Count: $count',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'Loading: $loading',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'User: $user',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                TextButton(
                    onPressed: () {
                      username.value = "Prashant";
                    },
                    child: const Text("data"))
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.value += 1,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
