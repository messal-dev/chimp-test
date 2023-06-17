import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './game_provider.dart';

import './game_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GameProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Chimp Test',
      home: GameScreen(),
    );
  }
}
