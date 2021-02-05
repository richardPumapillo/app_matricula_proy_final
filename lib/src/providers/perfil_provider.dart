import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app_matricula_proy_final/src/models/perfil_model.dart';
import 'package:app_matricula_proy_final/src/preferencias_usuario/preferencias_usuario.dart';

class PerfilProvider {
  final String _url = 'https://app-matricula-default-rtdb.firebaseio.com';
  // final String _url = 'https://app-matricula-login-default-rtdb.firebaseio.com';

  final _prefs = new PreferenciasUsuario();

  Future<bool> crearPerfil(PerfilModel perfil) async {
    final url = '$_url/perfil.json?auth=${_prefs.token}';
    // perfil.idUsuario = _prefs.idUsuario;
    print('desde crear perfil provider');
    // print(perfil.id);
    final resp = await http.post(url, body: perfilModelToJson(perfil));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editarPerfil(PerfilModel perfil) async {
    print('desde editarperfil - perfil provider');
    print(perfil.id);
    final url = '$_url/perfil/${perfil.id}.json?auth=${_prefs.token}';
    // final url = '$_url/perfil/-MSea6ihNJUEtXYnU7XT.json?auth=${_prefs.token}';
    print('desde editar perfil en provider');
    // perfil.id = _prefs.idUsuario;
    final resp = await http.put(url, body: perfilModelToJson(perfil));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<PerfilModel>> cargarPerfiles() async {
    // final url = '$_url/perfil.json?auth=${_prefs.token}';
    final url = '$_url/perfil.json?auth=${_prefs.token}';
    final resp = await http.get(url);
    print('desde cargar perfiles');
    print(resp.body);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<PerfilModel> perfiles = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, perf) {
      final perfTemp = PerfilModel.fromJson(perf);
      perfTemp.id = id;
      perfiles.add(perfTemp);
    });

    return perfiles;
  }

  Future<PerfilModel> cargarPerfil() async {
    // final url = '$_url/perfil.json?auth=${_prefs.token}';
    //final url = '$_url/perfil.json?auth=${_prefs.token}';
    final url = '$_url/perfil/${_prefs.idUsuario}.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    PerfilModel perfile = new PerfilModel();

    if (decodedData == null) return null;

    perfile = PerfilModel.fromJson(decodedData);
    print('prueba de perfil');
    print(perfile);

    return perfile;
  }
}
