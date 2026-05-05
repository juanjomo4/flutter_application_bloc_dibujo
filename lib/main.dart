import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_color/dynamic_color.dart';
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
      child: DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          final lightScheme = lightDynamic ?? ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          );
          final darkScheme = darkDynamic ?? ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          );

          return MaterialApp(
            title: 'Bloc de Dibujo',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightScheme,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkScheme,
              brightness: Brightness.dark,
            ),
            home: const DrawingScreen(),
          );
        },
      ),
    );
  }
}
