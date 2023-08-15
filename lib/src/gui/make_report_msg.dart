import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/comprobante.dart';
import 'package:te_escucha/src/model/const.dart';
import 'package:flutter/src/material/date_picker.dart';

import 'package:intl/intl.dart';

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
  TextEditingController dateinput = TextEditingController();
  List<String> lst = [];
  String imagen = "tramites/Gente".toLowerCase();
  String contenido = "";

  @override
  void initState() {
    super.initState();
    dateinput.text = "";
    imagen = widget.producto;
    contenido = widget.descripcion;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
              top: 40,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Center(
                    //   child: imagenSeleccion(context, imagen),
                    // ),
                    texto1(
                        "Está realizando un reclamo por un incidente que tuviste"),
                    texto2("Elige la fecha en la que ocurrieron los hechos"),
                    const SizedBox(
                      height: 8,
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
                        "Especifica los hechos de manera clara y precisa, respondiendo a las siguientes interrogantes: ¿qué paso?, ¿dónde? y ¿cuándo? "),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      style: textPersonal,
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
    return Positioned(
        top: 54,
        right: 15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
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
        padding: EdgeInsets.all(5.0),
        child: Text(texto, textAlign: TextAlign.justify, style: textJustify));
  }

  Padding texto1(String text) {
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
                    nextPage(0, widget.tipo, widget.caso, widget.producto,
                        widget.persona);
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
      Map<String, String> persona) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MakeComprobante(
                accion: accion,
                tipo: tipo,
                caso: caso,
                producto: producto,
                persona: persona,
              )),
    );
  }
}
