import 'package:app_matricula_proy_final/src/models/maestria_model.dart';
import 'package:app_matricula_proy_final/src/providers/maestrias_provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:app_matricula_proy_final/src/models/producto_model.dart';
import 'package:app_matricula_proy_final/src/providers/productos_provider.dart';
import 'package:app_matricula_proy_final/src/models/MaestriaCurso_model.dart';
import 'package:app_matricula_proy_final/src/providers/MaestriasCursos_provider.dart';
import 'package:app_matricula_proy_final/src/widget/app_drawer.dart';

class MaestriaCursoPageNew extends StatefulWidget {
  @override
  _DocentePageState createState() => _DocentePageState();
}

class _DocentePageState extends State<MaestriaCursoPageNew> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final maestriaProvider = new MaestriasProvider();
  final cursoProvider = new ProductosProvider();
  final maestriacursoProvider = new MaestriasCursosProvider();
  MaestriaCursoModel maestriacurso = new MaestriaCursoModel();
  MaestriaModel maestria = new MaestriaModel();
  ProductoModel curso = new ProductoModel();

  bool _guardando = false;
  File foto;

  @override
  void initState() {
    super.initState();
    _cargarDocentes();
    _cargarProductos();
    maestriacurso.maestriaid = null;
    maestriacurso.cursoid = null;
  }

  @override
  Widget build(BuildContext context) {
    final MaestriaCursoModel prodData =
        ModalRoute.of(context).settings.arguments;
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
      hint: Text('Select Maestria'),
      value: maestriacurso.maestriaid,
      items: _citiesList.map((value) {
        return DropdownMenuItem<String>(
          value: value.maestria,
          child: Text(value.maestria),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          maestriacurso.maestriaid = newValue;
        });
      },
    ));
  }

  List<ProductoModel> _cursoList = <ProductoModel>[];
  void _cargarProductos() async {
    final List<ProductoModel> _cursoarray =
        await cursoProvider.cargarProductos();
    setState(() {
      _cursoList = _cursoarray;
    });
  }

  Widget _crearselectcurso() {
    return DropdownButtonHideUnderline(
        child: DropdownButton<String>(
      isExpanded: true,
      hint: Text('Select Curso'),
      value: maestriacurso.cursoid,
      items: _cursoList.map((value) {
        return DropdownMenuItem<String>(
          value: value.titulo,
          child: Text(value.titulo),
        );
      }).toList(),
      onChanged: (String values) {
        setState(() {
          maestriacurso.cursoid = values;
        });
      },
    ));
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

    if (maestriacurso.id == null) {
      maestriacursoProvider.crearMaestriasCursos(maestriacurso);
    } else {
      maestriacursoProvider.editarMaestriasCursos(maestriacurso);
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
