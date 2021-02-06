import 'package:app_matricula_proy_final/generated/l10n.dart';
import 'package:app_matricula_proy_final/src/models/perfil_model.dart';
import 'package:app_matricula_proy_final/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:app_matricula_proy_final/src/providers/perfil_provider.dart';
import 'package:app_matricula_proy_final/src/widget/app_drawer.dart';
import 'package:flutter/material.dart';

class PerfilListPage extends StatefulWidget {
  PerfilListPage({Key key}) : super(key: key);

  @override
  _PerfilListPageState createState() => _PerfilListPageState();
}

class _PerfilListPageState extends State<PerfilListPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final perfilProvider = new PerfilProvider();
  final _prefs = new PreferenciasUsuario();

  PerfilModel perfil = new PerfilModel();
  bool _guardando = false;

  static List<PerfilModel> _perfilList = <PerfilModel>[];

  @override
  void initState() {
    super.initState();
    _cargarPerfiles();
  }

  @override
  Widget build(BuildContext context) {
    print('perfil_page -_perfilList');
    // print(_perfilList);
    _perfilList.forEach((element) {
      if (element.idUsuario == _prefs.idUsuario) {
        print('esta es');
        print(element.nombre);
        // setState(() {
        //   perfil = element;
        // });
        setState(() {
          perfil = element;
          _prefs.nombreUsuario = element.nombre + ' ' + element.apellidoPaterno;
        });
        // perfil.nombre = element.nombre;
      } else {
        perfil.idUsuario = _prefs.idUsuario;
        _prefs.nombreUsuario = '';
      }
    });

    print('valor de perfil');
    print(perfil.nombre);
    print(perfil.apellidoPaterno);
    print(perfil.apellidoMaterno);
    print(perfil.idUsuario);
    print(perfil.id);
    print('fin valores');

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).profile)),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[_perfil(), _crearBoton()],
            ),
          ),
        ),
      ),
      // body: _crearBoton(),
    );
  }

  Widget _perfil() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 50.0,
          backgroundImage: AssetImage('assets/ing.jpg'),
        ),
        Text(
          _prefs
              .nombreUsuario, //perfil.nombre . aqui se debe obtener datos del usuario logueado
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 40.0,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          S.of(context).masteryStudent,
          style: TextStyle(
            fontFamily: 'SourceSansPro',
            color: Colors.teal.shade300,
            fontSize: 20.0,
            letterSpacing: 2.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
          width: 150.0,
          child: Divider(
            color: Colors.teal.shade100,
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
          color: Colors.white,
          child: ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.teal,
            ),
            title: Text('+51 999999999',
                style: TextStyle(
                  color: Colors.teal.shade900,
                  fontFamily: 'SourceSansPro',
                  fontSize: 20.0,
                )),
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
          color: Colors.white,
          child: ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.teal,
            ),
            title: Text(_prefs.correo,
                style: TextStyle(
                  color: Colors.teal.shade900,
                  fontFamily: 'SourceSansPro',
                  fontSize: 20.0,
                )),
          ),
        ),
      ],
    );
  }

  void _cargarPerfiles() async {
    final List<PerfilModel> _perfilArray =
        await perfilProvider.cargarPerfiles();
    setState(() {
      _perfilList = _perfilArray;
    });
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.blue[700],
      textColor: Colors.white,
      label: Text('ver Perfil'),
      icon: Icon(Icons.save),
      onPressed: () =>
          Navigator.pushNamed(context, 'perfil', arguments: perfil),
    );
  }
}
