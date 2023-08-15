import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/grupo_report.dart';
import 'package:te_escucha/src/gui/personal_report.dart';
import 'package:te_escucha/src/model/const.dart';

class MakeReportWho extends StatefulWidget {
  final String tipo;
  final String caso;
  final String producto;
  final String descripcion;
  const MakeReportWho(
      {super.key,
      required this.tipo,
      required this.caso,
      required this.producto,
      required this.descripcion});

  @override
  State<MakeReportWho> createState() => _MakeReportWhoState();
}

class _MakeReportWhoState extends State<MakeReportWho> {
  List<String> lst = [];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('descripcion ->' + widget.descripcion);
    print(widget.descripcion);
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
          barra_cargando(context),
          paginador(),
          Positioned(
              top: 60,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    texto1(),
                    texto2(
                        "Seleccione una de las siguientes opciones para continuar"),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      child: reporte_personal(
                          width,
                          "individual",
                          "Reporte personal",
                          "Utiliza esta opcion como denunciante para crear reportes a titulo personal"),
                      onTap: () {
                        nextPage(0, widget.tipo, widget.caso, widget.producto,
                            widget.descripcion);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      child: reporte_personal(
                          width,
                          "terceros",
                          "Reporte de tercero",
                          "Utiliza esta opcion como registrador para reportar un incidente a nombre de otra persona"),
                      onTap: () {
                        nextPage(1, widget.tipo, widget.caso, widget.producto,
                            widget.descripcion);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      child: reporte_personal(
                          width,
                          "comunal",
                          "Reporte colectivo",
                          "Como registrador crea reportes a nombre de un grupo de personas ten a mano las cedulas de por lo menos 5 personas afectadas"),
                      onTap: () {
                        grupoPage(1, widget.tipo, widget.caso, widget.producto,
                            widget.descripcion);
                      },
                    )
                  ],
                ),
              )),
          buttomNext(context),
        ]));
  }

  Container reporte_personal(
      double width, String img, String titulo, String descripcion) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Color(0xff02509c))),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage('assets/group/$img.png'),
                  width: 100,
                  height: 100,
                ),
                Container(
                  width: width - 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: textStyleWho,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(descripcion,
                          textAlign: TextAlign.justify, style: textJustifyWho),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Positioned titulo() {
    return Positioned(
      top: 20,
      left: 45,
      child: Container(
        child: const Text(
          "Crear reporte",
          style: textStyle,
        ),
      ),
    );
  }

  Positioned barra_cargando(BuildContext context) {
    return Positioned(
        top: 40,
        width: MediaQuery.of(context).size.width,
        child: const Image(
          image: AssetImage('assets/group/load_2.png'),
        ));
  }

  Positioned imagenSeleccion(BuildContext context, String img) {
    return Positioned(
        top: MediaQuery.of(context).size.height - 180,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: 128,
          height: 128,
          child: Image(
            image: AssetImage('assets/$img.png'),
          ),
        ));
  }

  Positioned paginador() {
    return Positioned(
        top: 54,
        right: 15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              "2/4",
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

  Padding texto1() {
    return const Padding(
      padding: EdgeInsets.all(5.0),
      child: Text(
        "¿Para quién está realizando este reporte?",
        textAlign: TextAlign.justify,
        style: TextStyle(
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
        top: MediaQuery.of(context).size.height - 80,
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
                    nextPage(0, widget.tipo, widget.caso, widget.producto,
                        widget.descripcion);
                  },
                  child: const Text(
                    'SIGUIENTE',
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

  void nextPage(int accion, String tipo, String caso, String producto,
      String descripcion) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PersonalReport(
                accion: accion,
                tipo: tipo,
                caso: caso,
                producto: producto,
                descripcion: descripcion,
              )),
    );
  }

  void grupoPage(int accion, String tipo, String caso, String producto,
      String descripcion) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GrupoReport(
              accion: accion,
              tipo: tipo,
              caso: caso,
              producto: producto,
              descripcion: descripcion)),
    );
  }
}
