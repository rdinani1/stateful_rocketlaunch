import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Launch Controller'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.blue,
              child: Text(
                '$_counter',
                style: const TextStyle(fontSize: 50.0),
              ),
            ),
          ),

          // Slider
          Slider(
            min: 0,
            max: 100,
            divisions: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                _counter = value.toInt();
              });
            },
            activeColor: Colors.blue,
            inactiveColor: Colors.red,
          ),

          const SizedBox(height: 20),

          // 🔥 Ignite Button
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (_counter < 100) {
                  _counter++;
                }
              });
            },
            child: const Text('Ignite'),
          ),

          const SizedBox(height: 10),

          // ⬇ Decrement Button
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (_counter > 0) {
                  _counter--;
                }
              });
            },
            child: const Text('Decrement'),
          ),
        ],
      ),
    );
  }
}