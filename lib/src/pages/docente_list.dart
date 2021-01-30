import 'package:app_matricula_proy_final/src/models/docente_model.dart';
import 'package:app_matricula_proy_final/src/providers/docentes_provider.dart';
import 'package:app_matricula_proy_final/src/widget/app_drawer.dart';
import 'package:flutter/material.dart';


class DocenteListPage extends StatelessWidget {
  final docentesProvider = new DocentesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Docentes')),
      body: _crearListado(),
      drawer: AppDrawer(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: docentesProvider.cargarDocentes(),
      builder:
          (BuildContext context, AsyncSnapshot<List<DocenteModel>> snapshot) {
        if (snapshot.hasData) {
          final docentes = snapshot.data;

          return ListView.builder(
            itemCount: docentes.length,
            itemBuilder: (context, i) => _crearItem(context, docentes[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, DocenteModel docente) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.blue[700],
        ),
        onDismissed: (direccion) {
          docentesProvider.borrarDocente(docente.id);
        },
        child: Card(
          child: Column(
            children: <Widget>[              
              ListTile(
                title: Text('${docente.nombres}  ${docente.apellidos}'),
                subtitle: Text(docente.correo),
                onTap: () => Navigator.pushNamed(context, 'docente',
                    arguments: docente),
              ),
            ],
          ),
        ));
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.blue[700],
      onPressed: () => Navigator.pushNamed(context, 'docente'),
    );
  }
}
