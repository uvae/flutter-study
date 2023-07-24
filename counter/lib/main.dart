import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int count = 0;

  void onClicked() => setState(() {
        count += 1;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Click Count',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$count',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              IconButton(
                iconSize: 36,
                onPressed: onClicked,
                icon: const Icon(
                  Icons.add_box,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
