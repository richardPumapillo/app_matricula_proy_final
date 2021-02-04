import 'dart:convert';

import 'package:app_matricula_proy_final/src/models/docente_model.dart';
import 'package:app_matricula_proy_final/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class DocentesProvider {
  final String _url = 'https://app-matricula-default-rtdb.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearDocente(DocenteModel docente) async {
    final url = '$_url/docentes.json?auth=${_prefs.token}';

    final resp = await http.post(url, body: docenteModelToJson(docente));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editarDocente(DocenteModel docente) async {
    final url = '$_url/docentes/${docente.id}.json?auth=${_prefs.token}';

    final resp = await http.put(url, body: docenteModelToJson(docente));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<DocenteModel>> cargarDocentes() async {
    final url = '$_url/docentes.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<DocenteModel> docentes = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, docente) {
      final docenteTemp = DocenteModel.fromJson(docente);
      docenteTemp.id = id;

      docentes.add(docenteTemp);
    });

    // print( productos[0].id );

    return docentes;
  }

  Future<int> borrarDocente(String id) async {
    final url = '$_url/docentes/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }
}
