import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:te_escucha/src/gui/emergenciaestado.dart';
import 'package:te_escucha/src/gui/emergenciamenor.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/gui/make_report_who.dart';
import 'package:te_escucha/src/gui/personal_report.dart';
import 'package:te_escucha/src/model/const.dart';

import '../bloc/combo.dart';

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
  CmbKeyValue? cmbReporteEmergencia;

  List<CmbKeyValue> lstReporteEmergencia = <CmbKeyValue>[
    const CmbKeyValue('1', 'Ubicación Actual'),
    const CmbKeyValue('2', 'Desde otro lugar'),
  ];

  List<String> lst = [];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool contenido = false;
  bool xsolicitud = false;

  bool bImg = false;
  bool bSar = false;
  bool bSarX = false;

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
          leading: BackButton(
            color: Color(0xff174076),
            onPressed: () => {homePage()},
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
                        "Usted debe realizar un reporte para que nuestro equipo pueda atender su caso."),
                    texto2(
                        "A continuación, seleccione el tipo de reporte que va a realizar desplegando la lista que se encuentra debajo. Antes de finalizar puede volver atrás para verificar que su solicitud esté correcta"),
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
                                bSar = false;
                                contenido = false;
                                if (tipo != 'Emergencias de Embarcaciones') {
                                  xsolicitud = true;
                                  bImg = false;
                                  caso = selectList.first;
                                } else {
                                  imagen = "group/sar";
                                  bImg = true;
                                  bSar = true;
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
                                  //print(caso);
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
                    Visibility(
                      visible: bSar,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: ReporteEmergencia(width),
                      ),
                    ),
                    if (bImg)
                      Center(
                        child: FadeInUp(
                          child: imagenSeleccion(context, imagen),
                        ),
                      ),
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
    String imagenx = 'assets/$img.png';
    double intW = 172;
    double intH = 172;

    if (img == 'group/sar') {
      imagenx = 'assets/$img.gif';
      intW = 220;
      intH = 220;
    }
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: intW,
          height: intH,
          child: Image(
            image: AssetImage(imagenx),
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
      if (tipo == 'Emergencias de Embarcaciones') {
        if (cmbReporteEmergencia!.id == "2") {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EmergenciaEstado(),
              ));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EmergenciaMenor(),
              ));
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PersonalReport(
                    accion: 0,
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              texto1(
                  "\“INEA Te Escucha\” es una herramienta para atender tus quejas y reclamos, sugerencias, denuncias y emergencias de embarcaciones. "),
              const SizedBox(
                height: 5,
              ),
              texto2(
                  "Úsala con conciencia. El envío de un reporte engañoso puede generar consecuencias legales."),
              const SizedBox(height: 5),
              texto2(
                  "Esta herramienta está protegida por la política de privacidad y los términos de servicios que aplican."),
              texto2(
                  "Seleccione el tipo de caso, según sea el inconveniente que esté presentando."),
              const SizedBox(height: 25),
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
                    minimumSize: Size(120, 40),
                    maximumSize: Size(120, 40),
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

  Container ReporteEmergencia(double width) {
    return Container(
        padding: const EdgeInsets.only(left: 9, right: 3),
        height: 40,
        width: width,
        decoration: decoracionCombo(),
        child: DropdownButton<CmbKeyValue>(
          value: cmbReporteEmergencia,
          hint: const Text("Lugar dónde se originó la emergencia"),
          icon: const Icon(Icons.arrow_drop_down_sharp),
          elevation: 16,
          onChanged: (CmbKeyValue? value) {
            setState(() {
              cmbReporteEmergencia = value;
              //print(cmbReporteEmergencia!.id);
            });
          },
          underline: Container(),
          items: lstReporteEmergencia
              .map((CmbKeyValue? cmb) => DropdownMenuItem<CmbKeyValue>(
                    value: cmb,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: textoCombos(cmb),
                    ),
                  ))
              .toList(),
          isExpanded: true,
        ));
  }

  BoxDecoration decoracionCombo() {
    return BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: const Color(0xffe7ecf0),
        border: Border.all(color: const Color(0xff174076)));
  }

  Text textoCombos(CmbKeyValue? cmb) {
    return Text(
      cmb!.name,
      style: const TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold),
    );
  }

  void homePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }
}
