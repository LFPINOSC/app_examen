import 'package:app_examen/Modelos/paciente.dart';
import 'package:app_examen/Servicios/servicio_paciente.dart';
import 'package:flutter/material.dart';

class ProviderPaciente extends ChangeNotifier {
  final ServicioPaciente _servicioPaciente = ServicioPaciente();
  List<Paciente> _pacientes = [];

  bool _isLoading = false;
  String? _errorMessage;
  Future<void> cargarPacientes() async {
    _isLoading = true;
    notifyListeners();
    try {
      _pacientes = await _servicioPaciente.obtenerPacientes();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> guardarPaciente(Paciente paciente) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _servicioPaciente.guardarPaciente(paciente);
      await cargarPacientes();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> actualizarPaciente(Paciente paciente) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _servicioPaciente.actualizarPaciente(paciente);
      await cargarPacientes();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> eliminarPaciente(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _servicioPaciente.eliminarPaciente(id);
      await cargarPacientes();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Paciente?> obtenerPacientePorId(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final paciente = await _servicioPaciente.obtenerPacientePorId(id);
      _errorMessage = null;
      return paciente;
    } catch (e) {
      _errorMessage = e.toString();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
