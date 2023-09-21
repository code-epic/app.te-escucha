import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/drawbar.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/model/const.dart';

class VerMensaje extends StatefulWidget {
  final String codigo;
  final String contenido;
  final String tipo;
  final String icono;
  final int estatus;
  final String respuesta;
  final String categoria;
  final String img;

  const VerMensaje(
      {super.key,
      required this.codigo,
      required this.contenido,
      required this.tipo,
      required this.estatus,
      required this.icono,
      required this.respuesta,
      required this.categoria,
      required this.img});

  @override
  State<VerMensaje> createState() => _VerMensajeState();
}

class _VerMensajeState extends State<VerMensaje> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedValue = 1;
  String imgMala = "assets/group/posicion.png";
  int mala = 0;
  int buena = 0;
  int excelente = 0;
  int xmala = 0;
  int xbuena = 0;
  int xexcelente = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      drawer: const DrawBar(),
      appBar: AppBar(
        backgroundColor: const Color(0xff174076),
        elevation: 0.0,
        title: Text(
          "Reporte #${widget.codigo}",
          style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.normal),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Color(0xff83cacc),
          ),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: <Widget>[
          Visibility(
            visible: widget.estatus != 3 ? false : true,
            child: IconButton(
              icon: const Icon(Icons.thumb_up),
              tooltip: "De acuerdo",
              onPressed: () {
                mdlOk(context);
              },
            ),
          ),
          Visibility(
            visible: widget.estatus != 3 ? false : true,
            child: IconButton(
              icon: const Icon(Icons.thumb_down),
              tooltip: "En desacuerdo",
              onPressed: () {
                homePage();
              },
            ),
          ),
          Visibility(
            visible: widget.estatus != 3 ? true : false,
            child: IconButton(
              icon: const Icon(Icons.home),
              tooltip: "Principal",
              onPressed: () {
                homePage();
              },
            ),
          )
        ],
      ),
      body: stackBody(),
    );
  }

  Container stackBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/group/fondo_baselegal.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: [
                Container(
                  height: 60,
                  color: Colors.transparent,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2.0),
                          width: 100,
                          height: 100,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Image(
                                image:
                                    AssetImage('assets/${widget.img}_st.png'),
                              ),
                              Text(
                                widget.codigo,
                                style: textNumber,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            texto1("Tipo de reporte"),
                            texto2(widget.tipo),
                            texto1("Categoría"),
                            texto2(widget.categoria),
                          ],
                        )
                      ],
                    ),
                    const Divider(color: Color(0xff02509c)),
                    texto1("Detalle del reporte"),
                    texto2(widget.contenido.toUpperCase()),
                    const Divider(color: Color(0xff02509c)),
                    texto1("Respuesta"),
                    Visibility(
                        visible: widget.estatus > 3 ? false : true,
                        child: texto2(widget.respuesta)),
                    Visibility(
                        visible: widget.estatus < 2 ? true : false,
                        child: texto2('EN PROCESO...')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  void homePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  void changeMala(int selEstatus) {
    setState(() {
      switch (selEstatus) {
        case 1:
          mala = 1;
          break;
        case 2:
          buena = 1;
          break;
        case 3:
          excelente = 1;
          break;
        default:
      }
      Navigator.pop(context);
      mdlOk2(context);
    });
  }

  void changeCalifica(int selEstatus) {
    setState(() {
      switch (selEstatus) {
        case 1:
          xmala = 1;
          break;
        case 2:
          xbuena = 1;
          break;
        case 3:
          xexcelente = 1;
          break;
        default:
      }
      Navigator.pop(context);
      mdlOk3(context);
    });
  }

  Future<String?> mdlOk(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              texto1("¿Cuan satisfecho esta con el servicio prestado?"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          changeMala(1);
                        },
                        child: Image(
                          image: AssetImage(imgMala),
                          width: 48,
                        ),
                      ),
                      const Text('Ninguno', style: textHome)
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          changeMala(2);
                        },
                        child: Image(
                          image: AssetImage(imgMala),
                          width: 48,
                        ),
                      ),
                      const Text('Bueno', style: textHome)
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          changeMala(3);
                        },
                        child: Image(
                          image: AssetImage(imgMala),
                          width: 48,
                        ),
                      ),
                      const Text('Excelente', style: textHome)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> mdlOk2(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 25),
              texto1("¿Cómo califica el tiempo de respuesta?"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          changeCalifica(1);
                        },
                        child: Image(
                          image: AssetImage(imgMala),
                          width: 48,
                        ),
                      ),
                      const Text('Ninguno', style: textHome)
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          changeCalifica(2);
                        },
                        child: Image(
                          image: AssetImage(imgMala),
                          width: 48,
                        ),
                      ),
                      const Text('Bueno', style: textHome)
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          changeCalifica(3);
                        },
                        child: Image(
                          image: AssetImage(imgMala),
                          width: 48,
                        ),
                      ),
                      const Text('Excelente', style: textHome)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> mdlOk3(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 25),
              texto1("Gracias por calificar nuestros servicios"),
              const SizedBox(height: 20),
              ok(context),
            ],
          ),
        ),
      ),
    );
  }

  Container ok(BuildContext context) {
    return Container(
        // width: MediaQuery.of(context).size.width - 60,
        child: Container(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff174076),
                    shadowColor: const Color(0xff174076), // background
                    foregroundColor: Colors.white, // foreground
                    minimumSize: const Size(120, 40),
                    maximumSize: const Size(120, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () {
                    homePage();
                  },
                  child: const Text(
                    'Enviar datos',
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
}
