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

  // Bonus: prevents popup from spamming while staying at 100
  bool _liftoffDialogShown = false;

  void _setCounter(int next) {
    final int clamped = next.clamp(0, 100);

    // true only when we cross into 100 from below
    final bool firstTimeHitting100 = (_counter < 100 && clamped == 100);

    setState(() {
      _counter = clamped;

      // if we move away from 100, allow popup next time we hit 100
      if (_counter < 100) _liftoffDialogShown = false;
    });

    if (firstTimeHitting100 && !_liftoffDialogShown) {
      _liftoffDialogShown = true;

      // show after the frame so it doesn't fight build/setState
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('🚀 LIFTOFF!'),
            content: const Text('Launch Successful!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }
  }

  void _ignite() => _setCounter(_counter + 1);
  void _decrement() => _setCounter(_counter - 1);
  void _reset() => _setCounter(0);

  Color _statusColor() {
    if (_counter == 0) return Colors.red;
    if (_counter <= 50) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final bool liftoff = _counter == 100;

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
                liftoff ? 'LIFTOFF!' : '$_counter',
                style: TextStyle(
                  fontSize: liftoff ? 42.0 : 50.0,
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
            onChanged: (double value) => _setCounter(value.toInt()),
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