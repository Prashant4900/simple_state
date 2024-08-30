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
      home: const MySimplePage(),
    );
  }
}

final counterState = SimpleState(10.0);

class MySimplePage extends StatelessWidget {
  const MySimplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Flutter Demo Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            SimpleBuilder(
                state: counterState,
                builder: (context, count) {
                  return Text(
                    '$count',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MySimplePageSecond(),
                  ),
                );
              },
              child: const Text("Move"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterState.value += 1,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MySimplePageSecond extends StatelessWidget {
  const MySimplePageSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '2 Page',
            ),
            SimpleBuilder(
                state: counterState,
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
        onPressed: () => counterState.value += 1,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
