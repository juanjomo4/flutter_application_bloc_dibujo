import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/drawing_provider.dart';
import 'screens/drawing_screen.dart';

void main() {
  runApp(const DrawingApp());
}

class DrawingApp extends StatelessWidget {
  const DrawingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrawingProvider(),
      child: MaterialApp(
        title: 'Bloc de Dibujo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DrawingScreen(),
      ),
    );
  }
}
