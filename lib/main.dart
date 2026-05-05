import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'providers/ProveedorDibujo.dart';
import 'screens/PantallaDibujo.dart';
import 'theme/HyperOSTheme.dart';

void main() {
  // Punto de entrada de la aplicación Flutter.
  // Ejecuta el widget raíz con el proveedor de estado.
  runApp(const AplicacionDibujo());
}

class AplicacionDibujo extends StatelessWidget {
  const AplicacionDibujo({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Proveedor de estado global para el dibujo.
      create: (_) => ProveedorDibujo(),
      child: DynamicColorBuilder(
        builder: (ColorScheme? esquemaClaro, ColorScheme? esquemaOscuro) {
          final esquemaClaroReal = esquemaClaro ?? ColorScheme.fromSeed(
            seedColor: HyperOSTheme.hyperOSBlue,
            brightness: Brightness.light,
          );
          final esquemaOscuroReal = esquemaOscuro ?? ColorScheme.fromSeed(
            seedColor: HyperOSTheme.hyperOSBlue,
            brightness: Brightness.dark,
          );

          return MaterialApp(
            title: 'Bloc de Dibujo',
            debugShowCheckedModeBanner: false,
            // Usa el tema claro u oscuro según la configuración del sistema.
            themeMode: ThemeMode.system,
            theme: HyperOSTheme.lightTheme(esquemaClaroReal),
            darkTheme: HyperOSTheme.darkTheme(esquemaOscuroReal),
            home: const PantallaDibujo(),
          );
        },
      ),
    );
  }
}
