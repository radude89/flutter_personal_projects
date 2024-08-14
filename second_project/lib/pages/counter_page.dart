import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You pushed the button many times:"),

            Text(
                _counter.toString(),
              style: TextStyle(fontSize: 40),
            ),

            Column(
              children: [
                ElevatedButton(
                    onPressed: _incrementCounter,
                    child: Text("Increment")
                ),
                ElevatedButton(
                    onPressed: _resetCounter,
                    child: Text("Reset")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
