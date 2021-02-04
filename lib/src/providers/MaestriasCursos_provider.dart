import 'dart:convert';

import 'package:app_matricula_proy_final/src/models/MaestriaCurso_model.dart';
import 'package:app_matricula_proy_final/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class MaestriasCursosProvider {
  final String _url = 'https://app-matricula-default-rtdb.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearMaestriasCursos(MaestriaCursoModel maestriacurso) async {
    final url = '$_url/maestriacurso.json?auth=${_prefs.token}';

    final resp = await http.post(url, body: docenteModelToJson(maestriacurso));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editarMaestriasCursos(MaestriaCursoModel maestriacurso) async {
    final url =
        '$_url/maestriacurso/${maestriacurso.id}.json?auth=${_prefs.token}';

    final resp = await http.put(url, body: docenteModelToJson(maestriacurso));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<MaestriaCursoModel>> cargarMaestriasCursos() async {
    final url = '$_url/maestriacurso.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<MaestriaCursoModel> productos = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = MaestriaCursoModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);
    });

    // print( productos[0].id );

    return productos;
  }

  Future<int> borrarMaestriasCursos(String id) async {
    final url = '$_url/maestriacurso/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }
}
