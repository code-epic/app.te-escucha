/*!
* Code Epic Technologies v1.0.1 (https://dev.code-epic.com)
* Copyright 2020-2023 CodeEpicTechnologies <http://code-epic.com>
* Licensed under MIT (https://code-epic.github.io)
*/
// ignore: camel_case_types
class WKF_IDocumento {
  final String nombre;
  final int workflow;
  final String observacion;
  final int estado;
  final int estatus;
  final String usuario;
  WKF_IDocumento(
      {required this.nombre,
      required this.workflow,
      required this.observacion,
      required this.estado,
      required this.estatus,
      required this.usuario});
  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'workflow': workflow,
        'observacion': observacion,
        'estado': estado,
        'estatus': estatus,
        'usuario': usuario,
      };
}

// ignore: camel_case_types
class WKF_IDocumentoDetalle {
  final int wfdocumento;
  final int privacidad;
  final String ncontrol;
  final String fcreacion;
  final String forigen;
  final String norigen;
  final String salida;
  final String tipo;
  final String remitente;
  final String unidad;
  final String comando;
  final String contenido;
  final String instrucciones;
  final String codigo;
  final String nexpediente;
  final String archivo;
  final String creador;
  WKF_IDocumentoDetalle(
      {required this.wfdocumento,
      required this.privacidad,
      required this.ncontrol,
      required this.fcreacion,
      required this.forigen,
      required this.norigen,
      required this.salida,
      required this.tipo,
      required this.remitente,
      required this.unidad,
      required this.comando,
      required this.contenido,
      required this.instrucciones,
      required this.codigo,
      required this.nexpediente,
      required this.archivo,
      required this.creador});
  Map<String, dynamic> toJson() => {
        'wfdocumento': wfdocumento,
        'privacidad': privacidad,
        'ncontrol': ncontrol,
        'fcreacion': fcreacion,
        'forigen': forigen,
        'norigen': norigen,
        'salida': salida,
        'tipo': tipo,
        'remitente': remitente,
        'unidad': unidad,
        'comando': comando,
        'contenido': contenido,
        'instrucciones': instrucciones,
        'codigo': codigo,
        'nexpediente': nexpediente,
        'archivo': archivo,
        'creador': creador,
      };
}

int getEstadoWKF(String tipo) {
  int cadena = 1;

  switch (tipo) {
    case 'Pilotaje':
      cadena = 1;
      break;
    case "Lanchaje":
      cadena = 2;
      break;
    case 'Remolcadores':
      cadena = 3;
      break;
    case 'Capitanias':
      cadena = 4;
      break;
    case 'Cenave':
      cadena = 5;
      break;
    case 'Gente':
      cadena = 6;
      break;
    case 'Empresas':
      cadena = 7;
      break;
    case 'Renave':
      cadena = 8;
      break;
    case 'Industria':
      cadena = 9;
      break;
    case 'Seguridad':
      cadena = 10;
      break;
    case 'Puertos':
      cadena = 11;
      break;
    case 'Certificacion':
      cadena = 12;
      break;
    default:
      cadena = 1;
  }
  return cadena;
}
