import 'package:app_examen/Modelos/login.request.dart';
import 'package:app_examen/Servicios/servicio_login.dart';
import 'package:app_examen/auth_service.dart';
import 'package:flutter/material.dart';

class ProviderLogin extends ChangeNotifier {
  final ServicioLogin _servicioLogin = ServicioLogin();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;
  String? _token;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get token => _token;

  Future<void> login(LoginRequest request) async {
    _isLoading = true;
    notifyListeners();
    try {
      final loginResponse = await _servicioLogin.login(request);
      await _authService.saveToken(loginResponse.token!);
      _token = loginResponse.token;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.clearToken();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadToken() async {
    _isLoading = true;
    notifyListeners();
    try {
      _token = await _authService.getToken();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
