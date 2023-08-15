import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:te_escucha/src/gui/chat.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/gui/make_report.dart';
import 'package:te_escucha/src/model/cehttpclient.dart';
import 'package:te_escucha/src/model/chatmessage.dart';

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
    _getCurrentLocation();

    //calculateDistance();
  }

  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/group/fondo_app.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // logoInea(),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: FadeInDown(
                      child: centro(context),
                      duration: Duration(seconds: 10),
                    ),
                    onTap: () {
                      chatPage();
                    },
                  )
                ],
              ),
            ),

            // GestureDetector(
            //   child: SizedBox(
            //     width: ancho - 10,
            //     child: const Image(
            //       image: AssetImage('assets/group/chatbot.png'),
            //       width: 164,
            //       height: 164,
            //       alignment: Alignment.topRight,
            //     ),
            //   ),
            //   onTap: () {
            //     chatPage();
            //   },
            // )
          ],
        ),
      ),
    );
  }

  Column centro(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage("assets/group/chatbot.png"),
          width: 200,
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
                    backgroundColor: Color(0xff174076),
                    shadowColor: Color(0xff174076), // background
                    foregroundColor: Colors.white, // foreground
                    minimumSize: Size(140, 40),
                    maximumSize: Size(140, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () {
                    nextPage();
                  },
                  child: const Text(
                    'Buenas',
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
