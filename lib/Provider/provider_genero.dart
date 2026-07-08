import 'package:app_examen/Modelos/genero.dart';
import 'package:app_examen/Servicios/servicio_genero.dart';
import 'package:flutter/material.dart';

class ProviderGenero extends ChangeNotifier {
  final ServicioGenero _servicioGenero = ServicioGenero();
  List<Genero> _generos = [];
  bool _isLoading = false;
  String? _errorMessage;
  List<Genero> get generos => _generos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Future<void> cargarGeneros() async {
    _isLoading = true;
    notifyListeners();
    try {
      _generos = await _servicioGenero.obtenerGeneros();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> guardarGenero(Genero genero) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _servicioGenero.guardarGenero(genero);
      await cargarGeneros();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> actualizarGenero(Genero genero) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _servicioGenero.actualizarGenero(genero);
      await cargarGeneros();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> eliminarGenero(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _servicioGenero.eliminarGenero(id);
      await cargarGeneros();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Genero?> obtenerGeneroPorId(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final genero = await _servicioGenero.obtenerGeneroPorId(id);
      _errorMessage = null;
      return genero;
    } catch (e) {
      _errorMessage = e.toString();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
