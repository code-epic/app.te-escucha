import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:te_escucha/src/gui/emergencia/emergenciareport.dart';
import 'package:te_escucha/src/model/cehttpclient.dart';
import 'package:te_escucha/src/model/const.dart';

import 'package:te_escucha/src/bloc/combo.dart';
import 'package:te_escucha/src/model/logingoogle.dart';
import 'package:te_escucha/src/model/solicitud.dart';
import 'package:te_escucha/src/model/user_perfil.dart';

class EmergenciaPersona extends StatefulWidget {
  Map<String, String> oEmergencia;
  Map<String, String> oPersona;
  Map<String, String> oEmbarcacion;
  Map<String, String> oBusqueda;

  EmergenciaPersona(
      {super.key,
      required this.oEmergencia,
      required this.oPersona,
      required this.oEmbarcacion,
      required this.oBusqueda});

  @override
  State<EmergenciaPersona> createState() => _EmergenciaPersonaState();
}

class _EmergenciaPersonaState extends State<EmergenciaPersona> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController total = TextEditingController();
  TextEditingController mcantadultos = TextEditingController();
  TextEditingController mcantmenores = TextEditingController();
  TextEditingController fcantadultos = TextEditingController();
  TextEditingController fcantmenores = TextEditingController();

  Map<String, String> cantidad = {};
  CmbKeyValue? cmbParentesco;

  late WKF_IDocumento document;
  late WKF_IDocumentoDetalle detalle;

  late UserPerfil Usuario = UserPerfil(
      cedula: '',
      nombre: '',
      correo: '',
      foto: '',
      telefono: '',
      direccion: '');

  Future<UserPerfil> getCurrentUserEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    String? xnombre = user?.displayName;
    String? xcorreo = user?.email;
    String? xfoto = user?.photoURL;

    return UserPerfil(
        cedula: '',
        nombre: xnombre.toString(),
        correo: xcorreo.toString(),
        foto: xfoto.toString(),
        telefono: '',
        direccion: '');
  }

  Future _setDocumento(String valores) async {
    Map<String, dynamic> data = {
      'funcion': 'WKF_IDocumento',
      'parametros': '',
      'valores': valores
    };

    var response = await CeHttpClient.xPOST(sPath, data);
    var json = jsonDecode(response);

    var prsCliente = widget.oPersona;

    String wkfDoc = json['msj'].toString();
    String cedula = prsCliente['cedula'].toString();
    String nombre = prsCliente['nombre'].toString();
    String fecha = new DateTime.now().toString();

    detalle = WKF_IDocumentoDetalle(
      wfdocumento: int.parse(wkfDoc),
      privacidad: 1,
      ncontrol: wkfDoc,
      fcreacion: fecha,
      forigen: fecha,
      norigen: nombre,
      salida: cedula,
      tipo: "SAR",
      remitente: Usuario.correo,
      unidad: "Emergencias de Embarcaciones",
      comando: '',
      contenido: contenidoGeneral(),
      instrucciones: '',
      codigo: widget.oPersona['telefono1'].toString(),
      nexpediente: Usuario.foto,
      archivo: Usuario.nombre,
      creador: '',
    );

    data = {
      'funcion': 'WKF_IDocumentoDetalle',
      'parametros': '',
      'valores': jsonEncode(detalle.toJson())
    };
    var xresponse = await CeHttpClient.xPOST(sPath, data);
    var xjson = jsonDecode(xresponse);
    var datos = xjson;

    setState(() {
      print(datos);
      nextPage();
    });
  }

  void setDocWKF() {
    document = WKF_IDocumento(
        nombre: "SAR",
        workflow: 2,
        observacion: "Emergencia de Embarcaciones",
        estado: 14,
        estatus: 1,
        usuario: Usuario.correo);

    _setDocumento(jsonEncode(document.toJson()));
  }

  String contenidoGeneral() {
    cantidad = {
      "total": total.text,
      "masadultos": mcantadultos.text,
      "mmenores": mcantmenores.text,
      "fasadultos": fcantadultos.text,
      "fmenores": fcantmenores.text,
    };
    return """{"persona": ${jsonEncode(widget.oPersona)},"emergencia": ${jsonEncode(widget.oEmergencia)},
  "busqueda": ${jsonEncode(widget.oBusqueda)},"cantidad": ${jsonEncode(cantidad)},"embarcacion": ${jsonEncode(widget.oEmbarcacion)}
}""";
  }

  @override
  void initState() {
    super.initState();
    LoginGoogle().getCurrentUserEmail().then((value) {
      setState(() {
        Usuario = value;
      });
    });
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
          barra_cargando(context),
          paginador(),
          ListView(
              padding: EdgeInsets.only(left: 10, right: 20),
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(
                  height: 65,
                ),
                texto1("Ingresa cantidad de personas a bordo."),
                texto2(
                    "Los datos ayudarán en el proceso de búsqueda y salvamento"),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: total,
                    style: textPersonal,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Número total de personas embarcadas',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                texto1("Cantidad de personas masculinas."),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: mcantadultos,
                    style: textPersonal,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Adultos',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: mcantmenores,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: textPersonal,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Menores',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                texto1("Cantidad de personas femeninas."),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: fcantadultos,
                    style: textPersonal,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Adultas',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: fcantmenores,
                    style: textPersonal,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Menores',
                    ),
                  ),
                ),
              ]),
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
          image: AssetImage('assets/group/load_3.png'),
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
              "4/5",
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
                    // mdlOk(context, "Persona natural");
                    mdlOk(context, widget.oPersona['nombre']);

                    setDocWKF();
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

  void nextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EmergenciaReport(
                oBusqueda: widget.oBusqueda,
                oEmbarcacion: widget.oEmbarcacion,
                oEmergencia: widget.oEmergencia,
                oPersona: widget.oPersona,
                oCantidad: cantidad,
              )),
    );
  }

  Text textoCombos(CmbKeyValue? cmb) {
    return Text(
      cmb!.name,
      style: const TextStyle(
          fontSize: 13, fontFamily: 'Roboto', fontWeight: FontWeight.bold),
    );
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

  Future<String?> mdlOk(BuildContext context, nombre) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              texto1("\"INEA Te Escucha\" "),
              const SizedBox(height: 8),
              texto2("Estimado @$nombre"),
              const SizedBox(
                height: 2,
              ),
              texto2(
                  "¡Hemos recibido tu reporte de manera satisfactoria! \n\nNos pondremos en contacto a la brevedad posible."),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
