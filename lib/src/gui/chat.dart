import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/model/chatmessage.dart';

class ChatUI extends StatefulWidget {
  const ChatUI({super.key});

  @override
  State<ChatUI> createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
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
                child: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      style: TextStyle(fontFamily: 'lato', fontSize: 13),
                      decoration: InputDecoration(
                          hintText: "Escribe tu pregunta",
                          border: InputBorder.none),
                    )),
                    Icon(
                      Icons.send,
                      color: Colors.indigoAccent,
                    ),
                    SizedBox(
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

  AppBar appBarCode() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xff02509c),
      title: const Row(children: [
        BackButton(),
        CircleAvatar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          backgroundImage: AssetImage("assets/group/marina_avatar.png"),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Inea Te Escucha",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "Servicio Activo",
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
