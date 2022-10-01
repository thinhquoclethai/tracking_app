import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'T-Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
    });
  }

  void _multiply() {
    setState(() {
      _counter *= 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(),
            OutlinedButton(
              onPressed: () => log("hrhe"),
              child: const Text("hehe"),
            ),
            const SizedBox(
              height: 80,
            ),
            const Text("dddddddddddddddddddddddddddddddddddddd")
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            onPressed: _decrement,
            tooltip: 'Increment',
            child: const Icon(Icons.minimize_outlined),
          ),
          const SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            onPressed: _multiply,
            tooltip: 'Increment',
            child: const Icon(Icons.star),
          ),
        ],
      ),
    );
  }
}
