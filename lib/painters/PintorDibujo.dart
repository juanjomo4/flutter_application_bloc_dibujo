import 'package:flutter/material.dart';
import '../models/Trazo.dart';

class PintorDibujo extends CustomPainter {
  final List<Trazo> trazos;
  final Trazo? trazoActual;

  PintorDibujo({required this.trazos, this.trazoActual});

  @override
  void paint(Canvas canvas, Size size) {
    // Dibuja el fondo blanco del lienzo para que quede limpio.
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.white,
    );

    // Combina trazos guardados y el trazo en curso.
    final todosLosTrazos = [...trazos, ?trazoActual];

    for (final trazo in todosLosTrazos) {
      _dibujarTrazo(canvas, trazo);
    }
  }

  void _dibujarTrazo(Canvas canvas, Trazo trazo) {
    if (trazo.puntos.length < 2) return;

    // Configura el pincel con color, ancho y estilo.
    final paint = Paint()
      ..color = trazo.esBorrador ? Colors.white : trazo.color
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
