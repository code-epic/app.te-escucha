import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/comprobante.dart';
import 'package:te_escucha/src/model/const.dart';

import 'package:intl/intl.dart';
import 'package:te_escucha/src/model/localstoragehelper.dart';
import 'package:te_escucha/src/model/user_perfil.dart';

import '../model/cehttpclient.dart';
import '../model/solicitud.dart';

class MakeReportMsg extends StatefulWidget {
  final int accion;
  final String tipo;
  final String caso;
  final String producto;
  final Map<String, String> persona;
  final String descripcion;

  const MakeReportMsg(
      {super.key,
      required this.accion,
      required this.tipo,
      required this.caso,
      required this.producto,
      required this.persona,
      required this.descripcion});

  @override
  State<MakeReportMsg> createState() => _MakeReportMsgState();
}

class _MakeReportMsgState extends State<MakeReportMsg> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController dateinput = TextEditingController();
  TextEditingController xdescripcion = TextEditingController();
  List<String> lst = [];
  String imagen = "tramites/Gente".toLowerCase();
  String contenido = "";
  Map<String, String> prsCliente = {};
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

    String wkfDoc = json['msj'].toString();
    String cedula = prsCliente['cedula'].toString();
    String nombre = prsCliente['nombre'].toString();
    List<String> fecha = prsCliente['fecha'].toString().split('/');
    List<String> evento = prsCliente['evento'].toString().split('/');
    String descripcion = prsCliente['descripcion'].toString();
    var xcaso = widget.caso;

    if (widget.tipo == "Denuncia") {
      xcaso = "Denuncia";
    } else if (widget.tipo == "Emergencias de Embarcaciones") {
      xcaso = "Emergencias de Embarcaciones";
    }
    detalle = WKF_IDocumentoDetalle(
      wfdocumento: int.parse(wkfDoc),
      privacidad: 1,
      ncontrol: wkfDoc,
      fcreacion: '${evento[2]}-${evento[1]}-${evento[0]}',
      forigen: '${evento[2]}-${evento[1]}-${evento[0]}',
      norigen: nombre,
      salida: cedula,
      tipo: widget.tipo,
      remitente: Usuario.correo,
      unidad: xcaso,
      comando: '',
      contenido: descripcion,
      instrucciones: '',
      codigo: '${fecha[2]}-${fecha[1]}-${fecha[0]}',
      nexpediente: Usuario.nombre,
      archivo: Usuario.foto,
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
      nextPage(
          wkfDoc, 0, widget.tipo, widget.caso, widget.producto, prsCliente);
    });
  }

  void setDocWKF() {
    int estaDestino =
        getEstadoWKF(prsCliente['categoria'].toString(), widget.tipo);
    document = WKF_IDocumento(
        nombre: widget.tipo,
        workflow: 2,
        observacion: widget.producto,
        estado: estaDestino,
        estatus: 1,
        usuario: Usuario.correo);

    _setDocumento(jsonEncode(document.toJson()));
  }

  @override
  void initState() {
    super.initState();
    if (LocalStorageHelper().getValue('token_wkf_inea') == null) {
    } else {
      getCurrentUserEmail().then((value) {
        setState(() {
          Usuario = value;
        });
      });
    }
    dateinput.text = "";
    imagen = widget.producto;
    contenido = widget.descripcion;
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
          titulo(widget.tipo),
          barra_cargando(context),
          paginador(),
          Positioned(
              top: 40,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    texto1(
                        "Suministre la siguiente información acerca del inconveniente presentado."),
                    texto2("Fecha en la que ocurrieron los hechos"),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: dateinput,
                      style: textPersonal,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffe7ecf0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 0.1),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: 'Fecha  (*)',
                        prefixIcon: const Icon(
                          Icons.calendar_month,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            print("Hola");
                          },
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            locale: const Locale("es", "ES"),
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                1950), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2025));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            dateinput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Fecha no seleccionada");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    texto2(
                        "Especifique los hechos de manera clara y precisa (responda las siguientes interrogantes ¿qué pasó? ¿cómo? ¿cuándo? ¿dónde? ¿quiénes participaron en la acción?)"),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      style: textPersonal,
                      controller: xdescripcion,
                      textAlign: TextAlign.justify,
                      textAlignVertical: TextAlignVertical.top,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xffe7ecf0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.1),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: 'Descripción* ',
                      ),
                    ),
                  ],
                ),
              )),
          buttomNext(context),
        ]));
  }

  Positioned titulo(String tipo) {
    return Positioned(
      top: 20,
      left: 45,
      child: Container(
        child: Text(
          tipo,
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
          image: AssetImage('assets/group/load_4.png'),
        ));
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
        padding: const EdgeInsets.all(5.0),
        child: Text(texto, textAlign: TextAlign.justify, style: textJustify));
  }

  Padding texto1(String text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
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
                    backgroundColor: const Color(0xff174076),
                    shadowColor: const Color(0xff174076), // background
                    foregroundColor: Colors.white, // foreground
                    minimumSize: const Size(180, 40),
                    maximumSize: const Size(180, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () {
                    if (xdescripcion.text != '' && dateinput.text != '') {
                      String cedula = widget.persona['cedula'].toString();
                      String nombre = widget.persona['nombre'].toString();
                      String fecha = widget.persona['fecha'].toString();
                      mdlOk(context, nombre);
                      prsCliente = {
                        "cedula": cedula,
                        "nombre": nombre,
                        "fecha": fecha,
                        "evento": dateinput.text,
                        "descripcion": xdescripcion.text,
                        "categoria": definirTipo(widget.descripcion)
                      };
                      setDocWKF();
                    }
                  },
                  child: const Text(
                    'Enviar',
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
                  "¡Hemos recibido tu reporte de manera satisfactoria! \n\nMuchas gracias por colaborar con nosotros para fomentar la mejora continua de nuestros trámites y servicios. Pronto nos estaremos comunicando con ud. para llevar a feliz término el caso planteado. Te sugerimos estar atento a la bandeja de correo para conocer el estatus de tu reporte."),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  void nextPage(String codigo, int accion, String tipo, String caso,
      String producto, Map<String, String> persona) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MakeComprobante(
                codigo: codigo,
                accion: accion,
                tipo: tipo,
                caso: caso,
                producto: producto,
                persona: persona,
              )),
    );
  }
}
