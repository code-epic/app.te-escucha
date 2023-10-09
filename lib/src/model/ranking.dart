/*!
* Code Epic Technologies v1.0.1 (https://dev.code-epic.com)
* Copyright 2020-2023 CodeEpicTechnologies <http://code-epic.com>
* Licensed under MIT (https://code-epic.github.io)
*/
// ignore: camel_case_types
class WKF_IDocumentoRanking {
  final int identificador;
  final int respuesta;
  final int clasificacion;
  final int score;
  WKF_IDocumentoRanking(
      {required this.identificador,
      required this.respuesta,
      required this.clasificacion,
      required this.score});
  Map<String, dynamic> toJson() => {
        'identificador': identificador,
        'respuesta': respuesta,
        'clasificacion': clasificacion,
        'score': score,
      };
}
