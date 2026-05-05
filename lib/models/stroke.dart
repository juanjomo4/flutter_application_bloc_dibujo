import 'package:flutter/material.dart';

class Stroke {
  final List<Offset> points;
  final Color color;
  final double width;
  final bool isEraser;

  Stroke({
    required this.points,
    required this.color,
    required this.width,
    this.isEraser = false,
  });

  // Devuelve una copia con un punto adicional
  Stroke copyWithPoint(Offset point) {
    return Stroke(
      points: [...points, point],
      color: color,
      width: width,
      isEraser: isEraser,
    );
  }
}
