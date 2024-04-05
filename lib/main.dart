import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stop Watch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isTimer = false;
  Timer? _timer;
  int _ms = 0;
  int _hh = 0;
  int _mm = 0;
  int _ss = 0;
  int _nn = 0;

  void _togleTimer() {
    if (!_isTimer) {
      _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
        setState(() {
          _ms++;
          _hh = _ms ~/ 360000;
          _mm = (_ms % 360000) ~/ 6000;
          _ss = ((_ms % 360000) % 6000) ~/ 100;
          _nn = ((_ms % 360000) % 6000) % 100;
        });
      });
    } else {
      _timer?.cancel();
    }
    setState(() {
      _isTimer = !_isTimer;
    });
  }

  void _resetTimer() {
    setState(() {
      _timer?.cancel();
      _isTimer = false;
      _ms = _hh = _mm = _ss = _nn = 0;
    });
  }

  String _numFormat(int num) {
    return num.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${_numFormat(_hh)}:${_numFormat(_mm)}:${_numFormat(_ss)}.${_numFormat(_nn)}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _togleTimer,
                  child: Text(_isTimer ? 'STOP' : 'START'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isTimer ? null : _resetTimer,
                  child: const Text('RESET'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
