import 'package:flutter/material.dart';

import 'package:app_matricula_proy_final/src/pages/docente_list.dart';
import 'package:app_matricula_proy_final/src/pages/docente_page.dart';
import 'package:app_matricula_proy_final/src/pages/perfil_page.dart';

import 'package:app_matricula_proy_final/src/bloc/provider.dart';

import 'package:app_matricula_proy_final/src/pages/home_page.dart';
import 'package:app_matricula_proy_final/src/pages/maestrias_page.dart';
import 'package:app_matricula_proy_final/src/pages/maestrias_new.dart';
import 'package:app_matricula_proy_final/src/pages/login_page.dart';
import 'package:app_matricula_proy_final/src/pages/producto_page.dart';
import 'package:app_matricula_proy_final/src/pages/registro_page.dart';
import 'package:app_matricula_proy_final/src/pages/matricula_page.dart';
import 'package:app_matricula_proy_final/src/pages/matricula_new.dart';
import 'package:app_matricula_proy_final/src/preferencias_usuario/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    print(prefs.token);

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App UNMSM',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'registro': (BuildContext context) => RegistroPage(),
          'home': (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => ProductoPage(),
          'docenteList': (BuildContext context) => DocenteListPage(),
          'docente': (BuildContext context) => DocentePage(),
          'perfil': (BuildContext context) => PerfilPage(),
          'Maestrias': (BuildContext context) => MaestriasPage(),
          'NewMaestrias': (BuildContext context) => MaestriasNew(),
          'Matricula': (BuildContext context) => MatriculaPage(),
          'NewMatricula': (BuildContext context) => MatriculaNew()          
        },
        theme: ThemeData(
          primaryColor: Colors.blue[700],
        ),
      ),
    );
  }
}
