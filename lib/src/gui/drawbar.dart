import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/gui/inicio.dart';
import 'package:te_escucha/src/model/const.dart';
import 'package:te_escucha/src/model/localstoragehelper.dart';
import 'package:te_escucha/src/model/user_perfil.dart';

class DrawBar extends StatefulWidget {
  const DrawBar({super.key});

  @override
  State<DrawBar> createState() => _DrawBarState();
}

class _DrawBarState extends State<DrawBar> {
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
    if (LocalStorageHelper().getValue('token_wkf_inea') == null) {
    } else {
      getCurrentUserEmail().then((value) {
        setState(() {
          Usuario = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color.fromARGB(255, 243, 242, 242),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(Usuario.nombre, style: txtDraw),
              accountEmail: Text(
                Usuario.correo,
                style: txtDraw,
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: const Color(0xff174076),
                  child: ClipOval(
                    child: Usuario.foto != "null"
                        ? Image.network(
                            Usuario.foto,
                            width: 100.0,
                            height: 100.0,
                          )
                        : const Image(
                            image: AssetImage('assets/group/logo_inea.png'),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                  )),
              decoration: const BoxDecoration(
                color: Color(0xff174076),
              ),
            ),
            ListTile(
              textColor: const Color(0xff174076),
              iconColor: const Color(0xff174076),
              leading: const Icon(Icons.home),
              title: const Text(
                "Principal",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Color(0xff174076),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {homePage()},
            ),
            ListTile(
              textColor: const Color(0xff174076),
              iconColor: const Color(0xff174076),
              leading: const Icon(Icons.balance),
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
              textColor: const Color(0xff174076),
              iconColor: const Color(0xff174076),
              leading: const Icon(Icons.notifications_active),
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
              textColor: const Color(0xff174076),
              iconColor: const Color(0xff174076),
              leading: const Icon(Icons.history),
              title: const Text(
                "Historico",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Color(0xff174076),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {Navigator.pushNamed(context, '/historico')},
            ),
            const Divider(),
            ListTile(
              textColor: const Color(0xff174076),
              iconColor: const Color(0xff174076),
              leading: const Icon(Icons.mark_unread_chat_alt),
              title: const Text(
                "Asistente Virtual",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Color(0xff174076),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {Navigator.pushNamed(context, '/tramites')},
            ),
            ListTile(
              textColor: const Color(0xff174076),
              iconColor: const Color(0xff174076),
              leading: const Icon(Icons.policy),
              title: const Text(
                "Políticas de Privacidad",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Color(0xff174076),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {Navigator.pushNamed(context, '/politicas')},
            ),
            // ListTile(
            //   textColor: const Color(0xff174076),
            //   iconColor: const Color(0xff174076),
            //   leading: const Icon(Icons.hearing),
            //   title: const Text(
            //     "Ayuda",
            //     style: TextStyle(
            //         fontSize: 14,
            //         fontFamily: 'Lato',
            //         color: Color(0xff174076),
            //         fontWeight: FontWeight.bold),
            //   ),
            //   onTap: () => {Navigator.pushNamed(context, '/tramites')},
            // ),
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
              onTap: () => {initPage()},
            ),
          ],
        ));
  }

  void homePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  void initPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Inicio()),
    );
  }
}
