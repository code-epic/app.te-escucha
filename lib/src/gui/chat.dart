import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/model/cehttpclient.dart';
import 'package:te_escucha/src/model/chatmessage.dart';
import 'package:te_escucha/src/model/const.dart';

class ChatUI extends StatefulWidget {
  const ChatUI({super.key});

  @override
  State<ChatUI> createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  TextEditingController txtMsj = TextEditingController();

  final ScrollController _controller = ScrollController();
  // This is what you're looking for!
  String txtEstatus = 'Servicio Activo';

  void _scrollDown() {
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      setState(() {
        // Here you can write your code for open new view
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarCode(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/group/papel_tapiz.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: wIBody(context),
        ));
  }

  Column wIBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              controller: _controller,
              itemCount: demageChat.length,
              itemBuilder: ((context, index) => Chat(chat: demageChat[index]))),
        )),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 18,
                    color: Colors.green.shade100)
              ]),
          child: SafeArea(
              child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.messenger_sharp,
                color: Colors.lightBlue.shade100,
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.indigoAccent.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(40)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: txtMsj,
                      onFieldSubmitted: (value) =>
                          {escribirSolicitud(), escribir()},
                      style: const TextStyle(fontFamily: 'lato', fontSize: 13),
                      decoration: const InputDecoration(
                          hintText: "Escribe tu pregunta",
                          border: InputBorder.none),
                    )),
                    GestureDetector(
                      onTap: () {
                        escribirSolicitud();
                        escribir();
                      },
                      child: const Icon(
                        Icons.send,
                        color: Colors.indigoAccent,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ))
            ],
          )),
        )
      ],
    );
  }

  Future<void> escribirSolicitud() async {
    setState(() {
      demageChat.add(ChatMessage(
          text: txtMsj.text,
          type: ChatType.text,
          status: ChatStatus.visto,
          isAuthor: false));
      txtEstatus = 'Escribiendo...';
    });
  }

  Future<void> escribir() async {
    Map<String, dynamic> data = {
      'funcion': '_SYS_CChatBotResponse',
      'parametros': txtMsj.text,
    };
    txtMsj.text = '';
    var response = await CeHttpClient.xPOST(sPath, data);
    var json = jsonDecode(response);
    var respuesta = '';
    var texto =
        'Ups, lo sentimos aun no tengo una respuesta para su pregunta. Intente más tarde.';

    if (json['Cuerpo'].length > 0) {
      respuesta = json['Cuerpo'][0]['respuesta'].toString();
      texto =
          '$respuesta\n\nEspero haberte ayudado, estoy atenta a cualquier otra inquietud. Sigamos construyendo la vía para nuestra Venezuela Azul.';
    }
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      demageChat.add(ChatMessage(
          text: texto,
          type: ChatType.text,
          status: ChatStatus.visto,
          isAuthor: true));
      txtEstatus = 'Servicio Activo';
      _scrollDown();
    });
  }

  AppBar appBarCode() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xff02509c),
      title: Row(children: [
        BackButton(),
        const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          backgroundImage: AssetImage("assets/group/marina_avatar.png"),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Inea Te Escucha",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              txtEstatus,
              style: TextStyle(fontSize: 11),
            )
          ],
        )
      ]),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.home),
          tooltip: "Principal",
          onPressed: () {
            homePage();
          },
        ),
      ],
    );
  }

  Column centro(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage("assets/group/chatbot.png"),
          width: 140,
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  void homePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }
}
