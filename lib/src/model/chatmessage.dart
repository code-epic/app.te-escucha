import 'package:flutter/material.dart';

enum ChatType { audio, text, image }

enum ChatStatus { no_enviado, no_visto, visto }

class ChatMessage {
  final String text;
  final ChatType type;
  final ChatStatus status;
  final bool isAuthor;

  ChatMessage(
      {required this.text,
      required this.type,
      required this.status,
      required this.isAuthor});
}

List demageChat = [
  ChatMessage(
      text: "Bienvenidos al ChatBoot",
      type: ChatType.text,
      status: ChatStatus.visto,
      isAuthor: true),
  ChatMessage(
      text: "Estoy interesado en la ubicacion",
      type: ChatType.text,
      status: ChatStatus.no_enviado,
      isAuthor: false),
  ChatMessage(
      text: "Que es el inea",
      type: ChatType.text,
      status: ChatStatus.no_visto,
      isAuthor: false),
];

class Chat extends StatelessWidget {
  const Chat({super.key, required this.chat});
  final ChatMessage chat;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            chat.isAuthor ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(30)),
              child: Text(chat.text))
        ]);
  }
}
