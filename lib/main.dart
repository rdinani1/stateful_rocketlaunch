import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch Controller',
      theme: ThemeData(primarySwatch: Colors.blue),
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

  void _ignite() {
    setState(() {
      if (_counter < 100) _counter++;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  Color _statusColor() {
    if (_counter == 0) return Colors.red;
    if (_counter <= 50) return Colors.orange;
    return Colors.green;
  }

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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                border: Border.all(color: _statusColor(), width: 4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$_counter',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  color: _statusColor(),
                ),
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

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _ignite,
                child: const Text('Ignite'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _decrement,
                child: const Text('Decrement'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _reset,
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}