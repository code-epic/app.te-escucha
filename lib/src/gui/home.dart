import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/cbuzon.dart';
import 'package:te_escucha/src/gui/chat.dart';
import 'package:te_escucha/src/gui/chat_home.dart';
import 'package:te_escucha/src/gui/drawbar.dart';
import 'package:te_escucha/src/gui/make_report.dart';
import 'package:te_escucha/src/gui/map_google.dart';
import 'package:te_escucha/src/gui/perfil.dart';
import 'package:te_escucha/src/model/buzon.dart';
import 'package:te_escucha/src/model/cehttpclient.dart';
import 'package:te_escucha/src/model/const.dart';
import 'package:te_escucha/src/gui/inicio.dart';
import 'package:te_escucha/src/model/localstoragehelper.dart';
import 'package:te_escucha/src/model/logingoogle.dart';
import 'package:te_escucha/src/model/user_perfil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Buzon> lst = [];
  late UserPerfil Usuario = UserPerfil(
      cedula: '',
      nombre: '',
      correo: '',
      foto: '',
      telefono: '',
      direccion: '');

  Future<List<Buzon>> getDocWKF(String correo) async {
    Map<String, dynamic> data = {
      'funcion': 'WKF_CDocumentoRemitente',
      'parametros': correo,
      'valores': ''
    };
    var response = await CeHttpClient.xPOST(sPath, data);
    var json = jsonDecode(response);
    var datos = json['Cuerpo'];
    List<Buzon> registro = [];

    for (var e in datos) {
      registro.add(Buzon.fromJson(e));
    }
    return registro;
  }

  @override
  void initState() {
    super.initState();
    // btnLogin = false;
    // print(LocalStorageHelper().getValue('token_wkf_inea'));
    if (LocalStorageHelper().getValue('token_wkf_inea') == null) {
      initPage();
    } else {
      LoginGoogle().getCurrentUserEmail().then((value) {
        setState(() {
          Usuario = value;

          getDocWKF(Usuario.correo).then((value) {
            setState(() {
              lst.addAll(value);
            });
          });
        });
      });
    }
  }

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
              chatBot();
            },
          ),
          IconButton(
            tooltip: "Perfil",
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              pefilPage();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              initPage();
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
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/group/fondo_baselegal.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding:
              const EdgeInsets.only(top: 80, left: 10, right: 10, bottom: 80),
          itemCount: lst.length,
          itemBuilder: ((context, index) => CBuzon(
              codigo: lst[index].codigo,
              titulo: lst[index].tipo,
              contenido: lst[index].contenido,
              status: lst[index].estatus,
              correo: Usuario.correo,
              icono: lst[index].icono,
              fecha: lst[index].fecha,
              respuesta: lst[index].respuesta,
              categoria: lst[index].categoria,
              txtStatus: lst[index].txtEstatus,
              fondo: lst[index].txtEstatus == "Cerrado"
                  ? Color(0xFFD7D8DA)
                  : Color(0xFFE6E8EB),
              border: Color(0xFF83ABCC),
              img: lst[index].imagen))),
    );
  }

  Column centro(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage("assets/group/chatbot.png"),
          width: 300,
        ),
      ],
    );
  }

  void initPage() {
    Navigator.pop(
      context,
      MaterialPageRoute(builder: (context) => const Inicio()),
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

  void pefilPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Perfil()),
    );
  }
}
