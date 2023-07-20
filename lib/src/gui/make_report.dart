import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:te_escucha/src/gui/emergenciamenor.dart';
import 'package:te_escucha/src/gui/make_report_who.dart';
import 'package:te_escucha/src/model/const.dart';

class MakeReport extends StatefulWidget {
  const MakeReport({super.key});

  @override
  State<MakeReport> createState() => _MakeReportState();
}

class _MakeReportState extends State<MakeReport> {
  String tipo = "---------------";
  String caso = selectList.first;
  String producto = "";
  String descripcion = "";
  String imagen = "tramites/Gente".toLowerCase();
  List<String> lst = [];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool contenido = false;
  bool xsolicitud = false;

  bool bImg = false;
  @override
  void initState() {
    super.initState();
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
                    texto1(
                        "Está realizando una solicitud para que podamos atender su caso."),
                    texto2(
                        "Continue paso a paso por el proceso de trámite, puedes volver atrás a revisar lo que has hecho antes de confirmarla"),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Container(
                          padding: EdgeInsets.only(left: 9, right: 3),
                          height: 40,
                          width: width,
                          // color: Color(0xff83cacc),
                          decoration: boxDecoration,
                          child: DropdownButton<String>(
                            value: tipo,
                            icon: const Icon(Icons.arrow_drop_down_sharp),
                            elevation: 16,
                            style: cmbGeneral,
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                tipo = value!;
                                xsolicitud = false;
                                contenido = false;
                                if (tipo !=
                                    'Emergencias de Embarcaciones Menores') {
                                  xsolicitud = true;
                                  bImg = false;
                                  caso = selectList.first;
                                } else {
                                  imagen = "group/sar";
                                  bImg = true;
                                }

                                mdlOk(context);
                              });
                            },
                            underline: Container(),
                            items: reportList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          e,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ))
                                .toList(),
                            isExpanded: true,
                          )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: xsolicitud,
                      child: texto2(
                          "Seleccione según sea el caso en donde esta presentando inconveniente o dificultad"),
                    ),
                    Visibility(
                      visible: xsolicitud,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                            padding: EdgeInsets.only(left: 9, right: 3),
                            height: 40,
                            width: width,
                            // color: Color(0xff83cacc),
                            decoration: boxDecoration,
                            child: DropdownButton<String>(
                              value: caso,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              elevation: 16,
                              style: cmbGeneral,
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  caso = value!;
                                  lst = [];
                                  producto = "---------------";
                                  if (value == "Trámites") {
                                    lst = procedureIcon;
                                  } else if (value == "Servicios") {
                                    lst = servicesIcon;
                                  }
                                  contenido = true;
                                });
                              },
                              underline: Container(),
                              items: selectList
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            e,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              isExpanded: true,
                            )),
                      ),
                    ),
                    Visibility(
                      visible: contenido,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                            padding: EdgeInsets.only(left: 9, right: 3),
                            height: 40,
                            width: width,
                            // color: Color(0xff83cacc),
                            decoration: boxDecoration,
                            child: DropdownButton<String>(
                              value: producto,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              elevation: 16,
                              style: cmbGeneral,
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  producto = value!;
                                  print(caso);
                                  if (caso == "Servicios") {
                                    imagen = "$caso/$value".toLowerCase();
                                  } else {
                                    imagen = "tramites/$value".toLowerCase();
                                  }
                                  descripcion = validarTipo(value);

                                  bImg = true;
                                });
                              },
                              underline: Container(),
                              items: lst
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            validarTipo(e),
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              isExpanded: true,
                            )),
                      ),
                    ),
                    if (bImg) Center(child: imagenSeleccion(context, imagen)),
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
          "Crear reporte",
          style: TextStyle(
              color: Color(0xff174076),
              fontSize: 14,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Positioned barra_cargando(BuildContext context) {
    return Positioned(
        top: 40,
        width: MediaQuery.of(context).size.width,
        child: const Image(
          image: AssetImage('assets/group/load_1.png'),
        ));
  }

  SizedBox imagenSeleccion(BuildContext context, String img) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: 172,
          height: 172,
          child: Image(
            image: AssetImage('assets/$img.png'),
          ),
        ));
  }

  Positioned paginador() {
    return const Positioned(
        top: 54,
        right: 15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "1/4",
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
      child: Text(
        texto,
        textAlign: TextAlign.justify,
        style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal),
      ),
    );
  }

  Padding texto1(String texto) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Text(
        texto,
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
                    nextPage(tipo, caso, imagen, descripcion);
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

  void nextPage(String tipo, String caso, String producto, String descripcion) {
    if (tipo == "---------------") {
    } else {
      if (tipo == 'Emergencias de Embarcaciones Menores') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EmergenciaMenor(),
            ));
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MakeReportWho(
                    tipo: tipo,
                    caso: caso,
                    producto: producto,
                    descripcion: descripcion,
                  )),
        );
      }
    }
  }

  Future<String?> mdlOk(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              texto1(
                  "INEA te escucha es una APP para atender tus quejas, reclamos, sugerencias y denuncias"),
              const SizedBox(
                height: 5,
              ),
              texto2(
                  "Usala con conciencia. El envio de un reporte engañoso puede generar consecuencias legales Esta APP está protegida por la Politica de privacidad y los Terminos de Servicios que aplican"),
              const SizedBox(height: 35),
              Ok(context),
            ],
          ),
        ),
      ),
    );
  }

  Container Ok(BuildContext context) {
    return Container(
        // width: MediaQuery.of(context).size.width - 60,
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
                    Navigator.pop(context);
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
}
