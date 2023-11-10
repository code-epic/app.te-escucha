import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/emergencia/emergenciapersonas.dart';
import 'package:te_escucha/src/model/const.dart';
import 'package:te_escucha/src/bloc/combo.dart';

class EmergenciaFinal extends StatefulWidget {
  Map<String, String> oEmergencia;
  Map<String, String> oPersona;
  Map<String, String> oEmbarcacion;

  EmergenciaFinal(
      {super.key,
      required this.oEmergencia,
      required this.oPersona,
      required this.oEmbarcacion});

  @override
  State<EmergenciaFinal> createState() => _EmergenciaFinalState();
}

class _EmergenciaFinalState extends State<EmergenciaFinal> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController lugarsalida = TextEditingController();
  TextEditingController fechahorasalida = TextEditingController();
  TextEditingController lugarretorno = TextEditingController();
  TextEditingController fechahoraretorno = TextEditingController();
  TextEditingController lugardestino = TextEditingController();
  TextEditingController actividad = TextEditingController();
  DateTime dateTime = DateTime.now();
  String horas = '';
  String minutos = '';

  @override
  void initState() {
    super.initState();
    print(widget.oPersona);
    print(widget.oEmergencia);
    print(widget.oEmbarcacion);
  }

  @override
  Widget build(BuildContext context) {
    horas = dateTime.hour.toString().padLeft(2, '0');
    minutos = dateTime.minute.toString().padLeft(2, '0');
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
                texto1("Datos para la búsqueda."),
                texto2("Los datos ayudarán a ubicar la embarcación "),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: lugarsalida,
                    style: textPersonal,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Lugar de la salida',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onTap: () => {pickDateTime()},
                    controller: fechahorasalida,
                    style: textPersonal,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Fecha y hora de la salida',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: lugarretorno,
                    style: textPersonal,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Lugar de retorno',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: fechahoraretorno,
                    style: textPersonal,
                    onTap: () => {pickDateTimeF()},
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Fecha y hora estimada de retorno',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: lugardestino,
                    style: textPersonal,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Lugar de destino',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: actividad,
                    style: textPersonal,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Actividad que iban a realizar',
                    ),
                  ),
                ),
              ]),
          buttomNext(context),
        ]));
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return false;
    TimeOfDay? time = await pickTime();
    if (time == null) return false;
    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      fechahorasalida.text =
          "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
    });
  }

  Future pickDateTimeF() async {
    DateTime? date = await pickDate();
    if (date == null) return false;
    TimeOfDay? time = await pickTime();
    if (time == null) return false;
    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      fechahoraretorno.text =
          "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
    });
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2024));

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

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
                    if (lugardestino.text != '' &&
                        lugarretorno.text != '' &&
                        actividad.text != '' &&
                        fechahoraretorno.text != '') {
                      nextPage();
                    }
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
    Map<String, String> busquedad = {
      "lugarsalida": lugarsalida.text,
      "fechahorasalida": fechahorasalida.text,
      "lugarretorno": lugarretorno.text,
      "fechahoraretorno": fechahoraretorno.text,
      "lugardestino": lugardestino.text,
      "actividad": actividad.text
    };
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EmergenciaPersona(
                oEmbarcacion: widget.oEmbarcacion,
                oEmergencia: widget.oEmergencia,
                oPersona: widget.oPersona,
                oBusqueda: busquedad,
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
}
