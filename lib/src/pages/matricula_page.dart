import 'package:app_matricula_proy_final/src/models/matricula_model.dart';
import 'package:app_matricula_proy_final/src/providers/matricula_provider.dart';
import 'package:app_matricula_proy_final/src/widget/app_drawer.dart';
import 'package:flutter/material.dart';

class MatriculaPage extends StatelessWidget {
  final matriculaProvider = new MatriculaProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Historial Matrícula')),
      body: _crearListado(),
      drawer: AppDrawer(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: matriculaProvider.cargarMatricula(),
      builder:
          (BuildContext context, AsyncSnapshot<List<MatriculaModel>> snapshot) {
        if (snapshot.hasData) {
          final matricula = snapshot.data;

          return ListView.builder(
            itemCount: matricula.length,
            itemBuilder: (context, i) => _crearItem(context, matricula[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, MatriculaModel matricula) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.blue[700],
        ),
        onDismissed: (direccion) {
          matriculaProvider.borrarMatricula(matricula.id);
        },
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('${matricula.maestria} - '+'Periodo: '+'${matricula.periodoacademico}'),
                subtitle: Text('Ciclo: '+ matricula.ciclo),
                onTap: () => Navigator.pushNamed(context, 'NewMatricula',
                    arguments: matricula),
              ),
            ],
          ),
        ));
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.blue[700],
      onPressed: () => Navigator.pushNamed(context, 'NewMatricula'),
    );
  }
}
