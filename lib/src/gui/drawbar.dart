import 'package:flutter/material.dart';

class DrawBar extends StatefulWidget {
  const DrawBar({super.key});

  @override
  State<DrawBar> createState() => _DrawBarState();
}

class _DrawBarState extends State<DrawBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color.fromARGB(255, 243, 242, 242),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Espacios Acuaticos',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              accountEmail: Text(
                'soporte@inea.gob.ve',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Color(0xff174076),
                  child: ClipOval(
                    child: Image(
                      image: AssetImage('assets/group/logo_inea.png'),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  )),
              decoration: BoxDecoration(
                color: Color(0xff174076),
                // image: DecorationImage(
                //   image: AssetImage('assets/images/fondo.jpg'),
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            ListTile(
              textColor: Color(0xff174076),
              iconColor: Color(0xff174076),
              leading: const Icon(Icons.home),
              title: const Text(
                "Principal",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Color(0xff174076),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {Navigator.pushNamed(context, '/')},
            ),
            ListTile(
              textColor: Color(0xff174076),
              iconColor: Color(0xff174076),
              leading: const Icon(Icons.add_comment_sharp),
              title: const Text(
                "Bases legales",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Color(0xff174076),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {Navigator.pushNamed(context, '/baselegal')},
            ),
            ListTile(
              textColor: Color(0xff174076),
              iconColor: Color(0xff174076),
              leading: const Icon(Icons.person_3_sharp),
              title: const Text(
                "Notificaciones",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Color(0xff174076),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {Navigator.pushNamed(context, '/tramites')},
            ),
            ListTile(
              textColor: Color(0xff174076),
              iconColor: Color(0xff174076),
              leading: const Icon(Icons.person_3_sharp),
              title: const Text(
                "Encuestas",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Color(0xff174076),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {Navigator.pushNamed(context, '/tramites')},
            ),
            const Divider(),
            ListTile(
              textColor: Color(0xff174076),
              iconColor: Color(0xff174076),
              leading: const Icon(Icons.person_3_sharp),
              title: const Text(
                "ChatBot",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Color(0xff174076),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {Navigator.pushNamed(context, '/tramites')},
            ),
            ListTile(
              textColor: Color(0xff174076),
              iconColor: Color(0xff174076),
              leading: const Icon(Icons.person_3_sharp),
              title: const Text(
                "Politicas de Privacidad",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Color(0xff174076),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {Navigator.pushNamed(context, '/politicas')},
            ),
            ListTile(
              textColor: Color(0xff174076),
              iconColor: Color(0xff174076),
              leading: const Icon(Icons.person_3_sharp),
              title: const Text(
                "Ayuda",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Color(0xff174076),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {Navigator.pushNamed(context, '/tramites')},
            ),
            ListTile(
              textColor: Colors.red,
              iconColor: Colors.red,
              leading: const Icon(Icons.logout_outlined),
              title: const Text(
                "Salir",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {Navigator.pushNamed(context, '/login')},
            ),
          ],
        ));
    ;
  }
}