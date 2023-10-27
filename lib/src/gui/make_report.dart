import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:te_escucha/src/gui/emergencia/emergenciaestado.dart';
import 'package:te_escucha/src/gui/emergencia/emergenciamenor.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/gui/personal_report.dart';
import 'package:te_escucha/src/model/const.dart';

import 'package:te_escucha/src/bloc/combo.dart';

class MakeReport extends StatefulWidget {
  const MakeReport({super.key});

  @override
  State<MakeReport> createState() => _MakeReportState();
}

class _MakeReportState extends State<MakeReport> {
  Map<String, String> oEmergencia = {};
  String tipo = "Seleccione";
  String caso = selectList.first;
  String producto = "";
  String descripcion = "";
  String imagen = "tramites/Gente".toLowerCase();
  CmbKeyValue? cmbReporteEmergencia;
  late Capitania capitania;

  List<CmbKeyValue> lstReporteEmergencia = <CmbKeyValue>[
    const CmbKeyValue('1', 'Ubicación Actual'),
    // const CmbKeyValue('2', 'Desde otro lugar'),
  ];

  List<String> lst = [];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool contenido = false;
  bool xsolicitud = false;

  bool bImg = false;
  bool bSar = false;
  bool bSarX = false;
  late Position position;

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
    //calculateDistance(position.latitude, position.longitude);
  }

  @override
  void initState() {
    super.initState();

    getCurrentLocation().then((value) {
      setState(() {
        position = value;
        // print("Conectando inicio : " + descripcion);
        // print(position);
        // gps.calculateDistance(p.latitude, p.longitude).then((val) => {
        //       setState(
        //         () {
        //           capitania = val;
        //           print(p);
        //           print(capitania.ubicacion);
        //           print(capitania.nombre);
        //         },
        //       )
        //     });
      });
    });
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
                        "A continuación, seleccione el tipo de reporte que va a realizar empleando la lista desplegable"),
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
                                descripcion = '';
                                if (tipo == 'Denuncias') {
                                  imagen = "group/denuncias";
                                  bImg = true;
                                } else if (tipo !=
                                    'Emergencias de Embarcaciones') {
                                  xsolicitud = true;
                                  bImg = false;
                                  caso = selectList.first;
                                } else {
                                  imagen = "group/sar";
                                  bImg = true;
                                  bSar = true;
                                }

                                if (tipo == 'Seleccione') {
                                  xsolicitud = false;
                                  bSar = false;
                                  contenido = false;
                                } else {
                                  mdlOk(context);
                                }
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
                          "Seleccione el tipo de solicitud en la que presenta inconveniente y especifique la temática."),
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
                                  producto = "Seleccione";
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
                        child: reporteEmergencia(width),
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
                    'Siguiente',
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
    if (tipo == 'Emergencias de Embarcaciones') {
      if (cmbReporteEmergencia!.id == "2") {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EmergenciaEstado(),
            ));
      } else {
        oEmergencia = {
          "estado": '',
          "cidudad": '',
          'municipio': '',
          'parroquia': '',
          'direccion': '',
          'ubicacion': "lat: ${position.latitude}, long: ${position.longitude}",
          'destino': "TODAS",
        };
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmergenciaMenor(
                oEmergencia: oEmergencia,
              ),
            ));
      }
    } else {
      if (tipo == "Denuncias") {
        continuar();
      } else if (descripcion != "") {
        print(descripcion);
        continuar();
      }
    }
  }

  void continuar() {
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
              texto2(
                  "\"INEA Te Escucha\" es una herramienta tecnológica que responde a la política del 1x10 del Buen Gobierno, a través de la cual podrá hacer sus quejas y reclamos, sugerencias, denuncias y reportar emergencias de embarcaciones de manera formal. De esta manera la Casa del Sector Acuático podrá procesarlas y verificarlas de forma inmediata, dependiendo de la localidad y el tipo de requerimiento. Para ello, no se precisa que la persona esté inscrita con su 1×10 en el Sistema Patria."),
              const SizedBox(
                height: 5,
              ),
              texto2(
                  "Te sugerimos leer nuestra Política de Privacidad y los Términos de Seguridad."),
              const SizedBox(height: 5),
              texto2("¡Seamos parte de la solución!"),
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

  Container reporteEmergencia(double width) {
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
