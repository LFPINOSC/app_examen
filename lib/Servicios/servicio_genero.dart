import 'dart:convert';

import 'package:app_examen/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:app_examen/Modelos/genero.dart';
import 'package:app_examen/app_config.dart';

class ServicioGenero {
  static const String baseUrl = "${ApiConfig.baseUrl}/generos";

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

  Future<List<Genero>> obtenerGeneros() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: await _headers(),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Genero.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los géneros');
    }
  }

  Future<Genero> guardarGenero(Genero genero) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: await _headers(),
      body: json.encode(genero.toJson()),
    );
    if (response.statusCode == 201) {
      return Genero.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al guardar el género');
    }
  }

  Future<Genero> actualizarGenero(Genero genero) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${genero.id}'),
      headers: await _headers(),
      body: json.encode(genero.toJson()),
    );
    if (response.statusCode == 200) {
      return Genero.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar el género');
    }
  }

  Future<void> eliminarGenero(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: await _headers(),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el género');
    }
  }

  Future<Genero> obtenerGeneroPorId(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: await _headers(),
    );
    if (response.statusCode == 200) {
      return Genero.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener el género por ID');
    }
  }
}
