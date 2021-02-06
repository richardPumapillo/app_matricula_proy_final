import 'package:app_matricula_proy_final/src/models/perfil_model.dart';
import 'package:app_matricula_proy_final/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:app_matricula_proy_final/src/providers/perfil_provider.dart';
import 'package:flutter/material.dart';

import 'package:app_matricula_proy_final/src/bloc/provider.dart';
import 'package:app_matricula_proy_final/src/widget/app_drawer.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final perfilProvider = new PerfilProvider();
  final _prefs = new PreferenciasUsuario();

  PerfilModel perfil = new PerfilModel();
  bool _guardando = false;

  static List<PerfilModel> _perfilList = <PerfilModel>[];
  @override
  Widget build(BuildContext context) {
    final PerfilModel perfData = ModalRoute.of(context).settings.arguments;
    if (perfData != null) {
      perfil = perfData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Editando Perfil'),
      ),
      drawer: AppDrawer(),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     Text('Email: ${bloc.email}'),
      //     Divider(),
      //     Text('Password: ${bloc.password}')
      //   ],
      // )
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _crearNombre(),
                  _crearApellidoPaterno(),
                  _crearApellidoMaterno(),
                  _crearBoton(),
                  _regresarBoton()
                ],
              ),
            )),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: perfil.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre'),
      onSaved: (value) => perfil.nombre = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese su nombre';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearApellidoPaterno() {
    return TextFormField(
      initialValue: perfil.apellidoPaterno,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Apellido Paterno'),
      onSaved: (value) => perfil.apellidoPaterno = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese su Apellido Paterno';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearApellidoMaterno() {
    return TextFormField(
      initialValue: perfil.apellidoMaterno,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Apellido Materno'),
      onSaved: (value) => perfil.apellidoMaterno = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese su Apellido Materno';
        } else {
          return null;
        }
      },
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

  Widget _regresarBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.green[700],
      textColor: Colors.white,
      label: Text('Regresar'),
      icon: Icon(Icons.reply),
      // onPressed: _regresarPerfil,
      onPressed: () => Navigator.pushReplacementNamed(context, 'Principal'),
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    // perfil.id=
    print('desde perfil page');
    // PerfilModel perfilaux = await perfilProvider.cargarPerfil();

    print(perfil.id);

    if (perfil.id == '' || perfil.id == null) {
      perfilProvider.crearPerfil(perfil);
    } else {
      perfilProvider.editarPerfil(perfil);
    }

    // if (perfil.id == null) {
    //   perfilProvider.crearPerfil(perfil);
    // } else {
    //   perfilProvider.editarPerfil(perfil);
    // }

    // setState(() {_guardando = false; });
    mostrarSnackbar('Registro guardado');

    // Navigator.pop(context);
  }

  // void _cargarPerfiles() async {
  //   final List<PerfilModel> _perfilArray =
  //       await perfilProvider.cargarPerfiles();
  //   setState(() {
  //     _perfilList = _perfilArray;
  //   });
  // }

  // void _cargarPerfile() async {
  //   final PerfilModel _perfil = await perfilProvider.cargarPerfil();
  //   setState(() {
  //     perfil.idUsuario = _perfil.idUsuario;
  //     perfil.nombre = _perfil.nombre;
  //     perfil.apellidoPaterno = _perfil.apellidoPaterno;
  //   });
  // }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
