import 'dart:convert';

PerfilModel perfilModelFromJson(String str) =>
    PerfilModel.fromJson(json.decode(str));
String perfilModelToJson(PerfilModel data) => json.encode(data.toJson());

class PerfilModel {
  String id;
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String idUsuario;

  PerfilModel(
      {this.id,
      this.nombre = '',
      this.apellidoPaterno = '',
      this.apellidoMaterno = '',
      this.idUsuario = ''});

  factory PerfilModel.fromJson(Map<String, dynamic> json) => new PerfilModel(
      id: json["id"],
      nombre: json["nombre"],
      apellidoPaterno: json["apellidoPaterno"],
      apellidoMaterno: json["apellidoMaterno"],
      idUsuario: json["idUsuario"]);

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "idUsuario": idUsuario
      };
}
