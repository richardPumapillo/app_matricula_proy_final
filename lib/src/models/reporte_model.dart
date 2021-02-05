
import 'dart:convert';

ReporteModel reporteModelFromJson(String str) =>
    ReporteModel.fromJson(json.decode(str));

String reporteModelToJson(ReporteModel data) => json.encode(data.toJson());

class ReporteModel {
  String nombre;
  String descripcion;
  String reporte;

  ReporteModel({
    this.nombre = '',
    this.descripcion = '',
    this.reporte = ''
  });

  factory ReporteModel.fromJson(Map<String, dynamic> json) => new ReporteModel(
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        reporte: json["reporte"],
      );

  Map<String, dynamic> toJson() => {
        // "id"         : id,
        "nombre": nombre,
        "descripcion": descripcion,
        "reporte": reporte
      };
}
