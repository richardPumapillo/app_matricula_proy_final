import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Opciones"),
            automaticallyImplyLeading: false,
          ),
          // Divider(),
          ListTile(
            leading: Icon(Icons.account_circle,),
            title: Text("Perfil", style: TextStyle(fontSize: 16),),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'Principal');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text("Cursos", style: TextStyle(fontSize: 16),),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Docentes", style: TextStyle(fontSize: 16),),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'docenteList');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text("Matrícula", style: TextStyle(fontSize: 16),),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'Matricula');
            },
          ),          
          Divider(),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text("Reportes", style: TextStyle(fontSize: 16),),
            onTap: () {
              //Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.school),
            title: Text("Maestrias", style: TextStyle(fontSize: 16),),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'Maestrias');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Maestria_Cursos", style: TextStyle(fontSize: 16),),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'Maestria_Cursos');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout", style: TextStyle(fontSize: 16),),
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
