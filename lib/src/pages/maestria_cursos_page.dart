import 'package:app_matricula_proy_final/src/models/MaestriaCurso_model.dart';
import 'package:app_matricula_proy_final/src/providers/MaestriasCursos_provider.dart';
import 'package:app_matricula_proy_final/src/widget/app_drawer.dart';
import 'package:flutter/material.dart';

class MaestriasCursoPage extends StatelessWidget {
  final maestriacursoProvider = new MaestriasCursosProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('detalle Maestria y Curso')),
      body: _crearListado(),
      drawer: AppDrawer(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: maestriacursoProvider.cargarMaestriasCursos(),
      builder: (BuildContext context,
          AsyncSnapshot<List<MaestriaCursoModel>> snapshot) {
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

  Widget _crearItem(BuildContext context, MaestriaCursoModel docente) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.blue[700],
        ),
        onDismissed: (direccion) {
          maestriacursoProvider.borrarMaestriasCursos(docente.id);
        },
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('${docente.cursoid}'),
                subtitle: Text(docente.maestriaid),
                onTap: () => Navigator.pushNamed(context, 'Maestria_CursosNew',
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
      onPressed: () => Navigator.pushNamed(context, 'Maestria_CursosNew'),
    );
  }
}
