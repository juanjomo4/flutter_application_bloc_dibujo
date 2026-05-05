import 'package:flutter/material.dart';

// Modelo de datos que representa un trazo dibujado en el lienzo.
class Trazo {
  final List<Offset> puntos;
  final Color color;
  final double grosor;
  final bool esBorrador;

  Trazo({
    required this.puntos,
    required this.color,
    required this.grosor,
    this.esBorrador = false,
  });

  // Crea una copia del trazo añadiendo un nuevo punto al final.
  Trazo copiarConPunto(Offset punto) {
    return Trazo(
      puntos: [...puntos, punto],
      color: color,
      grosor: grosor,
      esBorrador: esBorrador,
    );
  }
}
