import 'dart:io';

import 'package:app_matricula_proy_final/src/models/docente_model.dart';
import 'package:app_matricula_proy_final/src/providers/docentes_provider.dart';
import 'package:flutter/material.dart';

class DocentePage extends StatefulWidget {
  @override
  _DocentePageState createState() => _DocentePageState();
}

class _DocentePageState extends State<DocentePage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final docentesProvider = new DocentesProvider();

  DocenteModel docente = new DocenteModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    final DocenteModel docenteData = ModalRoute.of(context).settings.arguments;
    if (docenteData != null) {
      docente = docenteData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Docente'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearNombre(),
                _crearDisponible(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
      //drawer: AppDrawer(),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: docente.nombres,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombres'),
      onSaved: (value) => docente.nombres = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del Docente';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: docente.disponible,
      title: Text('Disponible'),
      activeColor: Colors.blue[700],
      onChanged: (value) => setState(() {
        docente.disponible = value;
      }),
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.blue[700],
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (docente.id == null) {
      docentesProvider.crearDocente(docente);
    } else {
      docentesProvider.editarDocente(docente);
    }

    // setState(() {_guardando = false; });
    mostrarSnackbar('Registro guardado');

    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
