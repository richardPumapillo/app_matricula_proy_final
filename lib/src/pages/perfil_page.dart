import 'package:flutter/material.dart';

import 'package:app_matricula_proy_final/src/widget/app_drawer.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      drawer: AppDrawer(),
      body: Text('cuerpo de perfil'),
    );
  }
}
