import 'dart:io';

import 'package:app_matricula_proy_final/generated/l10n.dart';
import 'package:app_matricula_proy_final/src/models/maestria_model.dart';
import 'package:app_matricula_proy_final/src/providers/maestrias_provider.dart';
import 'package:flutter/material.dart';

class MaestriasNew extends StatefulWidget {
  @override
  _DocentePageState createState() => _DocentePageState();
}

class _DocentePageState extends State<MaestriasNew> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final maestriaProvider = new MaestriasProvider();

  MaestriaModel maestria = new MaestriaModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    final MaestriaModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      maestria = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(S.of(context).mastery),
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
                _crearSiglas(),
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
      initialValue: maestria.maestria,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Tipo de Maestria'),
      onSaved: (value) => maestria.maestria = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del Docente';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearSiglas() {
    return TextFormField(
      initialValue: maestria.siglas,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Siglas de Maestria'),
      onSaved: (value) => maestria.siglas = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese la siglas de la Maestria';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: maestria.disponible,
      title: Text('Disponible'),
      activeColor: Colors.blue[700],
      onChanged: (value) => setState(() {
        maestria.disponible = value;
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

    if (maestria.id == null) {
      maestriaProvider.crearDocente(maestria);
    } else {
      maestriaProvider.editarDocente(maestria);
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
