import 'dart:ui_web';
import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/ayuda.dart';
import 'package:te_escucha/src/gui/baselegal.dart';
import 'package:te_escucha/src/gui/chat_home.dart';
import 'package:te_escucha/src/gui/chat.dart';
import 'package:te_escucha/src/gui/emergencia/emergenciafinal.dart';
import 'package:te_escucha/src/gui/emergencia/emergenciapersonas.dart';
import 'package:te_escucha/src/gui/historico.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/gui/inicio.dart';
import 'package:te_escucha/src/gui/make_report.dart';
import 'package:te_escucha/src/gui/map_google.dart';
import 'package:te_escucha/src/gui/perfil.dart';
import 'package:te_escucha/src/gui/personal_report.dart';
import 'package:te_escucha/src/gui/politicas.dart';
import 'package:te_escucha/src/gui/splashscreen.dart';
import 'package:te_escucha/src/gui/comprobante.dart';

String title = 'Sistema de Denuncias';

String sPath = '/devel/api/crud:541f2bd069277d053a45cac13099e185.sse';

final List<String> reportList = [
  "Seleccione",
  'Quejas y reclamos',
  'Sugerencias',
  'Denuncias',
  'Emergencias de Embarcaciones',
];

final List<String> selectList = [
  "Seleccione",
  'Trámites',
  'Servicios',
];

final List<String> servicesIcon = [
  "Seleccione",
  'Lanchaje',
  'Remolcadores',
  'Capitanias',
  'Pilotaje',
  'Cenave',
];

class Capitania {
  late String nombre;
  late int codigo;
  late String ubicacion;
  late double latitud;
  late double longitud;
  late double metros;
  Capitania(
      {required this.nombre,
      required this.codigo,
      required this.ubicacion,
      required this.latitud,
      required this.longitud,
      required this.metros});
}

List<Capitania> capitania = [
  Capitania(
      nombre: 'Maracaibo',
      codigo: 1,
      ubicacion: '10.08143147, -71.24393463',
      latitud: 10.08143147,
      longitud: -71.24393463,
      metros: 1),
  Capitania(
      nombre: 'Las Piedras',
      codigo: 2,
      ubicacion: '11.62668043, -70.23525238',
      latitud: 11.62668043,
      longitud: -70.23525238,
      metros: 2),
  Capitania(
      nombre: 'La Guaira',
      codigo: 3,
      ubicacion: '10.60976219, -66.33598566',
      latitud: 10.60976219,
      longitud: -66.33598566,
      metros: 1),
  Capitania(
      nombre: 'Puerto la Cruz',
      codigo: 4,
      ubicacion: '10.08569897, -64.88718510',
      latitud: 10.08569897,
      longitud: -64.88718510,
      metros: 1),
  Capitania(
      nombre: 'Carupano',
      codigo: 5,
      ubicacion: '11.99829562, -62.80471265',
      latitud: 11.99829562,
      longitud: -62.80471265,
      metros: 1),
  Capitania(
      nombre: 'Pampatar',
      codigo: 6,
      ubicacion: '16.72847600, -64.10784200',
      latitud: 16.72847600,
      longitud: -64.10784200,
      metros: 1),
  Capitania(
      nombre: 'Puerto Cabello',
      codigo: 7,
      ubicacion: '11.35479391, -68.73470000',
      latitud: 11.35479391,
      longitud: -68.73470000,
      metros: 1),
  Capitania(
      nombre: 'Puerto Sucre',
      codigo: 8,
      ubicacion: '10.39058741, -64.50009406',
      latitud: 10.39058741,
      longitud: -64.50009406,
      metros: 1),
  Capitania(
      nombre: 'Ciudad Bolívar',
      codigo: 9,
      ubicacion: '7.64056063, -66.41784668',
      latitud: 7.64056063,
      longitud: -66.41784668,
      metros: 1),
  Capitania(
      nombre: 'Guiria',
      codigo: 10,
      ubicacion: '10.00874860, -61.97113037',
      latitud: 10.00874860,
      longitud: -61.97113037,
      metros: 1),
  Capitania(
      nombre: 'Ciudad Guayana',
      codigo: 11,
      ubicacion: '8.34059431, -62.71888733',
      latitud: 8.34059431,
      longitud: -62.71888733,
      metros: 1),
  Capitania(
      nombre: 'Carenero',
      codigo: 12,
      ubicacion: '10.57489706, -66.04740143',
      latitud: 10.57489706,
      longitud: -66.04740143,
      metros: 1),
  Capitania(
      nombre: 'La Vela de Coro',
      codigo: 13,
      ubicacion: '11.76040000, -68.95150000',
      latitud: 11.76040000,
      longitud: -68.95150000,
      metros: 1),
  Capitania(
      nombre: 'La Ceiba',
      codigo: 14,
      ubicacion: '9.20378212, -71.21543884',
      latitud: 9.20378212,
      longitud: -71.21543884,
      metros: 1),
];

final List<String> procedureIcon = [
  "Seleccione",
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
    case 'Capitanias de Puertos':
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
  '/': (context) => const SplashScreen(),
  '/inicio': (context) => const Inicio(),
  '/personal': (context) => const PersonalReport(
        accion: 0,
        tipo: '',
        caso: '',
        producto: '',
        descripcion: '',
      ),
  '/home': (context) => const Home(),
  '/perfil': (context) => const Perfil(),
  '/historico': (context) => const Historico(),
  '/maps': (context) => const MapGoogle(),
  '/chat': (context) => const ChatHome(),
  '/gui': (context) => const ChatUI(),
  '/comprobante': (context) => const MakeComprobante(
        codigo: '',
        tipo: '',
        accion: 0,
        producto: '',
        caso: '',
        persona: {},
      ),
  '/ayuda': (context) => const Ayuda(),
  '/baselegal': (context) => const BaseLegal(),
  '/makereport': (context) => const MakeReport(),
  '/politicas': (context) => const Politicas(),
  '/persona': (context) => EmergenciaPersona(
        oBusqueda: {},
        oEmbarcacion: {},
        oEmergencia: {},
        oPersona: {},
      ),
  '/emergenciafinal': (context) => EmergenciaFinal(
        oEmbarcacion: {},
        oEmergencia: {},
        oPersona: {},
      ),
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

const txtDraw = TextStyle(
    fontSize: 13,
    fontFamily: 'Lato',
    color: Colors.white,
    fontWeight: FontWeight.bold);

const textHome = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold);

const textHomeNumber = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold);

const textStatus = TextStyle(
    color: Colors.black,
    fontSize: 13,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal);

const textNumber = TextStyle(
    color: Colors.black,
    fontSize: 13,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold);

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

const xtextPersonal = TextStyle(
    // backgroundColor: Color(0xFFF0F7FC),
    color: Color(0xff11192c),
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