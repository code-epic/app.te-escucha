import 'dart:convert';
import 'dart:ui_web';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/cbuzon.dart';
import 'package:te_escucha/src/gui/chat.dart';
import 'package:te_escucha/src/gui/chat_home.dart';
import 'package:te_escucha/src/gui/drawbar.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/gui/make_report.dart';
import 'package:te_escucha/src/gui/map_google.dart';
import 'package:te_escucha/src/gui/ver_mensaje.dart';
import 'package:te_escucha/src/model/buzon.dart';
import 'package:te_escucha/src/model/cehttpclient.dart';
import 'package:te_escucha/src/model/const.dart';
import 'package:te_escucha/src/gui/inicio.dart';
import 'package:te_escucha/src/model/user_perfil.dart';

import '../model/localstoragehelper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController cedula = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController nombre = TextEditingController();

  TextEditingController telefono = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late UserPerfil Usuario = UserPerfil(
      cedula: '',
      nombre: '',
      correo: '',
      foto: '',
      telefono: '',
      direccion: '');

  Future<UserPerfil> getCurrentUserEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    String? xnombre = user?.displayName;
    String? xcorreo = user?.email;
    String? xfoto = user?.photoURL;

    return UserPerfil(
        cedula: '',
        nombre: xnombre.toString(),
        correo: xcorreo.toString(),
        foto: xfoto.toString(),
        telefono: '',
        direccion: '');
  }

  @override
  void initState() {
    super.initState();
    // btnLogin = false;
    // print(LocalStorageHelper().getValue('token_wkf_inea'));
    if (LocalStorageHelper().getValue('token_wkf_inea') == null) {
      const Inicio();
    } else {
      getCurrentUserEmail().then((value) {
        setState(() {
          Usuario = value;
          nombre.text = Usuario.nombre != 'null' ? Usuario.nombre : '';
          correo.text = Usuario.correo != 'null' ? Usuario.correo : '';
          cedula.text = 'V - ';
          telefono.text = '+58 ';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    double alto = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      drawer: const DrawBar(),
      appBar: AppBar(
        backgroundColor: const Color(0xff174076),
        elevation: 0.0,
        title: const Text(
          "Perfil del usuario",
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
              chatBot();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              homePage();
            },
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: stackBody(),
    );
  }

  Container stackBody() {
    double ancho = MediaQuery.of(context).size.width;
    double alto = MediaQuery.of(context).size.height;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/group/fondo_baselegal.png"),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: (alto / 2) - 250,
          ),
          pictureCenter(context),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            style: xtextPersonal,
            controller: cedula,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              fillColor: Color(0xFFF0F7FC),
              labelText: 'Documento de Identificación (C.I)',
            ),
          ),
          TextFormField(
            style: xtextPersonal,
            controller: nombre,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Nombre completo',
            ),
          ),
          TextFormField(
            style: xtextPersonal,
            enabled: false,
            controller: correo,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Correo Electronico',
            ),
          ),
          TextFormField(
            style: xtextPersonal,
            controller: telefono,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Teléfono principal',
            ),
          ),
          SizedBox(
            height: ((alto / 2) - 220),
          ),
          Container(
            width: 300,
            alignment: Alignment.bottomCenter,
            child: buttomNext(context),
          ),
        ],
      ),
    );
  }

  Column pictureCenter(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 100,
                color: Colors.green.shade100)
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Usuario.foto != "null"
                ? Image.network(
                    Usuario.foto,
                  )
                : const Image(
                    image: AssetImage("assets/group/marina_circulo.png"),
                    width: 100,
                  ),
          ),
        )
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
                    minimumSize: Size(120, 40),
                    maximumSize: Size(120, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Aceptar',
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

  void MapaGoogle() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapGoogle()),
    );
  }

  void homePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
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

  void chatBot() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatHome()),
    );
  }
}
