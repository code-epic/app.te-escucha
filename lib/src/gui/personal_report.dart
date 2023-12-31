import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:te_escucha/src/bloc/combo.dart';
import 'package:te_escucha/src/gui/make_report_msg.dart';
import 'package:te_escucha/src/gui/tercero_report.dart';
import 'package:te_escucha/src/model/cehttpclient.dart';
import 'package:te_escucha/src/model/const.dart';

import 'package:intl/intl.dart';

class PersonalReport extends StatefulWidget {
  final int accion;
  final String tipo;
  final String caso;
  final String producto;
  final String descripcion;

  const PersonalReport(
      {super.key,
      required this.accion,
      required this.tipo,
      required this.caso,
      required this.producto,
      required this.descripcion});

  @override
  State<PersonalReport> createState() => _PersonalReportState();
}

class _PersonalReportState extends State<PersonalReport> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController cedula = TextEditingController();
  TextEditingController edad = TextEditingController();
  TextEditingController nombre = TextEditingController();

  Map<String, String> prsCliente = {};

  CmbKeyValue? cmbEstado;
  CmbKeyValue? cmbMunicipio;
  CmbKeyValue? cmbParroquia;

  late bool blEdad = false;

  List<dynamic> lst = [];

  List<CmbKeyValue> lstEstados = <CmbKeyValue>[
    const CmbKeyValue('0', 'Estado* ')
  ];

  List<CmbKeyValue> lstMunicipio = <CmbKeyValue>[
    const CmbKeyValue('0', 'Municipio* ')
  ];
  List<CmbKeyValue> lstParroquia = <CmbKeyValue>[
    const CmbKeyValue('0', 'Parroquia* ')
  ];

  Future obtenerEstados() async {
    const Map<String, dynamic> data = {
      'funcion': 'ListarEstados',
      'parametros': ''
    };
    var response = await CeHttpClient.xPOST(sPath, data);
    var json = jsonDecode(response);
    lst = json['Cuerpo'];
    setState(() {
      cmbEstado = lstEstados[0];
      cmbMunicipio = lstMunicipio[0];
      cmbParroquia = lstParroquia[0];
      for (var e in lst) {
        lstEstados.add(CmbKeyValue(e['id_estado'], e['estado']));
      }
    });
  }

  Future obtenerMunicipios(String idEstado) async {
    Map<String, dynamic> data = {
      'funcion': 'ListarMunicipio',
      'parametros': idEstado
    };
    var response = await CeHttpClient.xPOST(sPath, data);
    var json = jsonDecode(response);
    lst = json['Cuerpo'];
    setState(() {
      cmbMunicipio = lstMunicipio[0];
      for (var e in lst) {
        lstMunicipio.add(CmbKeyValue(e['id_municipio'], e['municipio']));
      }
    });
  }

  Future obtenerParroquia(String idMunicipio) async {
    Map<String, dynamic> data = {
      'funcion': 'ListarParroquia',
      'parametros': idMunicipio
    };
    var response = await CeHttpClient.xPOST(sPath, data);
    var json = jsonDecode(response);
    lst = json['Cuerpo'];
    setState(() {
      cmbParroquia = lstParroquia[0];
      for (var e in lst) {
        lstParroquia.add(CmbKeyValue(e['id_parroquia'], e['parroquia']));
      }
    });
  }

  Future obtenerDatosPersonales(String cedula, String fechaNacimiento) async {
    blEdad = false;
    Map<String, dynamic> data = {
      'funcion': 'INEA_CCedula',
      'parametros': '$cedula,$fechaNacimiento'
    };
    var response = await CeHttpClient.xPOST(sPath, data);
    var json = jsonDecode(response);
    lst = json['Cuerpo'];
    setState(() {
      if (lst.isNotEmpty) {
        for (var e in lst) {
          //12385797
          //1975-10-26
          //sigla1 | nombre1 | nombre2 | apellido1 | apellido2
          var nomb = '${e['nombre1']} ${e['nombre2']}';
          var apel = '${e['apellido1']} ${e['apellido2']}';
          nombre.text = '$nomb $apel'.toUpperCase();
          blEdad = true;
        }
      } else {
        mdlOk(context);
      }
    });
  }

  calcularEdad(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    edad.text = age.toString();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // Limpia el controller cuando se elimina el widget
    cedula.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //widget tipo, descripcion, caso
    super.initState();
    dateinput.text = "";

    // obtenerEstados();
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
          barraCargando(context),
          paginador(),
          Positioned(
              top: 60,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    texto1(),
                    TextFormField(
                      style: textPersonal,
                      controller: cedula,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Cédula',
                      ),
                    ),
                    TextFormField(
                      controller: dateinput,
                      style: textPersonal,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Fecha de Nacimiento',
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
                          String fechaNacimiento =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            dateinput.text =
                                formattedDate; //set output date to TextField value.
                            calcularEdad(pickedDate);
                            obtenerDatosPersonales(
                                cedula.text, fechaNacimiento);
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                    Visibility(
                      visible: blEdad,
                      child: TextFormField(
                        style: textPersonal,
                        enabled: true,
                        controller: nombre,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Nombre completo',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: blEdad,
                      child: TextFormField(
                        style: textPersonal,
                        controller: edad,
                        enabled: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Edad',
                        ),
                      ),
                    )
                    // TextFormField(
                  ],
                ),
              )),
          buttomNext(context, prsCliente),
        ]));
  }

  Container setEstado(double width) {
    return Container(
        padding: const EdgeInsets.only(left: 9, right: 3),
        height: 40,
        width: width,
        decoration: decoracionCombo(),
        child: DropdownButton<CmbKeyValue>(
          value: cmbEstado,
          icon: const Icon(Icons.arrow_drop_down_sharp),
          elevation: 16,
          onChanged: (CmbKeyValue? value) {
            setState(() {
              cmbEstado = value;
              obtenerMunicipios(value!.id);
            });
          },
          underline: Container(),
          items: lstEstados
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

  Container setMunicipio(double width) {
    return Container(
        padding: const EdgeInsets.only(left: 9, right: 3),
        height: 40,
        width: width,
        decoration: decoracionCombo(),
        child: DropdownButton<CmbKeyValue>(
          value: cmbMunicipio,
          icon: const Icon(Icons.arrow_drop_down_sharp),
          elevation: 16,
          onChanged: (CmbKeyValue? value) {
            setState(() {
              cmbMunicipio = value;
              obtenerParroquia(value!.id);
            });
          },
          underline: Container(),
          items: lstMunicipio
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

  Container setParroquia(double width) {
    return Container(
        padding: const EdgeInsets.only(left: 9, right: 3),
        height: 40,
        width: width,
        decoration: decoracionCombo(),
        child: DropdownButton<CmbKeyValue>(
          value: cmbParroquia,
          icon: const Icon(Icons.arrow_drop_down_sharp),
          elevation: 16,
          onChanged: (CmbKeyValue? value) {
            setState(() {
              cmbParroquia = value;
            });
          },
          underline: Container(),
          items: lstParroquia
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
          fontSize: 13, fontFamily: 'Roboto', fontWeight: FontWeight.bold),
    );
  }

  Container reportePersonal(
      double width, String img, String titulo, String descripcion) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: const Color(0xff02509c))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('assets/group/$img.png'),
                width: 100,
                height: 100,
              ),
              SizedBox(
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
              ),
            ],
          )
        ],
      ),
    );
  }

  Positioned titulo() {
    return const Positioned(
      top: 20,
      left: 45,
      child: Text(
        "Reporte personal",
        style: textStyle,
      ),
    );
  }

  Positioned barraCargando(BuildContext context) {
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
              "3/4",
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

  Padding texto1() {
    return const Padding(
      padding: EdgeInsets.all(5.0),
      child: Text(
        "Complete los siguientes datos personales. Recuerde que el reporte lo está efectuando a título propio.",
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

  Positioned buttomNext(BuildContext context, Map<String, String> persona) {
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
                    minimumSize: const Size(180, 40),
                    maximumSize: const Size(180, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () {
                    persona = {
                      "cedula": cedula.text,
                      "fecha": dateinput.text,
                      "nombre": nombre.text,
                    };
                    if (cedula.text != '' && nombre.text != '') {
                      nextPage(widget.accion, widget.tipo, widget.caso,
                          widget.producto, persona, widget.descripcion);
                    }
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

  void nextPage(int accion, String tipo, String caso, String producto,
      Map<String, String> persona, String descripcion) {
    if (accion == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MakeReportMsg(
                  accion: accion,
                  tipo: tipo,
                  caso: caso,
                  producto: producto,
                  persona: persona,
                  descripcion: descripcion,
                )),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TerceroReport(
                  accion: accion,
                  tipo: tipo,
                  caso: caso,
                  producto: producto,
                  descripcion: descripcion,
                )),
      );
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
              texto3("\"INEA Te Escucha\" "),
              const SizedBox(height: 8),
              texto2("Estimado usuario verifique"),
              const SizedBox(
                height: 2,
              ),
              texto2("La cédula o el campo fecha no coiciden."),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Padding texto3(String text) {
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
}
