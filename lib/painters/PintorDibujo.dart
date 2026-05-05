import 'package:flutter/material.dart';
import '../models/Trazo.dart';

class PintorDibujo extends CustomPainter {
  final List<Trazo> trazos;
  final Trazo? trazoActual;

  PintorDibujo({required this.trazos, this.trazoActual});

  @override
  void paint(Canvas canvas, Size size) {
    // Color base del papel con un tono crema suave.
    const paperColor = Color(0xFFFAF0DD);
    const paperLineColor = Color(0xFFD2C2A0);
    const paperSpeckColor = Color(0xFFBFA682);

    // Fondo del lienzo con apariencia de hoja de dibujo.
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = paperColor,
    );

    // Combina trazos guardados y el trazo en curso.
    final todosLosTrazos = [...trazos, ?trazoActual];

    for (final trazo in todosLosTrazos) {
      _dibujarTrazo(canvas, trazo, paperColor);
    }

    // Dibuja la textura del papel encima de los trazos para conservar el grano
    // incluso cuando se usa el borrador.
    final grainPaint = Paint()
      ..color = paperLineColor.withAlpha((0.12 * 255).round())
      ..strokeWidth = 1;

    for (double y = 0; y < size.height; y += 18) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grainPaint);
    }

    final speckPaint = Paint()
      ..color = paperSpeckColor.withAlpha((0.08 * 255).round());

    for (double x = 0; x < size.width; x += 24) {
      for (double y = 0; y < size.height; y += 24) {
        canvas.drawCircle(Offset(x + 6, y + 4), 0.8, speckPaint);
        canvas.drawCircle(Offset(x + 16, y + 18), 0.5, speckPaint);
      }
    }
  }

  void _dibujarTrazo(Canvas canvas, Trazo trazo, Color paperColor) {
    if (trazo.puntos.length < 2) return;

    // Configura el pincel con color, ancho y estilo.
    final paint = Paint()
      ..color = trazo.esBorrador ? paperColor : trazo.color
      ..strokeWidth = trazo.esBorrador ? trazo.grosor * 3 : trazo.grosor
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(trazo.puntos.first.dx, trazo.puntos.first.dy);

    for (int i = 1; i < trazo.puntos.length; i++) {
      // Suaviza el trazo interpolando con curvas cuadráticas.
      if (i < trazo.puntos.length - 1) {
        final puntoMedio = Offset(
          (trazo.puntos[i].dx + trazo.puntos[i + 1].dx) / 2,
          (trazo.puntos[i].dy + trazo.puntos[i + 1].dy) / 2,
        );
        path.quadraticBezierTo(
          trazo.puntos[i].dx,
          trazo.puntos[i].dy,
          puntoMedio.dx,
          puntoMedio.dy,
        );
      } else {
        path.lineTo(trazo.puntos[i].dx, trazo.puntos[i].dy);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PintorDibujo oldDelegate) => true;
}
