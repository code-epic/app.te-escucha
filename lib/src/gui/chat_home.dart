
import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/chat.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/gui/make_report.dart';

import 'package:geolocator/geolocator.dart';

import '../model/const.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  late Position _position;
  late double distanceInMeters;
  String strCapitania = "-----";

  late Capitania xCapitania;

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _position = position;
      calculateDistance(position.latitude, position.longitude);
    });
  }

  Future calculateDistance(double latitud, double longitud) async {
    for (var i = 0; i < capitania.length; i++) {
      final capitaniasDistancia = Geolocator.distanceBetween(
          latitud, longitud, capitania[i].latitud, capitania[i].longitud);
      capitania[i].metros = capitaniasDistancia;
    }

    capitania.sort((a, b) => a.metros.compareTo(b.metros));

    xCapitania = Capitania(
        nombre: capitania[0].nombre,
        codigo: 1,
        ubicacion: capitania[0].ubicacion,
        latitud: capitania[0].latitud,
        longitud: capitania[0].longitud,
        metros: 1);
    print(xCapitania.nombre);
  }

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();

    //calculateDistance();
  }

  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    double alto = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/group/papel_marina.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            logoInea(),
            SizedBox(
              height: (alto / 2) - 220,
            ),
            GestureDetector(
              child: centro(context),
              onTap: () => {chatPage()},
            ),
            Container(
              // width: ancho - 100,
              alignment: Alignment.bottomCenter,
              child: const Image(
                width: 200,
                alignment: Alignment.bottomRight,
                image: AssetImage('assets/group/titulo_chatbot.png'),
              ),
            ),
            buttomNext(context),
            SizedBox(
              height: ((alto / 2) - 180),
            ),
            Container(
              width: 300,
              alignment: Alignment.bottomCenter,
              child: const Image(
                alignment: Alignment.bottomRight,
                image: AssetImage('assets/group/bottom_chatbot.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container logoInea() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: const Row(
          children: [
            Image(
              image: AssetImage("assets/group/te_escucha_chatbot.png"),
              width: 120,
            ),
          ],
        ));
  }

  Column centro(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage("assets/group/marina_circulo.png"),
          width: 150,
        ),
      ],
    );
  }

  SizedBox buttomNext(BuildContext context) {
    return SizedBox(
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
                    minimumSize: const Size(150, 40),
                    maximumSize: const Size(150, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () {
                    chatPage();
                  },
                  child: const Text(
                    'Chatear',
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

  void ChatBot() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatHome()),
    );
  }

  void nextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MakeReport()),
    );
  }

  void homePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  void chatPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatUI()),
    );
  }
}
