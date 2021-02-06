import 'package:app_matricula_proy_final/generated/l10n.dart';
import 'package:app_matricula_proy_final/src/models/docente_model.dart';
import 'package:app_matricula_proy_final/src/models/reporte_model.dart';
import 'package:app_matricula_proy_final/src/providers/reportes_provider.dart';
import 'package:app_matricula_proy_final/src/widget/app_drawer.dart';
import 'package:flutter/material.dart';

class ReportesListPage extends StatelessWidget {
  final reportesProvider = new ReportesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).reports)),
      body: _crearListado(),
      drawer: AppDrawer(),
      //floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: reportesProvider.cargarReportes(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ReporteModel>> snapshot) {
        if (snapshot.hasData) {
          final reportes = snapshot.data;

          return ListView.builder(
            itemCount: reportes.length,
            itemBuilder: (context, i) => _crearItem(context, reportes[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ReporteModel reporte) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.blue[700],
        ),
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('${reporte.nombre}'),
                subtitle: Text(reporte.descripcion),
                onTap: () => Navigator.pushNamed(context, reporte.reporte,
                    arguments: reporte),
              ),
            ],
          ),
        ));
  }
}
