import 'package:app_matricula_proy_final/src/models/perfil_model.dart';
import 'package:app_matricula_proy_final/src/providers/perfil_provider.dart';
import 'package:flutter/material.dart';

import 'package:app_matricula_proy_final/src/bloc/provider.dart';
import 'package:app_matricula_proy_final/src/widget/app_drawer.dart';

class PrincipalPage extends StatefulWidget {
  PrincipalPage({Key key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final perfilProvider = new PerfilProvider();

  PerfilModel perfil = new PerfilModel();
  bool _guardando = false;
/*
  @override
  void initState() {
    super.initState();
    _cargarUsuario();
    //_cargarCiclos();
  }
*/

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    final PerfilModel perfData = ModalRoute.of(context).settings.arguments;
    if (perfData != null) {
      perfil = perfData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Principal | Und. Postgrado UNMSM'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _perfil(),
                  _crearBoton()
                ],
              ),
            )),
      ),
    );
  }


/*
 List<PerfilModel> _perfilList = <PerfilModel>[];
  String _usuario;
  void _cargarUsuario() async {
    final List<PerfilModel> _list = await perfilProvider.cargarPerfil();
    setState(() {
      _perfilList = _list;
    });
  }
*/

  Widget _perfil() {
         return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/ing.jpg'),
              ),
              Text(
                'Waldo Trebejo', //perfil.nombre . aqui se debe obtener datos del usuario logueado
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 40.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Alumno de Maestria',
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
                  title: Text('alumno.upg@unmsm.edu.pe',
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


  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.green[700],
      textColor: Colors.white,
      label: Text('EDITAR PERFIL'),
      icon: Icon(Icons.edit),
      onPressed: _editarPerfil,
    );
  }

  void _editarPerfil() async {
      Navigator.pushReplacementNamed(context, 'perfil');
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
} 
