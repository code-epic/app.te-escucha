/*!
* Code Epic Technologies v1.0.1 (https://dev.code-epic.com)
* Copyright 2020-2023 CodeEpicTechnologies <http://code-epic.com>
* Licensed under MIT (https://code-epic.github.io)
*/
// ignore: camel_case_types
class IChatBot {
  final String clase;
  final String idioma;
  final String observaciones;
  final String pregunta;
  final String tipo;
  final String respuesta;
  IChatBot(
      {required this.clase,
      required this.idioma,
      required this.observaciones,
      required this.pregunta,
      required this.tipo,
      required this.respuesta});
  Map<String, dynamic> toJson() => {
        'clase': clase,
        'idioma': idioma,
        'observaciones': observaciones,
        'pregunta': pregunta,
        'tipo': tipo,
        'respuesta': respuesta,
      };
}
