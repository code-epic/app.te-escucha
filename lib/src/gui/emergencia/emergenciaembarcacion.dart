import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/emergencia/emergenciafinal.dart';
import 'package:te_escucha/src/model/const.dart';
import 'package:te_escucha/src/bloc/combo.dart';

class EmergenciaEmbarcacion extends StatefulWidget {
  Map<String, String> oEmergencia;
  Map<String, String> oPersona;

  EmergenciaEmbarcacion(
      {super.key, required this.oEmergencia, required this.oPersona});

  @override
  State<EmergenciaEmbarcacion> createState() => _EmergenciaEmbarcacionState();
}

class _EmergenciaEmbarcacionState extends State<EmergenciaEmbarcacion> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController embarcacion = TextEditingController();
  TextEditingController matricula = TextEditingController();
  TextEditingController colorI = TextEditingController();
  TextEditingController colorE = TextEditingController();
  CmbKeyValue? cmbTipoEmbarcaciones;

  Map<String, String> embarcaiones = {};

  List<CmbKeyValue> lstTipoEmbarcaciones = <CmbKeyValue>[
    const CmbKeyValue('PA', 'PASAJE'),
    const CmbKeyValue('NU', 'NUCLEARES'),
    const CmbKeyValue('DE', 'DEPORTIVOS'),
    const CmbKeyValue('RE', 'RECREO'),
    const CmbKeyValue('SE', 'SERVICIO'),
    const CmbKeyValue('PE', 'PESQUERO'),
    const CmbKeyValue('CI', 'CIENTÍFICO'),
    const CmbKeyValue('CA', 'DE CARGA'),
    const CmbKeyValue('TA', 'TANQUERO'),
    const CmbKeyValue('PL', 'PLATAFORMAS'),
    const CmbKeyValue('TU', 'TURISMO'),
    const CmbKeyValue('AN', 'ACCESORIOS DE NAVEGACIÓN'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.oEmergencia);
    print(widget.oPersona);
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
                texto1("Debe Ingresar los datos de la embarcación."),
                texto2("Los datos ayudarán a ubicar la embarcación "),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: embarcacion,
                    style: textPersonal,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nombre de la embarcación',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TipoEmbarcaciones(width),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: matricula,
                    style: textPersonal,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Matrícula',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: colorE,
                    style: textPersonal,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Color casco externo',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: colorI,
                    style: textPersonal,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Color casco interno',
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
              "3/5",
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
                    if (embarcacion.text != '' &&
                        colorI.text != '' &&
                        colorE.text != '') {
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
    embarcaiones = {
      "embarcacion": embarcacion.text,
      "destinacion": cmbTipoEmbarcaciones!.id.toString(),
      "matricula": matricula.text,
      "colori": colorI.text,
      "colore": colorE.text
    };

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EmergenciaFinal(
                oEmbarcacion: embarcaiones,
                oEmergencia: widget.oEmergencia,
                oPersona: widget.oPersona,
              )),
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
        style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Container TipoEmbarcaciones(double width) {
    return Container(
        padding: const EdgeInsets.only(left: 9, right: 3),
        height: 40,
        width: width,
        decoration: decoracionCombo(),
        child: DropdownButton<CmbKeyValue>(
          value: cmbTipoEmbarcaciones,
          hint: const Text("Destinación de la embarcación"),
          icon: const Icon(Icons.arrow_drop_down_sharp),
          elevation: 16,
          onChanged: (CmbKeyValue? value) {
            setState(() {
              cmbTipoEmbarcaciones = value;
              print(cmbTipoEmbarcaciones!.id);
            });
          },
          underline: Container(),
          items: lstTipoEmbarcaciones
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
}
