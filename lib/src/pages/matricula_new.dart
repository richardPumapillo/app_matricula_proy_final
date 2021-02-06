import 'dart:io';

import 'package:app_matricula_proy_final/generated/l10n.dart';
import 'package:app_matricula_proy_final/src/models/matricula_model.dart';
import 'package:app_matricula_proy_final/src/providers/matricula_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_matricula_proy_final/src/widget/notifcation_dialog.dart';
import 'package:app_matricula_proy_final/src/models/maestria_model.dart';
import 'package:app_matricula_proy_final/src/providers/maestrias_provider.dart';
import 'package:app_matricula_proy_final/src/providers/productos_provider.dart';

class MatriculaNew extends StatefulWidget {
  @override
  _MatriculaPageState createState() => _MatriculaPageState();
}

class _MatriculaPageState extends State<MatriculaNew> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final matriculaProvider = new MatriculaProvider();
  final maestriaProvider = new MaestriasProvider();
  final cursoProvider = new ProductosProvider();

  MatriculaModel matricula = new MatriculaModel();
  bool _guardando = false;
  File foto;

  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _cargarMaestrias();
    //_cargarCiclos();
  }

  @override
  Widget build(BuildContext context) {
    final MatriculaModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      matricula = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(S.of(context).enrollment),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearPostulante(),
                _crearMaestria(),
                //_crearBotonAddCurso(),
                _crearPeriodoacademico(),
                _crearCiclo(),
                _crearFechainicio(),
                _crearFechafin(),
                _crearEstado(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
      //drawer: AppDrawer(),
    );
  }

  Widget _crearPostulante() {
    return TextFormField(
      initialValue: matricula.postulante,
      textCapitalization: TextCapitalization.sentences,
      //leading: Icon(Icons.app_registration),
      decoration: InputDecoration(labelText: 'Postulante'),
      onSaved: (value) => matricula.postulante = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del Postulante';
        } else {
          return null;
        }
      },
    );
  }

  List<MaestriaModel> _maestriaList = <MaestriaModel>[];
  String _maestria;
  void _cargarMaestrias() async {
    final List<MaestriaModel> _list = await maestriaProvider.cargarDocentes();
    setState(() {
      _maestriaList = _list;
    });
  }

  Widget _crearMaestria() {
    return DropdownButtonHideUnderline(
        child: DropdownButton<String>(
      isExpanded: true,
      hint: Text('Seleccionar Maestria'),
      value: _maestria,
      items: _maestriaList.map((value) {
        return DropdownMenuItem<String>(
          value: value.id,
          child: Text(value.maestria),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          _maestria = newValue;
        });
      },
    ));
  }

  Widget _crearPeriodoacademico() {
    return TextFormField(
      initialValue: matricula.periodoacademico,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Periodo Académico'),
      onSaved: (value) => matricula.periodoacademico = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese periodo académico';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearCiclo() {
    String _ratingController;
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: 'Seleccionar Ciclo'),
      value: _ratingController,
      items: ['I', 'II', 'III', 'IV']
          .map((label) => DropdownMenuItem(
                child: Text(label.toString()),
                value: label,
              ))
          .toList(),
      hint: Text(''),
      onChanged: (value) {
        setState(() {
          _ratingController = value;
        });
      },
    );
  }

  Widget _crearFechainicio() {
    /* return TextFormField(
      initialValue: matricula.fechainicio,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Fecha Inicio'),
      onSaved: (value) => matricula.fechainicio = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese la Fecha de inicio';
        } else {
          return null;
        }
      },
    ); */
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(dateFormat.format(selectedDate)),
        RaisedButton(
          child: Text('Seleccionar Fecha'),
          onPressed: () async {
            showDateTimeDialog(context, initialDate: selectedDate,
                onSelectedDate: (selectedDate) {
              setState(() {
                this.selectedDate = selectedDate;
              });
            });
          },
        ),
      ],
    );
  }

  Widget _crearFechafin() {
    return TextFormField(
      initialValue: matricula.fechafin,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Fecha Fin'),
      onSaved: (value) => matricula.fechafin = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese la Fecha fin';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearEstado() {
    return SwitchListTile(
      value: matricula.estado,
      title: Text('Estado'),
      activeColor: Colors.blue[700],
      onChanged: (value) => setState(() {
        matricula.estado = value;
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

  Widget _crearBotonAddCurso() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.green[700],
      textColor: Colors.white,
      label: Text('Añadir Cursos'),
      icon: Icon(Icons.menu_book),
      onPressed: _addCurso,
    );
  }

  void _addCurso() async {
    Navigator.pushReplacementNamed(context, 'Maestria_Cursos');
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (matricula.id == null) {
      matriculaProvider.crearMatricula(matricula);
    } else {
      matriculaProvider.editarMatricula(matricula);
    }

    Navigator.pushReplacementNamed(context, 'Maestria_Cursos');
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
