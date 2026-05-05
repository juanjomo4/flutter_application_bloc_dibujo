import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../painters/PintorDibujo.dart';
import '../providers/ProveedorDibujo.dart';
import '../widgets/BarraHerramientasDibujo.dart';

class PantallaDibujo extends StatelessWidget {
  const PantallaDibujo({super.key});

  @override
  Widget build(BuildContext context) {
    final proveedor = context.watch<ProveedorDibujo>();

    return Scaffold(
      // AppBar superior con acciones de deshacer, rehacer y limpiar.
      appBar: AppBar(
        title: const Text('Bloc de Dibujo'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Deshacer',
            icon: const Icon(Icons.undo),
            onPressed: proveedor.puedeDeshacer ? proveedor.deshacer : null,
          ),
          IconButton(
            tooltip: 'Rehacer',
            icon: const Icon(Icons.redo),
            onPressed: proveedor.puedeRehacer ? proveedor.rehacer : null,
          ),
          IconButton(
            tooltip: 'Borrar todo',
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmarLimpiar(context, proveedor),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              // Captura el inicio, seguimiento y fin del trazo del dedo.
              onPanStart: (d) => proveedor.iniciarTrazo(d.localPosition),
              onPanUpdate: (d) => proveedor.agregarPunto(d.localPosition),
              onPanEnd: (_) => proveedor.terminarTrazo(),
              child: RepaintBoundary(
                child: CustomPaint(
                  // Lienzo que pinta los trazos actuales y los ya guardados.
                  painter: PintorDibujo(
                    trazos: proveedor.trazos,
                    trazoActual: proveedor.trazoActual,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
          ),
          // Barra de herramientas inferior con selección de color y grosor.
          const BarraHerramientasDibujo(),
        ],
      ),
    );
  }

  void _confirmarLimpiar(BuildContext context, ProveedorDibujo proveedor) {
    // Muestra un diálogo de confirmación antes de limpiar el lienzo.
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Borrar todo'),
        content: const Text('¿Seguro que quieres limpiar el lienzo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              proveedor.limpiar();
              Navigator.pop(context);
            },
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
  }
}
