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
      text:
          "Bienvenidos a Inea Te Escucha, tu asistente virtual, soy Marina en que puedo ayudarte",
      type: ChatType.text,
      status: ChatStatus.visto,
      isAuthor: true),
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
              margin: EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.width - 60,
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 9),
              decoration: BoxDecoration(
                  color: chat.isAuthor ? Color(0xff83cacc) : Color(0xffb7c4d5),
                  borderRadius: BorderRadius.circular(10)),
              child: Wrap(
                children: [Text(chat.text)],
              ))
        ]);
  }
}
