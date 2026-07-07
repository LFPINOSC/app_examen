import 'dart:convert';

import 'package:app_examen/Modelos/paciente.dart';
import 'package:app_examen/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:app_examen/app_config.dart';

class ServicioPaciente {
  static const String baseUrl = "${ApiConfig.baseUrl}/pacientes";

  final AuthService authService = AuthService();

  Future<Map<String, String>> _headers() async {
    final token = await authService.getToken();
    if (token == null) {
      throw Exception('No se encontró el token de autenticación');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<Paciente>> obtenerPacientes() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: await _headers(),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Paciente.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los pacientes');
    }
  }

  Future<Paciente> guardarPaciente(Paciente paciente) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: await _headers(),
      body: json.encode(paciente.toJson()),
    );
    if (response.statusCode == 201) {
      return Paciente.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al guardar el paciente');
    }
  }

  Future<Paciente> actualizarPaciente(Paciente paciente) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${paciente.id}'),
      headers: await _headers(),
      body: json.encode(paciente.toJson()),
    );
    if (response.statusCode == 200) {
      return Paciente.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar el paciente');
    }
  }

  Future<void> eliminarPaciente(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: await _headers(),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el paciente');
    }
  }

  Future<Paciente> obtenerPacientePorId(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: await _headers(),
    );
    if (response.statusCode == 200) {
      return Paciente.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener el paciente por ID');
    }
  }
}
