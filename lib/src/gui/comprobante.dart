import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/gui/personal_report.dart';
import 'package:te_escucha/src/model/const.dart';

import '../model/cehttpclient.dart';
import '../model/solicitud.dart';

class MakeComprobante extends StatefulWidget {
  final int accion;
  final String tipo;
  final String caso;
  final String producto;
  final Map<String, String> persona;

  const MakeComprobante(
      {super.key,
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
  String imagen = "tramites/Gente".toLowerCase();
  late WKF_IDocumento document;

  late WKF_IDocumentoDetalle detalle;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future _setDocumento(String valores) async {
    Map<String, dynamic> data = {
      'funcion': 'WKF_IDocumento',
      'parametros': '',
      'valores': valores
    };
    var response = await CeHttpClient.xPOST(sPath, data);
    var json = jsonDecode(response);
    print(json);

    String wkfDoc = json['msj'].toString();
    String cedula = widget.persona['cedula'].toString();
    String nombre = widget.persona['nombre'].toString();
    List<String> fecha = widget.persona['fecha'].toString().split('/');
    List<String> evento = widget.persona['evento'].toString().split('/');
    String descripcion = widget.persona['descripcion'].toString();

    detalle = WKF_IDocumentoDetalle(
      wfdocumento: int.parse(wkfDoc),
      privacidad: 1,
      ncontrol: wkfDoc,
      fcreacion: '${evento[2]}-${evento[1]}-${evento[0]}',
      forigen: '${fecha[2]}-${fecha[1]}-${fecha[0]}',
      norigen: nombre,
      salida: cedula,
      tipo: widget.tipo,
      remitente: 'correo@hotmail.com',
      unidad: widget.caso,
      comando: '',
      contenido: descripcion,
      instrucciones: 'instrucciones',
      codigo: 'codigo',
      nexpediente: 'nexpediente',
      archivo: 'archivo',
      creador: 'correo',
    );

    data = {
      'funcion': 'WKF_IDocumentoDetalle',
      'parametros': '',
      'valores': jsonEncode(detalle.toJson())
    };
    var xresponse = await CeHttpClient.xPOST(sPath, data);
    var xjson = jsonDecode(xresponse);

    print(xjson);

    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    imagen = widget.producto;
    print(widget.tipo);
    print(widget.producto);
    print(widget.caso);
    print(widget.accion);
    print(widget.persona);
  }

  void setDocWKF() {
    int estaDestino = getEstadoWKF(widget.persona['categoria'].toString());
    document = WKF_IDocumento(
        nombre: widget.tipo,
        workflow: 2,
        observacion: widget.producto,
        estado: estaDestino,
        estatus: 1,
        usuario: 'contol@hotmail.com');

    _setDocumento(jsonEncode(document.toJson()));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBodyBehindAppBar: true,
        key: scaffoldKey,
        // drawer: const NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: const BackButton(
            color: Color(0xff174076),
          ),
        ),
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
                    texto1("Tipo de reporte"),
                    texto2(widget.tipo),
                    texto1("Categoría"),
                    texto2(widget.caso),
                    // texto1("Subcategoria"),
                    // texto2("Gente de Mar"),
                    texto1("Nro. Reporte"),
                    texto2("0000000001"),
                    texto1("Reporte personal"),
                    const Divider(color: Color(0xff02509c)),
                    texto2("Cédula: "),
                    texto2("Nombre completo: "),
                    texto2("Edad: "),
                    texto2("Correo: "),
                    texto2("Teléfono: "),
                    texto1("Detalle del reporte"),
                    const Divider(color: Color(0xff02509c)),
                  ],
                ),
              )),
          buttomNext(context),
        ]));
  }

  Positioned titulo() {
    return Positioned(
      top: 20,
      left: 45,
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
                    backgroundColor: Color(0xff174076),
                    shadowColor: Color(0xff174076), // background
                    foregroundColor: Colors.white, // foreground
                    minimumSize: Size(180, 40),
                    maximumSize: Size(180, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () {
                    nextPage();
                  },
                  child: const Text(
                    'OK',
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

  void nextPage() {
    setDocWKF();
  }
}
