import 'dart:convert';

import 'package:app_matricula_proy_final/src/models/maestria_model.dart';
import 'package:app_matricula_proy_final/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

import 'package:app_matricula_proy_final/src/models/producto_model.dart';

class MaestriasProvider {
  final String _url = 'https://app-matricula-default-rtdb.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearDocente(MaestriaModel maestria) async {
    final url = '$_url/maestrias.json?auth=${_prefs.token}';

    final resp = await http.post(url, body: docenteModelToJson(maestria));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editarDocente(MaestriaModel maestria) async {
    final url = '$_url/maestrias/${maestria.id}.json?auth=${_prefs.token}';

    final resp = await http.put(url, body: docenteModelToJson(maestria));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<MaestriaModel>> cargarDocentes() async {
    final url = '$_url/maestrias.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<MaestriaModel> productos = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = MaestriaModel.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);
    });

    // print( productos[0].id );

    return productos;
  }

  Future<int> borrarDocente(String id) async {
    final url = '$_url/maestrias/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }
}
