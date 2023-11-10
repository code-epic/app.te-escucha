import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/emergencia/emergenciamenor.dart';
import 'package:te_escucha/src/model/const.dart';
import 'package:te_escucha/src/model/cehttpclient.dart';
import 'package:te_escucha/src/bloc/combo.dart';

class EmergenciaEstado extends StatefulWidget {
  const EmergenciaEstado({super.key});

  @override
  State<EmergenciaEstado> createState() => _EmergenciaEstadoState();
}

class _EmergenciaEstadoState extends State<EmergenciaEstado> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController txtDireccion = TextEditingController();

  Map<String, String> oEmergencia = {};

  CmbKeyValue? cmbEstado;
  CmbKeyValue? cmbCiudad;
  CmbKeyValue? cmbMunicipio;
  CmbKeyValue? cmbParroquia;

  List<dynamic> lst = [];

  List<CmbKeyValue> lstEstados = <CmbKeyValue>[
    const CmbKeyValue('0', 'Estado * ')
  ];

  List<CmbKeyValue> lstCiudad = <CmbKeyValue>[
    const CmbKeyValue('0', 'Ciudad * ')
  ];

  List<CmbKeyValue> lstMunicipio = <CmbKeyValue>[
    const CmbKeyValue('0', 'Municipio * ')
  ];

  List<CmbKeyValue> lstParroquia = <CmbKeyValue>[
    const CmbKeyValue('0', 'Parroquia * ')
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

  Future obtenerCidudad() async {
    const Map<String, dynamic> data = {
      'funcion': 'ListarCiudad',
      'parametros': ''
    };
    var response = await CeHttpClient.xPOST(sPath, data);
    var json = jsonDecode(response);
    lst = json['Cuerpo'];
    setState(() {
      cmbCiudad = lstCiudad[0];

      for (var e in lst) {
        lstCiudad.add(CmbKeyValue(e['id_ciudad'], e['ciudad']));
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

  CmbKeyValue? cmbParentesco;

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
          ListView(
              padding: const EdgeInsets.only(left: 10, right: 20),
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(
                  height: 65,
                ),
                texto1("Debe Ingresar los datos del origen de la emergencia."),
                texto2(
                    "Los datos ayudarán en el proceso de búsqueda y salvamento"),
                const SizedBox(
                  height: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                setEstado(width),
                const SizedBox(
                  height: 10,
                ),
                setCiudad(width),
                const SizedBox(
                  height: 10,
                ),
                setMunicipio(width),
                const SizedBox(
                  height: 10,
                ),
                setParroquia(width),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: txtDireccion,
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
                    labelText: 'Dirección',
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
          image: AssetImage('assets/group/load_1.png'),
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
              "1/5",
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
                    nextPage();
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

  void nextPage() {
    oEmergencia = {
      "estado": cmbEstado!.id.toString(),
      "cidudad": cmbCiudad!.id.toString(),
      'municipio': cmbMunicipio!.id.toString(),
      'parroquia': cmbParroquia!.id.toString(),
      'direccion': txtDireccion.text,
      'latitud': '',
      'logintud': '',
    };
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EmergenciaMenor(
                oEmergencia: oEmergencia,
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
      padding: const EdgeInsets.all(5.0),
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
      padding: const EdgeInsets.all(5.0),
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

  Container setEstado(double width) {
    return Container(
        padding: const EdgeInsets.only(left: 9, right: 3),
        height: 40,
        width: width,
        decoration: decoracionCombo(),
        child: DropdownButton<CmbKeyValue>(
          value: cmbEstado,
          hint: const Text("Estado *"),
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

  Container setCiudad(double width) {
    return Container(
        padding: const EdgeInsets.only(left: 9, right: 3),
        height: 40,
        width: width,
        decoration: decoracionCombo(),
        child: DropdownButton<CmbKeyValue>(
          value: cmbCiudad,
          hint: const Text("Ciudad *"),
          icon: const Icon(Icons.arrow_drop_down_sharp),
          elevation: 16,
          onChanged: (CmbKeyValue? value) {
            setState(() {
              cmbCiudad = value;
              obtenerMunicipios(value!.id);
            });
          },
          underline: Container(),
          items: lstCiudad
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
          hint: const Text("Municipio *"),
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
          hint: const Text("Parroquia *"),
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
}
