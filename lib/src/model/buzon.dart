enum BuzonType { nuevo, leido, no_leido }

enum BuzonStatus { enviado, en_proceso, finalizado }

class Respuesta {
  String codigo;
  String pregunta;
  String respuesta;

  Respuesta(this.codigo, this.pregunta, this.respuesta);
}

class Buzon {
  String codigo;
  String nombre;
  String fecha;
  int estatus;
  String contenido;
  String autor;
  String tipo;
  String icono;
  List<Respuesta> respuesta;

  Buzon(
      {required this.codigo,
      required this.nombre,
      required this.fecha,
      required this.estatus,
      required this.contenido,
      required this.autor,
      required this.tipo,
      required this.icono,
      required this.respuesta});
}

List<Respuesta> respuesta = [];

List<Buzon> rsBuzones = [];
