import 'package:app_matricula_proy_final/src/models/maestria_model.dart';
import 'package:app_matricula_proy_final/src/providers/maestrias_provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:app_matricula_proy_final/src/models/producto_model.dart';
import 'package:app_matricula_proy_final/src/providers/productos_provider.dart';
import 'package:app_matricula_proy_final/src/models/MaestriaCurso_model.dart';
import 'package:app_matricula_proy_final/src/providers/MaestriasCursos_provider.dart';
import 'package:app_matricula_proy_final/src/widget/app_drawer.dart';

    if (prodData != null) {
      maestriacurso = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Detalle Maestria a Curso'),
        actions: <Widget>[],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearselectmaestria(),
                _crearselectcurso(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
      //drawer: AppDrawer(),
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: maestriacurso.disponible,
      title: Text('Disponible'),
      activeColor: Colors.blue[700],
      onChanged: (value) => setState(() {
        maestriacurso.disponible = value;
      }),
    );
  }

  List<MaestriaModel> _citiesList = <MaestriaModel>[];
  String _city;

  void _cargarDocentes() async {
    final List<MaestriaModel> _list = await maestriaProvider.cargarDocentes();
    setState(() {
      _citiesList = _list;
    });
  }

  Widget _crearselectmaestria() {
    return DropdownButtonHideUnderline(
        child: DropdownButton<String>(
      isExpanded: true,
