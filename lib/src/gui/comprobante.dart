import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/model/const.dart';

class MakeComprobante extends StatefulWidget {
  final int accion;
  final String codigo;
  final String tipo;
  final String caso;
  final String producto;
  final Map<String, String> persona;

  const MakeComprobante(
      {super.key,
      required this.codigo,
      required this.accion,
      required this.tipo,
      required this.caso,
      required this.producto,
      required this.persona});

  @override
  State<MakeComprobante> createState() => _MakeComprobanteState();
}

class _MakeComprobanteState extends State<MakeComprobante> {
  List<String> lst = [];
  String cedula = '';
  String nombre = '';
  String fecha = '';
  String descripcion = '';
  String imagen = "tramites/Gente".toLowerCase();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    imagen = widget.producto;
    cedula = widget.persona['cedula'].toString();
    nombre = widget.persona['nombre'].toString();
    fecha = widget.persona['fecha'].toString();
    descripcion = widget.persona['descripcion'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          key: scaffoldKey,
          body: Stack(children: [
            titulo(),
            Positioned(
                top: 40,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: imagenSeleccion(context, imagen),
                      ),
                      texto1("Nro. Reporte"),
                      texto2(widget.codigo.padLeft(5, '0')),
                      texto1("Tipo de reporte"),
                      texto2(widget.tipo),
                      Visibility(
                          visible: widget.caso == "Seleccione" ? false : true,
                          child: texto1("Categoría")),
                      Visibility(
                          visible: widget.caso == "Seleccione" ? false : true,
                          child: texto2(widget.caso)),
                      const Divider(color: Color(0xff02509c)),
                      texto1("Datos personales"),
                      texto2("Cédula: $cedula"),
                      texto2("Nombre completo: $nombre"),
                      const Divider(color: Color(0xff02509c)),
                      texto1("Detalle del reporte"),
                      texto2(descripcion),
                    ],
                  ),
                )),
            buttomNext(context),
          ])),
      onWillPop: () async {
        return false;
      },
    );
  }

  Positioned titulo() {
    return Positioned(
      top: 20,
      left: 15,
      child: Container(
        child: const Text(
          "Comprobante de reporte personal",
          style: textStyle,
        ),
      ),
    );
  }

  Container imagenSeleccion(BuildContext context, String img) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 144,
      height: 144,
      child: Image(
        image: AssetImage('assets/$img.png'),
      ),
    );
  }

  Positioned paginador() {
    return const Positioned(
        top: 54,
        right: 15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "4/4",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  Padding texto2(String texto) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: Text(texto, textAlign: TextAlign.justify, style: textJustify));
  }

  Padding texto1(String text) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Positioned buttomNext(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height - 60,
        width: MediaQuery.of(context).size.width,
        child: Container(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff174076),
                    shadowColor: const Color(0xff174076), // background
                    foregroundColor: Colors.white, // foreground
                    minimumSize: const Size(160, 40),
                    maximumSize: const Size(160, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () {
                    homePage();
                  },
                  child: const Text(
                    'Ir al inicio',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )));
  }

  void homePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }
}
