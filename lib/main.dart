import 'package:flutter/material.dart';

import 'package:app_matricula_proy_final/src/pages/docente_list.dart';
import 'package:app_matricula_proy_final/src/pages/docente_page.dart';
import 'package:app_matricula_proy_final/src/pages/perfil_page.dart';

import 'package:app_matricula_proy_final/src/bloc/provider.dart';

import 'package:app_matricula_proy_final/src/pages/home_page.dart';
import 'package:app_matricula_proy_final/src/pages/maestrias_page.dart';
import 'package:app_matricula_proy_final/src/pages/maestrias_new.dart';
import 'package:app_matricula_proy_final/src/pages/maestria_cursos.dart';
import 'package:app_matricula_proy_final/src/pages/maestria_cursos_page.dart';
import 'package:app_matricula_proy_final/src/pages/login_page.dart';
import 'package:app_matricula_proy_final/src/pages/producto_page.dart';
import 'package:app_matricula_proy_final/src/pages/registro_page.dart';
import 'package:app_matricula_proy_final/src/pages/matricula_page.dart';
import 'package:app_matricula_proy_final/src/pages/matricula_new.dart';
import 'package:app_matricula_proy_final/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

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
          'Maestria_Cursos': (BuildContext context) => MaestriasCursoPage(),
          'Maestria_CursosNew': (BuildContext context) =>
              MaestriaCursoPageNew(),
          'Matricula': (BuildContext context) => MatriculaPage(),
          'NewMatricula': (BuildContext context) => MatriculaNew()
        },
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('de', ''),
          const Locale('en', ''),
          const Locale('es', 'ES'),
          const Locale('it', ''),
        ],
        theme: ThemeData(
          primaryColor: Colors.blue[700],
        ),
      ),
    );
  }
}
