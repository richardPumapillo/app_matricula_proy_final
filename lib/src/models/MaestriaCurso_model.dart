// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

MaestriaCursoModel docenteModelFromJson(String str) =>
    MaestriaCursoModel.fromJson(json.decode(str));

String docenteModelToJson(MaestriaCursoModel data) =>
    json.encode(data.toJson());

class MaestriaCursoModel {
  String id;
  String maestria_id;
  String curso_id;
  bool disponible;

  MaestriaCursoModel({
    this.id,
    this.maestria_id = '',
    this.curso_id = '',
    this.disponible = true,
  });

  factory MaestriaCursoModel.fromJson(Map<String, dynamic> json) =>
      new MaestriaCursoModel(
        id: json["id"],
        maestria_id: json["maestria_id"],
        curso_id: json["curso_id"],
        disponible: json["disponible"],
      );

  Map<String, dynamic> toJson() => {
        // "id"         : id,
        "maestria_id": maestria_id,
        "curso_id": curso_id,
        "disponible": disponible,
      };
}
