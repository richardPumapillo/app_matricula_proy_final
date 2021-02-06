import 'package:app_matricula_proy_final/generated/l10n.dart';
import 'package:app_matricula_proy_final/src/models/maestria_model.dart';
import 'package:app_matricula_proy_final/src/providers/maestrias_provider.dart';
import 'package:app_matricula_proy_final/src/widget/app_drawer.dart';
import 'package:flutter/material.dart';

class MaestriasPage extends StatelessWidget {
  final docentesProvider = new MaestriasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).mastery)),
      body: _crearListado(),
      drawer: AppDrawer(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: docentesProvider.cargarDocentes(),
      builder:
          (BuildContext context, AsyncSnapshot<List<MaestriaModel>> snapshot) {
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

  Widget _crearItem(BuildContext context, MaestriaModel docente) {
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
                title: Text('${docente.maestria}'),
                subtitle: Text(docente.siglas),
                onTap: () => Navigator.pushNamed(context, 'NewMaestrias',
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
      onPressed: () => Navigator.pushNamed(context, 'NewMaestrias'),
    );
  }
}
