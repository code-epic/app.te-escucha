import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/chat.dart';
import 'package:te_escucha/src/gui/chat_home.dart';
import 'package:te_escucha/src/gui/drawbar.dart';
import 'package:te_escucha/src/gui/make_report.dart';
import 'package:te_escucha/src/gui/map_google.dart';
import 'package:te_escucha/src/model/cehttpclient.dart';
import 'package:te_escucha/src/model/const.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      drawer: const DrawBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          makeReport();
        },
        label: const Text('Crear reporte'),
        backgroundColor: Color.fromARGB(255, 58, 82, 161),
        icon: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff174076),
        elevation: 0.0,
        title: const Text(
          "Hola, saludos",
          style: TextStyle(
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
          IconButton(
            icon: const Icon(Icons.mark_unread_chat_alt),
            tooltip: "Chatbot",
            onPressed: () {
              ChatBot();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              makeReport();
            },
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: StackBody(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   backgroundColor: Colors.transparent,
      //   child: IconButton(
      //     icon: Image.asset("assets/group/chatbot.png"),
      //     iconSize: 256,
      //     onPressed: () {
      //       Chat();
      //     },
      //   ),
      // ),
    );
  }

  Stack StackBody() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              color: Colors.grey.shade200,
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  LstBuzon(
                      'Capitania de Puertos',
                      'servicios/capitanias',
                      'minenviadomensaje_leido',
                      'Enviado',
                      Color(0xffe7ecf0),
                      Color(0xff174076)),
                  LstBuzon(
                      'CENAVE',
                      'servicios/cenave',
                      'enprocesomensaje_noleido',
                      'En proceso',
                      Color(0xffb7c4d5),
                      Color(0xffb7c4d5)),
                  LstBuzon(
                      'Pilotaje',
                      'servicios/pilotaje',
                      'finalizadoconexitomensaje_noleido',
                      'Finalizado',
                      Color(0xffb7c4d5),
                      Color(0xffb7c4d5)),
                ],
              ),
            ),
            // Container(
            //     width: MediaQuery.of(context).size.width,
            //     padding: EdgeInsets.all(20),
            //     color: Colors.transparent,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //       children: [
            //         GestureDetector(
            //           child: imagen(),
            //           onTap: () {
            //             //obtenerEstados();
            //           },
            //         )
            //       ],
            //     ))
          ],
        ),
        const Positioned(
          top: 13,
          left: 30,
          child: Text(
            "Notificaciones",
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold),
          ),
        ),
        const Positioned(
          top: 10,
          right: 20,
          child: Icon(
            Icons.settings,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Container LstBuzon(String titulo, String img, String status, String txtStatus,
      Color fondo, Color border) {
    return Container(
      padding: const EdgeInsets.all(1.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: fondo,
                border: Border.all(color: border),
              ),
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  width: 100,
                  height: 100,
                  child: Image(
                    image: AssetImage('assets/$img.png'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  width: MediaQuery.of(context).size.width - 210,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$titulo",
                        style: textHome,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Contenido loret ipsun dolore ips contaut laskduwl",
                        style: textDescrip,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Fecha: 23/07/1985",
                        style: textDescrip,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "N. de Reporte 00010000120",
                        style: textHomeNumber,
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                      padding: const EdgeInsets.all(1),
                      width: 52,
                      height: 52,
                      child: Image(
                        image: AssetImage('assets/estatus/$status.png'),
                      ),
                    ),
                    Text(
                      txtStatus,
                      style: textStatus,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ]),
            )
          ]),
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

  SizedBox imagen() {
    return const SizedBox(
      height: 140,
      child: Image(
        image: AssetImage('assets/group/chatbot.png'),
        width: 128,
        height: 128,
      ),
    );
  }

  void MapaGoogle() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapGoogle()),
    );
  }

  void ChatBot() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatHome()),
    );
  }

  void obtenerEstados() async {
    debugPrint("Entrando");
    const Map<String, dynamic> data = {
      'funcion': 'ListarEstados',
      'parametros': ''
    };

    final xdata = await CeHttpClient.xPOST("/v1/api/crud:908888", data);
    print(xdata);
  }

  void makeReport() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MakeReport()),
    );
  }
}
