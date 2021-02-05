import 'dart:convert';

import 'package:app_matricula_proy_final/src/models/matricula_model.dart';
import 'package:app_matricula_proy_final/src/models/reporte_model.dart';
import 'package:app_matricula_proy_final/src/pages/reportes/models/bar_chart_model.dart';
import 'package:app_matricula_proy_final/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class ReportesProvider {
  final String _url = 'https://app-matricula-default-rtdb.firebaseio.com';
  final _prefs = new PreferenciasUsuario();


  Future<List<ReporteModel>> cargarReportes() async {

    final List<ReporteModel> reportes = new List();

    ReporteModel reporte1 = new ReporteModel();
    reporte1.nombre = "Alumnos por Ciclo";
    reporte1.descripcion = "Informacion de Aforo";
    reporte1.reporte = "ReportesMatriculas";

    ReporteModel reporte2 = new ReporteModel();
    reporte2.nombre = "Cursos Populares";
    reporte2.descripcion = "De acuerdo a las matriculas";
    reporte2.reporte = "DonutMatriculas";

    reportes.add(reporte1);
    reportes.add(reporte2);

    return reportes;
  }

  Future<List<BarChartModel>> cargarReporteAlumnos() async {
    final url = '$_url/matricula.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<BarChartModel> chart = new List();

    if (decodedData == null) return [];

    int countI = 0;
    int countII = 0;
    int countIII = 0;
    int countIV = 0;

    decodedData.forEach((id, prod) {
      final prodTemp = MatriculaModel.fromJson(prod);
      if (prodTemp.ciclo == "I")
        countI++;
      if (prodTemp.ciclo == "II")
        countII++;
      if (prodTemp.ciclo == "III")
        countIII++;
      if (prodTemp.ciclo == "IV")
        countIV++;
    });

    final List<BarChartModel> data =  [
      BarChartModel(
        year: "I",
        financial: countI,
        color: charts.ColorUtil.fromDartColor(Color(0xFF47505F)),
      ),
      BarChartModel(
        year: "II",
        financial: countII,
        color: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      BarChartModel(
        year: "III",
        financial: countIII,
        color: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      BarChartModel(
        year: "IV",
        financial: countIV,
        color: charts.ColorUtil.fromDartColor(Colors.yellow),
      )
    ];

    return data;
  }
}
