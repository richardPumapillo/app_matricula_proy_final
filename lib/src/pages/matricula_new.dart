import 'dart:io';

import 'package:app_matricula_proy_final/src/models/matricula_model.dart';
import 'package:app_matricula_proy_final/src/providers/matricula_provider.dart';
import 'package:flutter/material.dart';

class MatriculaNew extends StatefulWidget {
  @override
  _MatriculaPageState createState() => _MatriculaPageState();
}

class Ciclo {
  int id;
  String ciclo;
 
  Ciclo(this.id, this.ciclo);
 
  static List<Ciclo> getCiclos() {
    return <Ciclo>[
      Ciclo(0, 'Ciclo'),
      Ciclo(1, 'I'),
      Ciclo(2, 'II'),
      Ciclo(3, 'III'),
      Ciclo(4, 'IV'),
    ];
  }
}

class _MatriculaPageState extends State<MatriculaNew> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final matriculaProvider = new MatriculaProvider();

  MatriculaModel matricula = new MatriculaModel();
  bool _guardando = false;
  File foto;

  List<Ciclo> _ciclos = Ciclo.getCiclos();
    List<DropdownMenuItem<Ciclo>> _dropdownMenuItems;
    Ciclo _selectedCiclo;
  
    @override
    void initState() {
      _dropdownMenuItems = buildDropdownMenuItems(_ciclos);
      _selectedCiclo = _dropdownMenuItems[0].value;
      super.initState();
    }
  
    List<DropdownMenuItem<Ciclo>> buildDropdownMenuItems(List ciclos) {
      List<DropdownMenuItem<Ciclo>> items = List();
      for (Ciclo ciclo in ciclos) {
        items.add(
          DropdownMenuItem(
            value: ciclo,
            child: Text(ciclo.ciclo),
          ),
        );
      }
      return items;
    }
  
    onChangeDropdownItem(Ciclo selectedCiclo) {
      setState(() {
        _selectedCiclo = selectedCiclo;
      });
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
        title: Text('Registrar Matricula'),
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
  Widget _crearMaestria() {
    return TextFormField(
      initialValue: matricula.maestria,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Tipo de Maestria'),
      onSaved: (value) => matricula.maestria = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre de la maestria';
        } else {
          return null;
        }
      },
    );
  }
  Widget _crearPeriodoacademico() {
   return TextFormField(
      initialValue: matricula.periodoacademico,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Periodo Academico'),
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

        Text("Ciclo");

        return DropdownButton(
          
          value: _selectedCiclo,
          items: _dropdownMenuItems,
          onChanged: onChangeDropdownItem,
        );

  }
  Widget _crearFechainicio() {
    return TextFormField(
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
