import 'package:app_examen/Modelos/genero.dart';

class Paciente {
  int? id;
  String nombre;
  String apellido;
  String cedula;
  String direccion;
  String telefono;
  String correo;
  Genero genero;
  Paciente({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.cedula,
    required this.direccion,
    required this.telefono,
    required this.correo,
    required this.genero,
  });
  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      cedula: json['cedula'],
      direccion: json['direccion'],
      telefono: json['telefono'],
      correo: json['correo'],
      genero: Genero.fromJson(json['genero']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'cedula': cedula,
      'direccion': direccion,
      'telefono': telefono,
      'correo': correo,
      'genero': genero.toJson(),
    };
  }

  @override
  String toString() {
    return 'Paciente{nombre: $nombre, apellido: $apellido}';
  }
}
