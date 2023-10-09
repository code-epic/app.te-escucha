import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/model/const.dart';

class EmergenciaReport extends StatefulWidget {
  Map<String, String> oEmergencia;
  Map<String, String> oPersona;
  Map<String, String> oEmbarcacion;
  Map<String, String> oBusqueda;
  Map<String, String> oCantidad;

  EmergenciaReport(
      {super.key,
      required this.oEmergencia,
      required this.oPersona,
      required this.oEmbarcacion,
      required this.oBusqueda,
      required this.oCantidad});

  @override
  State<EmergenciaReport> createState() => _EmergenciaReportState();
}

class _EmergenciaReportState extends State<EmergenciaReport> {
  List<String> lst = [];
  String imagen = "group/Sar".toLowerCase();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    texto1("Tipo de reporte"),
                    texto2("Emergencias de Embarcaciones"),
                    texto1("Categoría"),
                    texto2("SAR"),
                    texto1("Reporte personal"),
                    const Divider(color: Color(0xff02509c)),
                    texto2("Cédula: ${widget.oPersona['cedula']}"),
                    texto2("Teléfono #1: ${widget.oPersona['telefono1']}"),
                    texto2("Teléfono #2: ${widget.oPersona['telefono2']}"),
                    texto1("Detalle del reporte"),
                    texto2("${widget.oBusqueda['actividad']}"),
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
    return Positioned(
        top: 54,
        right: 15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }
}
