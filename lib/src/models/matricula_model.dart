// To parse this JSON data, do
//

import 'dart:convert';
import 'producto_model.dart';

MatriculaModel matriculaModelFromJson(String str) => MatriculaModel.fromJson(json.decode(str));

String matriculaModelToJson(MatriculaModel data) => json.encode(data.toJson());
var fechaActual = DateTime.parse("2021-03-20 00:00:00"); //new DateTime.now();

 // List<ProductoModel> getCursosIni() {
 //   return <ProductoModel>[
 //     ProductoModel(1, 'Fabrica SW', 4.0, true, 'ruta'),  
 //   ];
 // }

class MatriculaModel {

    String id;
    String postulante;
    String maestria;
    String periodoacademico;
    String ciclo;
    String fechainicio;
    String fechafin;
    List<ProductoModel> cursos;
    bool estado;

    MatriculaModel({
        this.id,
        this.postulante = '',
        this.maestria  = '',
        this.periodoacademico = '',
        this.ciclo = '',
        this.fechainicio = '', //DateTime.parse("2021-03-20 00:00:00"),
        this.fechafin = '',
        //this.cursos = getCursosIni(),
        this.estado = true,
    });

    factory MatriculaModel.fromJson(Map<String, dynamic> json) => new MatriculaModel(
        id                : json["id"],
        postulante        : json["postulante"],
        maestria          : json["maestria"],
        periodoacademico  : json["periodoacademico"],
        ciclo             : json["ciclo"],
        fechainicio       : json["fechainicio"],
        fechafin          : json["fechafin"],   
        //cursos            : json["cursos"], 
        estado            : json["estado"],      
    );

    Map<String, dynamic> toJson() => {
        // "id"         : id,
        "postulante"        : postulante,
        "maestria"          : maestria,
        "periodoacademico"  : periodoacademico,
        "ciclo"             : ciclo,
        "fechainicio"       : fechainicio,
        "fechafin"          : fechafin,
        "estado"            : estado,                        
    };
}
