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
  String maestriaid;
  String cursoid;
  bool disponible;

  MaestriaCursoModel({
    this.id,
    this.maestriaid = '',
    this.cursoid = '',
    this.disponible = true,
  });

  factory MaestriaCursoModel.fromJson(Map<String, dynamic> json) =>
      new MaestriaCursoModel(
        id: json["id"],
        maestriaid: json["maestriaid"],
        cursoid: json["cursoid"],
        disponible: json["disponible"],
      );

  Map<String, dynamic> toJson() => {
        // "id"         : id,
        "maestriaid": maestriaid,
        "cursoid": cursoid,
        "disponible": disponible,
      };
}
