import 'dart:convert';

import 'package:app_examen/Modelos/login.request.dart';
import 'package:app_examen/Modelos/login_response.dart';
import 'package:app_examen/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:app_examen/auth_service.dart';

class ServicioLogin {
  final AuthService _authService = AuthService();
  static const String baseUrl = "${ApiConfig.baseUrl}/login";
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse('${baseUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final loginResponse = LoginResponse.fromJson(jsonResponse);
      await _authService.saveToken(loginResponse.token!);
      return loginResponse;
    } else {
      throw Exception('Error al iniciar sesión');
    }
  }
}
