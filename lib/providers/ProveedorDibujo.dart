import 'package:flutter/material.dart';
import '../models/Trazo.dart';

class ProveedorDibujo extends ChangeNotifier {
  // Lista de trazos ya finalizados.
  final List<Trazo> _trazos = [];
  // Pila de trazos para rehacer después de deshacer.
  final List<Trazo> _pilaRehacer = [];
  // Trazo que se está dibujando en este momento.
  Trazo? _trazoActual;

  // Estado actual de la herramienta de dibujo.
  Color colorSeleccionado = Colors.black;
  double grosorTrazo = 4.0;
  bool esBorrador = false;

  // Exposición segura de los trazos guardados.
  List<Trazo> get trazos => List.unmodifiable(_trazos);
  Trazo? get trazoActual => _trazoActual;

  // Estado de las acciones de deshacer/rehacer.
  bool get puedeDeshacer => _trazos.isNotEmpty;
  bool get puedeRehacer => _pilaRehacer.isNotEmpty;

  void iniciarTrazo(Offset punto) {
    // Al iniciar un nuevo trazo se descarta la pila de rehacer.
    _pilaRehacer.clear();
    _trazoActual = Trazo(
      puntos: [punto],
      color: colorSeleccionado,
      grosor: grosorTrazo,
      esBorrador: esBorrador,
    );
    notifyListeners();
  }

  void agregarPunto(Offset punto) {
    if (_trazoActual == null) return;
    // Añade un nuevo punto al trazo en curso.
    _trazoActual = _trazoActual!.copiarConPunto(punto);
    notifyListeners();
  }

  void terminarTrazo() {
    if (_trazoActual != null) {
      // Guarda el trazo finalizado y resetea el trazo actual.
      _trazos.add(_trazoActual!);
      _trazoActual = null;
      notifyListeners();
    }
  }

  void deshacer() {
    if (_trazos.isNotEmpty) {
      // Mueve el último trazo a la pila de rehacer.
      _pilaRehacer.add(_trazos.removeLast());
      notifyListeners();
    }
  }

  void rehacer() {
    if (_pilaRehacer.isNotEmpty) {
      // Recupera el último trazo deshecho.
      _trazos.add(_pilaRehacer.removeLast());
      notifyListeners();
    }
  }

  void establecerColor(Color color) {
    // Cambia el color activo y desactiva el borrador.
    colorSeleccionado = color;
    esBorrador = false;
    notifyListeners();
  }

  void alternarBorrador() {
    // Activa o desactiva el modo borrador.
    esBorrador = !esBorrador;
    notifyListeners();
  }

  void establecerGrosor(double ancho) {
    // Ajusta el grosor del trazo.
    grosorTrazo = ancho;
    notifyListeners();
  }

  void limpiar() {
    // Elimina todos los trazos y resetea el estado.
    _trazos.clear();
    _pilaRehacer.clear();
    _trazoActual = null;
    notifyListeners();
  }
}
