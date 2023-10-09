class Buzon {
  String codigo;
  String nombre;
  String fecha;
  int estado;
  int estatus;
  String txtEstatus;
  String contenido;
  String respuesta;
  String autor;
  String tipo;
  String categoria;
  String icono;
  String imagen;
  // List<Respuesta> respuesta;

  Buzon(
      {required this.codigo,
      required this.nombre,
      required this.fecha,
      required this.estado,
      required this.estatus,
      required this.txtEstatus,
      required this.contenido,
      required this.respuesta,
      required this.autor,
      required this.tipo,
      required this.categoria,
      required this.imagen,
      required this.icono});

  Buzon.fromJson(Map<String, dynamic> json)
      : codigo = json['wfd'].padLeft(5, '0'),
        nombre = json['nori'],
        fecha = json['fech'],
        estatus = int.parse(json['estatus']),
        estado = int.parse(json['idestado']),
        txtEstatus = txtStatus(int.parse(json['estatus'])),
        contenido = json['cont'],
        respuesta = json['inst'],
        categoria = json['tdoc'],
        autor = json['estado'],
        tipo = json['estado'] != 'Atencion'
            ? json['desestado']
            : "Atención al ciudadano",
        imagen = udep(json['desestado'], json['estado']),
        icono = icons(int.parse(json['estatus']));
}

enum BuzonType { nuevo, leido, no_leido }

enum BuzonStatus { enviado, en_proceso, finalizado }

class Respuesta {
  String codigo;
  String pregunta;
  String respuesta;

  Respuesta(this.codigo, this.pregunta, this.respuesta);
}

List<Respuesta> respuesta = [];

List<Buzon> rsBuzones = [];

String icons(int estatus) {
  String cadena = "";
  switch (estatus) {
    case 1:
      cadena = "enviadomensaje_leido";
      break;
    case 2:
      cadena = "enprocesomensaje_leido";
      break;
    case 3:
      cadena = "conformemensaje_leido";
      break;
    default:
      cadena = "finalizadoconexitomensaje_leido";
  }

  return cadena;
}

String txtStatus(int estatus) {
  String str = "";
  switch (estatus) {
    case 1:
      str = "Enviado";
      break;
    case 2:
      str = "En Proceso";
      break;
    case 3:
      str = "Cerrado";
      break;
    default:
      str = "Finalizado";
  }
  return str;
}

String udep(String name, String img) {
  final tipo = name.split('/');

  String cadena = "";
  switch (tipo[0].toString().toLowerCase().trim()) {
    case "servicios":
      cadena = "servicios";
      break;
    case "tramites":
      cadena = "tramites";
      break;
    default:
      cadena = "group";
  }
  if (img == 'Atencion') {
    img = 'marina_circulo';
    cadena = 'group';
  }
  return '$cadena/${img.toString().toLowerCase()}';
}
