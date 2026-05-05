import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drawing_provider.dart';

class DrawingToolbar extends StatelessWidget {
  const DrawingToolbar({super.key});

  static const _colors = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DrawingProvider>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Paleta de colores + borrador
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ..._colors.map(
                (color) => _ColorDot(
                  color: color,
                  isSelected:
                      !provider.isEraser && provider.selectedColor == color,
                  onTap: () => provider.setColor(color),
                ),
              ),
              const SizedBox(width: 8),
              _EraserButton(isActive: provider.isEraser),
            ],
          ),
          // Grosor del trazo
          Row(
            children: [
              const Icon(Icons.brush, size: 18, color: Colors.grey),
              Expanded(
                child: Slider(
                  min: 1,
                  max: 20,
                  value: provider.strokeWidth,
                  onChanged: provider.setStrokeWidth,
                ),
              ),
              SizedBox(
                width: 36,
                child: Text(
                  '${provider.strokeWidth.toInt()}px',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorDot({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.all(3),
        width: isSelected ? 34 : 28,
        height: isSelected ? 34 : 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
            width: isSelected ? 3 : 1,
          ),
        ),
      ),
    );
  }
}

class _EraserButton extends StatelessWidget {
  final bool isActive;

  const _EraserButton({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<DrawingProvider>().toggleEraser(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.all(3),
        width: isActive ? 38 : 32,
        height: isActive ? 38 : 32,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: isActive ? Colors.deepPurple : Colors.grey.shade400,
            width: isActive ? 3 : 1,
          ),
        ),
        child: Icon(
          Icons.auto_fix_high,
          size: isActive ? 20 : 16,
          color: isActive ? Colors.deepPurple : Colors.grey,
        ),
      ),
    );
  }
}
