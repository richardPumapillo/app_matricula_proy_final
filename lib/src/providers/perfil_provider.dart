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
    final resp = await http.post(url, body: perfilModelToJson(perfil));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editarPerfil(PerfilModel perfil) async {
    final url = '$_url/perfil/${perfil.id}.json?auth=${_prefs.token}';

    final resp = await http.put(url, body: perfilModelToJson(perfil));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<PerfilModel>> cargarPerfil() async {
    final url = '$_url/perfil.json?auth=${_prefs.token}';
    final resp = await http.get(url);

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
}
