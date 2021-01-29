import 'package:flutter/material.dart';

import 'package:app_matricula_proy_final/src/bloc/provider.dart';

import 'package:app_matricula_proy_final/src/pages/home_page.dart';
import 'package:app_matricula_proy_final/src/pages/login_page.dart';
import 'package:app_matricula_proy_final/src/pages/producto_page.dart';
import 'package:app_matricula_proy_final/src/pages/registro_page.dart';
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
        },
        theme: ThemeData(
          primaryColor: Colors.blue[700],
        ),
      ),
    );
  }
}
