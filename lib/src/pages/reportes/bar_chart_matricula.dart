import 'package:app_matricula_proy_final/src/models/reporte_model.dart';
import 'package:app_matricula_proy_final/src/providers/reportes_provider.dart';
import 'package:flutter/material.dart';

import 'models/bar_chart_model.dart';
import 'widget/bar_chart_graph.dart';

class BarChartMatriculas extends StatefulWidget {
  @override
  _BarChartDemoState createState() => _BarChartDemoState();
}

class _BarChartDemoState extends State<BarChartMatriculas> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ReporteModel reporteModel = new ReporteModel();
  final reportesProvider = new ReportesProvider();

  List<BarChartModel> data = [];

  _BarChartDemoState() {
    reportesProvider.cargarReporteAlumnos().then((val) => setState(() {
          data = val;
    }));
  }

  @override
  Widget build(BuildContext context) {
  
    final ReporteModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      reporteModel = prodData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(reporteModel.nombre),
      ),
      body: Center(
        child: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              BarChartGraph(
                data: data,
              ),

            ],
          ),

        ),
      ),
    );
  }

}