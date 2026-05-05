import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/ProveedorDibujo.dart';
import '../theme/HyperOSTheme.dart';

class BarraHerramientasDibujo extends StatelessWidget {
  const BarraHerramientasDibujo({super.key});

  // Lista de colores disponibles en la paleta.
  static const _colores = [
    Colors.black,
    Colors.grey,
    HyperOSTheme.hyperOSBlue,
    HyperOSTheme.hyperOSRed,
    HyperOSTheme.hyperOSGreen,
    HyperOSTheme.hyperOSYellow,
    HyperOSTheme.hyperOSPurple,
    HyperOSTheme.hyperOSPink,
  ];

  @override
  Widget build(BuildContext context) {
    final proveedor = context.watch<ProveedorDibujo>();
    // final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.28),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, -0.5),
          ),
          
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          // Caja de selección de color + botón de borrador
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final color in _colores) ...[
                    _PuntoColor(
                      color: color,
                      isSelected:
                          !proveedor.esBorrador && proveedor.colorSeleccionado == color,
                      onTap: () => proveedor.establecerColor(color),
                    ),
                    const SizedBox(width: 3),
                  ],
                  // Botón para activar el modo borrador.
                  _BotonBorrador(isActive: proveedor.esBorrador),
                ],
              ),
            ),
          ),
          // Ajuste de grosor del trazo
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.brush,
                  size: 20,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Slider(
                    min: 1,
                    max: 20,
                    value: proveedor.grosorTrazo,
                    onChanged: proveedor.establecerGrosor,
                    label: '${proveedor.grosorTrazo.toInt()}px',
                    thumbColor: Colors.white,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white.withAlpha((0.3 * 255).round()),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 40,
                  child: Text(
                    '${proveedor.grosorTrazo.toInt()}px',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PuntoColor extends StatefulWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _PuntoColor({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_PuntoColor> createState() => _PuntoColorState();
}

class _PuntoColorState extends State<_PuntoColor>
    with SingleTickerProviderStateMixin {
  // Controlador de animación para el efecto de selección.
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(_PuntoColor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _controller.forward();
    } else if (!widget.isSelected && oldWidget.isSelected) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Selecciona el color al tocar el punto de color.
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1, end: 1.15).animate(_controller),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          width: widget.isSelected ? 36 : 32,
          height: widget.isSelected ? 36 : 32,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.isSelected
                  ? Colors.white.withAlpha((0.8 * 255).round())
                  : Colors.transparent,
              width: widget.isSelected ? 2 : 0,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: widget.color.withAlpha((0.4 * 255).round()),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
        ),
      ),
    );
  }
}

class _BotonBorrador extends StatefulWidget {
  final bool isActive;

  const _BotonBorrador({required this.isActive});

  @override
  State<_BotonBorrador> createState() => _BotonBorradorState();
}

class _BotonBorradorState extends State<_BotonBorrador>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(_BotonBorrador oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.forward();
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => context.read<ProveedorDibujo>().alternarBorrador(),
      child: ScaleTransition(
        scale: Tween<double>(begin: 1, end: 1.15).animate(_controller),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          width: widget.isActive ? 36 : 32,
          height: widget.isActive ? 36 : 32,
          decoration: BoxDecoration(
            color: widget.isActive
                ? theme.colorScheme.primary
                : theme.colorScheme.surfaceContainerHigh,
            shape: BoxShape.circle,
            boxShadow: widget.isActive
                ? [
                    BoxShadow(
                      color: theme.colorScheme.primary.withAlpha((0.3 * 255).round()),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Icon(
            Icons.auto_fix_high,
            size: widget.isActive ? 18 : 16,
            color: widget.isActive
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
