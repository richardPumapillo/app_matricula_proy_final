// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

MaestriaModel docenteModelFromJson(String str) =>
    MaestriaModel.fromJson(json.decode(str));

String docenteModelToJson(MaestriaModel data) => json.encode(data.toJson());

class MaestriaModel {
  String id;
  String maestria;
  String siglas;
  bool disponible;

  MaestriaModel({
    this.id,
    this.maestria = '',
    this.siglas = '',
    this.disponible = true,
  });

  factory MaestriaModel.fromJson(Map<String, dynamic> json) =>
      new MaestriaModel(
        id: json["id"],
        maestria: json["maestria"],
        siglas: json["siglas"],
        disponible: json["disponible"],
      );

  Map<String, dynamic> toJson() => {
        // "id"         : id,
        "maestria": maestria,
        "siglas": siglas,
        "disponible": disponible,
      };
}
