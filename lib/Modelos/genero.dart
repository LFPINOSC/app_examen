class Genero {
  int? id;
  String descripcion;
  Genero({this.id, required this.descripcion});
  factory Genero.fromJson(Map<String, dynamic> json) {
    return Genero(id: json['id'], descripcion: json['descripcion']);
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'descripcion': descripcion};
  }

  @override
  String toString() {
    return 'Genero{id: $id, descripcion: $descripcion}';
  }
}
