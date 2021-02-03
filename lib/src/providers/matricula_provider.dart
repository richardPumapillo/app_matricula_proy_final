import 'dart:convert';

import 'package:app_matricula_proy_final/src/models/matricula_model.dart';
import 'package:app_matricula_proy_final/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;


class MatriculaProvider {
  final String _url = 'https://app-matricula-default-rtdb.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearMatricula(MatriculaModel matricula) async {
    final url = '$_url/matricula.json?auth=${_prefs.token}';

    final resp = await http.post(url, body: matriculaModelToJson(matricula));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editarMatricula(MatriculaModel matricula) async {
    final url = '$_url/matricula/${matricula.id}.json?auth=${_prefs.token}';

    final resp = await http.put(url, body: matriculaModelToJson(matricula));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<MatriculaModel>> cargarMatricula() async {
    final url = '$_url/matricula.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<MatriculaModel> matricula = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = MatriculaModel.fromJson(prod);
      prodTemp.id = id;

      matricula.add(prodTemp);
    });

    // print( productos[0].id );

    return matricula;
  }

  Future<int> borrarMatricula(String id) async {
    final url = '$_url/matricula/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }
}
