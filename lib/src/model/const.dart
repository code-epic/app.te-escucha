import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/ayuda.dart';
import 'package:te_escucha/src/gui/baselegal.dart';
import 'package:te_escucha/src/gui/chat.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/gui/inicio.dart';
import 'package:te_escucha/src/gui/make_report.dart';
import 'package:te_escucha/src/gui/politicas.dart';

String title = 'Sistema de Denuncias';

String sPath = '/devel/api/crud:89089080';

final List<String> reportList = [
  "---------------",
  'Quejas y reclamos',
  'Sugerencias',
  'Denuncias',
  'Emergencias de Embarcaciones Menores',
];

final List<String> selectList = [
  "---------------",
  'Trámites',
  'Servicios',
];

final List<String> servicesIcon = [
  "---------------",
  'Lanchaje',
  'Remolcadores',
  'Capitanias',
  'Pilotaje',
  'Cenave',
];

final List<String> procedureIcon = [
  "---------------",
  'Certificacion',
  'Empresas',
  'Gente',
  'Industria',
  'Puertos',
  'Renave',
  'Seguridad',
];

validarTipo(String tipo) {
  String cadena = "";

  switch (tipo) {
    case "Lanchaje":
      cadena = "Lanchaje";
      break;
    case 'Remolcadores':
      cadena = "Remolcadores";
      break;
    case 'Capitanias':
      cadena = "Capitanias de Puertos";
      break;
    case 'Pilotaje':
      cadena = "Pilotaje";
      break;
    case 'Cenave':
      cadena = "Cenave";
      break;
    case 'Certificacion':
      cadena = "Certificacion de Buques";
      break;
    case 'Empresas':
      cadena = "Empresas Prestadoras de Servicios";
      break;
    case 'Gente':
      cadena = "Gente de Mar";
      break;
    case 'Industria':
      cadena = "Industria Naval";
      break;
    case 'Puertos':
      cadena = "Puertos";
      break;
    case 'Renave':
      cadena = "Renave";
      break;
    case 'Seguridad':
      cadena = "Seguridad Integral";
      break;
    default:
      cadena = "";
  }
  return cadena;
}

definirTipo(String tipo) {
  String cadena = "";

  switch (tipo) {
    case "Lanchaje":
      cadena = "Lanchaje";
      break;
    case 'Remolcadores':
      cadena = "Remolcadores";
      break;
    case 'Capitania de Puertos':
      cadena = "Capitanias";
      break;
    case 'Pilotaje':
      cadena = "Pilotaje";
      break;
    case 'Cenave':
      cadena = "Cenave";
      break;
    case 'Certificacion de Buques':
      cadena = "Certificacion";
      break;
    case 'Empresas Prestadoras de Servicios':
      cadena = "Empresas";
      break;
    case 'Gente de Mar':
      cadena = "Gente";
      break;
    case 'Industria Naval':
      cadena = "Industria";
      break;
    case 'Puertos':
      cadena = "Puertos";
      break;
    case 'Renave':
      cadena = "Renave";
      break;
    case 'Seguridad Integral':
      cadena = "Seguridad";
      break;
    default:
      cadena = "";
  }
  return cadena;
}

final routers = {
  '/': (context) => const Inicio(),
  '/home': (context) => const Home(),
  '/chat': (context) => const ChatUI(),
  '/ayuda': (context) => const Ayuda(),
  '/baselegal': (context) => const BaseLegal(),
  '/makereport': (context) => const MakeReport(),
  '/politicas': (context) => const Politicas(),
};

const cmbGeneral = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold);

var boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    color: Color(0xffe7ecf0),
    border: Border.all(color: Color(0xff174076)));

const textHome = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold);

const textStatus = TextStyle(
    color: Colors.black,
    fontSize: 13,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal);

const textDescrip = TextStyle(
    color: Colors.black54,
    fontSize: 13,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal);

const textPersonal = TextStyle(
    // backgroundColor: Color(0xffe7ecf0),
    color: Colors.grey,
    fontSize: 13,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold);

const comboPersonal = TextStyle(
  color: Color(0xff63676a),
  fontWeight: FontWeight.normal,
  fontSize: 13,
  fontFamily: 'Roboto',
);

const textStyle = TextStyle(
    color: Color(0xff174076),
    fontSize: 14,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold);

const textJustify = TextStyle(
    color: Color.fromARGB(255, 66, 66, 66),
    fontSize: 14,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal);

const textStyleWho = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold);

const textJustifyWho = TextStyle(
    color: Colors.black,
    fontSize: 11,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal);

const tituloFuente = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold);

const subTituloFuente = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold);

const itemTituloFuente = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold);

const normalTituloFuente = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal);

final ButtonStyle btnStyle = ElevatedButton.styleFrom(
  backgroundColor: Color(0xff174076),
  shadowColor: Color(0xff174076), // background
  foregroundColor: Colors.white, // foreground
  minimumSize: Size(180, 40),
  maximumSize: Size(180, 40),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

// final  List<Color>[
//         Color(0xff070f1a),
//         Color(0xff11192c),
//         Color(0xff1c3054),
//         Color(0xff174076),
//         Color(0xff02509c),
//         Color(0xff83cacc),
// Color(0xffb7c4d5)
// Color(0xffe7ecf0)
//       ]