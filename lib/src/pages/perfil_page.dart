import 'package:flutter/material.dart';

import 'package:app_matricula_proy_final/src/bloc/provider.dart';
import 'package:app_matricula_proy_final/src/widget/app_drawer.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Perfil'),
        ),
        drawer: AppDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Email: ${bloc.email}'),
            Divider(),
            Text('Password: ${bloc.password}')
          ],
        ));
  }
}
