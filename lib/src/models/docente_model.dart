// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

DocenteModel docenteModelFromJson(String str) => DocenteModel.fromJson(json.decode(str));

String docenteModelToJson(DocenteModel data) => json.encode(data.toJson());

class DocenteModel {

    String id;
    String nombres;
    String apellidos;
    int edad;
    String correo;
    bool disponible;

    DocenteModel({
        this.id,
        this.nombres = '',
        this.apellidos = '',
        this.edad  = 0,
        this.correo = '',
        this.disponible = true,
    });

    factory DocenteModel.fromJson(Map<String, dynamic> json) => new DocenteModel(
        id          : json["id"],
        nombres     : json["nombres"],
        apellidos   : json["apellidos"],
        edad        : json["edad"],
        correo      : json["correo"],
        disponible  : json["disponible"],
    );

    Map<String, dynamic> toJson() => {
        // "id"         : id,
        "nombres"     : nombres,
        "apellidos"   : apellidos,
        "edad"        : edad,
        "correo"      : correo,
        "disponible"  : disponible,
    };
}
