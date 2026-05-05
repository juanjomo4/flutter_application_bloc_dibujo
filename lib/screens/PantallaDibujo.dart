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
      body: Stack(
        children: [
          GestureDetector(
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.28),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Deshacer',
                        icon: const Icon(Icons.undo, color: Colors.white),
                        onPressed: proveedor.puedeDeshacer ? proveedor.deshacer : null,
                      ),
                      IconButton(
                        tooltip: 'Rehacer',
                        icon: const Icon(Icons.redo, color: Colors.white),
                        onPressed: proveedor.puedeRehacer ? proveedor.rehacer : null,
                      ),
                      IconButton(
                        tooltip: 'Borrar todo',
                        icon: const Icon(Icons.delete_outline, color: Colors.white),
                        onPressed: () => _confirmarLimpiar(context, proveedor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: const BarraHerramientasDibujo(),
          ),
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
