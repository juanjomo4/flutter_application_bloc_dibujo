import 'package:flutter/material.dart';
import '../models/stroke.dart';

class DrawingProvider extends ChangeNotifier {
  final List<Stroke> _strokes = [];
  final List<Stroke> _redoStack = [];
  Stroke? _currentStroke;

  Color selectedColor = Colors.black;
  double strokeWidth = 4.0;
  bool isEraser = false;

  List<Stroke> get strokes => List.unmodifiable(_strokes);
  Stroke? get currentStroke => _currentStroke;
  bool get canUndo => _strokes.isNotEmpty;
  bool get canRedo => _redoStack.isNotEmpty;

  void startStroke(Offset point) {
    _redoStack.clear(); // Al dibujar, se limpia el historial de redo
    _currentStroke = Stroke(
      points: [point],
      color: selectedColor,
      width: strokeWidth,
      isEraser: isEraser,
    );
    notifyListeners();
  }

  void addPoint(Offset point) {
    if (_currentStroke == null) return;
    _currentStroke = _currentStroke!.copyWithPoint(point);
    notifyListeners();
  }

  void endStroke() {
    if (_currentStroke != null) {
      _strokes.add(_currentStroke!);
      _currentStroke = null;
      notifyListeners();
    }
  }

  void undo() {
    if (_strokes.isNotEmpty) {
      _redoStack.add(_strokes.removeLast());
      notifyListeners();
    }
  }

  void redo() {
    if (_redoStack.isNotEmpty) {
      _strokes.add(_redoStack.removeLast());
      notifyListeners();
    }
  }

  void setColor(Color color) {
    selectedColor = color;
    isEraser = false;
    notifyListeners();
  }

  void toggleEraser() {
    isEraser = !isEraser;
    notifyListeners();
  }

  void setStrokeWidth(double width) {
    strokeWidth = width;
    notifyListeners();
  }

  void clear() {
    _strokes.clear();
    _redoStack.clear();
    _currentStroke = null;
    notifyListeners();
  }
}
