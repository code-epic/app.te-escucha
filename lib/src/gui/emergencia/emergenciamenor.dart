import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:te_escucha/src/gui/emergencia/emergenciaembarcacion.dart';
import 'package:te_escucha/src/model/cehttpclient.dart';
import 'package:te_escucha/src/model/const.dart';
import 'package:te_escucha/src/bloc/combo.dart';
import 'package:intl/intl.dart';

class EmergenciaMenor extends StatefulWidget {
  final Map<String, String> oEmergencia;

  const EmergenciaMenor({super.key, required this.oEmergencia});

  @override
  State<EmergenciaMenor> createState() => _EmergenciaMenorState();
}

class _EmergenciaMenorState extends State<EmergenciaMenor> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController cedula = TextEditingController();
  TextEditingController edad = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController parentesco = TextEditingController();
  TextEditingController otro = TextEditingController();
  TextEditingController tel1 = TextEditingController();
  TextEditingController tel2 = TextEditingController();

  Map<String, String> prsCliente = {};
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  CmbKeyValue? cmbParentesco;
  bool blOtro = false;
  late bool blEdad = false;
  List<dynamic> lst = [];

  List<CmbKeyValue> lstParentesco = <CmbKeyValue>[
    const CmbKeyValue('1', 'MADRE / PADRE '),
    const CmbKeyValue('2', 'ESPOSA / ESPOSO '),
    const CmbKeyValue('3', 'HIJA / HIJO'),
    const CmbKeyValue('4', 'VECINO / VECINA'),
    const CmbKeyValue('5', 'OTRO '),
  ];

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.oEmergencia);
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
          ListView(
              padding: EdgeInsets.only(left: 10, right: 20),
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(
                  height: 65,
                ),
                texto1(
                    "Usted debe realizar un reporte para que nuestro equipo pueda atender su caso."),
                const SizedBox(
                  height: 5,
                ),
                texto2(
                    "Ingrese los datos de la persona que está realizando el reporte."),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: cedula,
                    style: textPersonal,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Cédula ',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
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
                          obtenerDatosPersonales(cedula.text, fechaNacimiento);
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nombre,
                    style: textPersonal,
                    enabled: false,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nombre completo',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Parentesco(width),
                ),
                const SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: blOtro,
                  child: TextFormField(
                    controller: otro,
                    style: textPersonal,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Especifique vínculo',
                    ),
                  ),
                ),
                texto1("Otros números telefónicos de contacto."),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: tel1,
                    style: textPersonal,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Teléfono #1',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: tel2,
                    style: textPersonal,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Teléfono #2',
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

  Positioned paginador() {
    return const Positioned(
        top: 54,
        right: 15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "2/5",
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

  Container Parentesco(double width) {
    return Container(
        padding: const EdgeInsets.only(left: 9, right: 3),
        height: 40,
        width: width,
        decoration: decoracionCombo(),
        child: DropdownButton<CmbKeyValue>(
          value: cmbParentesco,
          hint: const Text("Parentesco con los tripulantes"),
          icon: const Icon(Icons.arrow_drop_down_sharp),
          elevation: 16,
          onChanged: (CmbKeyValue? value) {
            setState(() {
              blOtro = false;
              cmbParentesco = value;
              if (cmbParentesco!.id == '5') {
                blOtro = true;
              }
            });
          },
          underline: Container(),
          items: lstParentesco
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
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                    if (nombre.text != '' && tel1.text != '') {
                      nextPage();
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

  void nextPage() {
    prsCliente = {
      "cedula": cedula.text,
      "fecha": dateinput.text,
      "nombre": nombre.text,
      "parentesco": cmbParentesco!.id.toString(),
      "otro": otro.text,
      "telefono1": tel1.text,
      "telefono2": tel2.text
    };

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EmergenciaEmbarcacion(
                oEmergencia: widget.oEmergencia,
                oPersona: prsCliente,
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
}
