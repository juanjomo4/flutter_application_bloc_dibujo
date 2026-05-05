import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../painters/drawing_painter.dart';
import '../providers/drawing_provider.dart';
import '../widgets/toolbar.dart';

class DrawingScreen extends StatelessWidget {
  const DrawingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DrawingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc de Dibujo'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Deshacer',
            icon: const Icon(Icons.undo),
            onPressed: provider.canUndo ? provider.undo : null,
          ),
          IconButton(
            tooltip: 'Rehacer',
            icon: const Icon(Icons.redo),
            onPressed: provider.canRedo ? provider.redo : null,
          ),
          IconButton(
            tooltip: 'Borrar todo',
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmClear(context, provider),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onPanStart: (d) => provider.startStroke(d.localPosition),
              onPanUpdate: (d) => provider.addPoint(d.localPosition),
              onPanEnd: (_) => provider.endStroke(),
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: DrawingPainter(
                    strokes: provider.strokes,
                    currentStroke: provider.currentStroke,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
          ),
          const DrawingToolbar(),
        ],
      ),
    );
  }

  void _confirmClear(BuildContext context, DrawingProvider provider) {
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
              provider.clear();
              Navigator.pop(context);
            },
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
  }
}
