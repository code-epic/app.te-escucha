import 'package:animated_text_kit/animated_text_kit.dart';
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
              margin: const EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.width - 60,
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
              decoration: BoxDecoration(
                  color: chat.isAuthor ? const Color(0xff83cacc) : const Color(0xffb7c4d5),
                  borderRadius: BorderRadius.circular(10)),
              child: Wrap(
                children: [
                  chat.isAuthor
                      ? AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              chat.text,
                              textStyle: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.normal,
                              ),
                              speed: const Duration(milliseconds: 50),
                            ),
                          ],
                          totalRepeatCount: 1,
                          pause: const Duration(milliseconds: 1000),
                          displayFullTextOnTap: true,
                          stopPauseOnTap: true,
                        )
                      : Text(
                          chat.text,
                          style: const TextStyle(fontSize: 11.5),
                        )
                ],
              ))
        ]);
  }
}
