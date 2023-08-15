import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/make_report_msg.dart';
import 'package:te_escucha/src/gui/personal_report.dart';
import 'package:te_escucha/src/model/const.dart';

class GrupoReport extends StatefulWidget {
  final int accion;
  final String tipo;
  final String caso;
  final String producto;
  final String descripcion;

  const GrupoReport(
      {super.key,
      required this.accion,
      required this.tipo,
      required this.caso,
      required this.producto,
      required this.descripcion});

  @override
  State<GrupoReport> createState() => _GrupoReportState();
}

class _GrupoReportState extends State<GrupoReport> {
  List<String> lst = [];
  Map<String, String> prsCliente = {};
  List<Map> lstPrs = [];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    print(widget.tipo);
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
          Positioned(
              top: 60,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    texto1("Datos del representantes por grupo"),
                    texto2(
                        "Como minimo debes agregar 5 representates del reporte ingresando sus cedulas para procesa un reporte colectivo"),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      child: const Center(
                          child: Image(
                        image: AssetImage('assets/group/boton_manual.png'),
                      )),
                      onTap: () {
                        mdlCedula(context);
                      },
                    ),
                    const Divider(color: Color(0xff83cacc)),
                    Row(children: [
                      texto2("Listado de personas agregadas"),
                      const Spacer(),
                      texto2("1 de 5"),
                    ]),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: width,
                      child: DataTable(
                          border: TableBorder(
                              horizontalInside: BorderSide(
                                  width: 0.5,
                                  color: Color(0xff83cacc),
                                  style: BorderStyle.solid)),
                          columns: createColumns(),
                          rows: createRows()),
                    )
                  ],
                ),
              )),
          buttomNext(context, prsCliente),
        ]));
  }

  Future<String?> mdlCedula(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              texto1("Ingresar cedula manual"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: textPersonal,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xffe7ecf0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.1),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: 'Cedula*',
                  suffixIconColor: Color(0xff02509c),
                  suffixIcon: Icon(
                    Icons.person_3,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: textPersonal,
                textAlign: TextAlign.justify,
                textAlignVertical: TextAlignVertical.top,
                maxLines: 3,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xffe7ecf0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.1),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: 'Nombre Completo* ',
                ),
              ),
              const SizedBox(height: 35),
              buttonAdd(context),
            ],
          ),
        ),
      ),
    );
  }

  List<DataColumn> createColumns() {
    return [
      DataColumn(label: Text('Nombre completo', style: textJustify)),
      DataColumn(label: Text('Cedula', style: textJustify)),
      DataColumn(label: Text(' '))
    ];
  }

  List<DataRow> createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('1. CARLOS ENRIQUE PENA ALBARRAN', style: textJustify)),
        DataCell(
            Text('17522251', style: textJustify, textAlign: TextAlign.start)),
        DataCell(
          IconButton(
            icon: Image.asset("assets/group/trash.png"),
            onPressed: () {},
          ),
        )
      ]),
      DataRow(cells: [
        DataCell(Text('2. CARLOS ENRIQUE PENA ALBARRAN', style: textJustify)),
        DataCell(
            Text('17522251', style: textJustify, textAlign: TextAlign.right)),
        DataCell(
          IconButton(
            icon: Image.asset("assets/group/trash.png"),
            onPressed: () {},
          ),
        )
      ])
    ];
  }

  Positioned titulo() {
    return Positioned(
      top: 20,
      left: 45,
      child: Container(
        child: const Text(
          "Agregar grupo",
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
        padding: EdgeInsets.all(5.0),
        child: Text(texto, textAlign: TextAlign.justify, style: textJustify));
  }

  Container texto1(String texto) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Text(
        texto,
        textAlign: TextAlign.justify,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Positioned buttomNext(BuildContext context, Map<String, String> persona) {
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
                        persona, widget.descripcion);
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

  Container buttonAdd(BuildContext context) {
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
                    minimumSize: Size(180, 40),
                    maximumSize: Size(180, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'AGREGAR',
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
  }
}
