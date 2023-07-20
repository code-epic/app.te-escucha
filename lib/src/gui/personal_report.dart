import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/material/date_picker.dart';
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
  Map<String, String> prsCliente = {};

  CmbKeyValue? cmbEstado;
  CmbKeyValue? cmbMunicipio;
  CmbKeyValue? cmbParroquia;

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
      print('Control de notas');
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

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    dateinput.text = "";
    // const msj = widget.tipo + widget.caso + widget.producto;

    obtenerEstados();
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

                          setState(() {
                            dateinput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                    TextFormField(
                      style: textPersonal,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Nombre completo',
                      ),
                    ),
                    TextFormField(
                      style: textPersonal,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Edad',
                      ),
                    ),
                    TextFormField(
                      style: textPersonal,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Email',
                        // suffixIcon: Icon(
                        //   Icons.email_outlined,
                        // ),
                      ),
                    ),
                    TextFormField(
                      style: textPersonal,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Teléfono',
                        // suffixIcon: Icon(
                        //   Icons.phone_android_rounded,
                        // ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Estado(width),
                    const SizedBox(
                      height: 10,
                    ),
                    Municipio(width),
                    const SizedBox(
                      height: 10,
                    ),
                    Parroquia(width),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      style: textPersonal,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xffe7ecf0),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.1),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: 'Direccion',
                      ),
                    ),
                  ],
                ),
              )),
          buttomNext(context, prsCliente),
        ]));
  }

  Container Estado(double width) {
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

  Container Municipio(double width) {
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

  Container Parroquia(double width) {
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
    return Positioned(
      top: 20,
      left: 45,
      child: Container(
        child: const Text(
          "Reporte personal",
          style: textStyle,
        ),
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
    return Positioned(
        top: 54,
        right: 15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
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
        "Datos",
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
                    nextPage(widget.accion, widget.tipo, widget.caso,
                        widget.producto, persona, widget.descripcion);
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
}
