import 'package:app_matricula_proy_final/generated/l10n.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(S.of(context).options),
            automaticallyImplyLeading: false,
          ),
          // Divider(),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(S.of(context).profile),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'perfil');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text(S.of(context).courses),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people),
            title: Text(S.of(context).teachers),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'docenteList');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text(S.of(context).enrollment),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'Matricula');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text(S.of(context).reports),
            onTap: () {
              //Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.school),
            title: Text(S.of(context).mastery),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'Maestrias');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(S.of(context).masteryCourses),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'Maestria_Cursos');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(S.of(context).logout),
            onTap: () {
              Navigator.of(context).pop();
              // Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          Divider()
        ],
      ),
    );
  }
}
