// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:te_escucha/src/gui/chat.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'package:te_escucha/src/gui/make_report.dart';
import 'package:te_escucha/src/model/localstoragehelper.dart';
// import 'package:te_escucha/src/gui/make_report.dart';
import 'package:te_escucha/src/model/logingoogle.dart';

// import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:te_escucha/src/model/cehttpclient.dart';
// import 'package:te_escucha/src/model/chatmessage.dart';

// import 'package:geolocator/geolocator.dart';

// import '../model/const.dart';
// import '../model/solicitud.dart';

// final credentials = auth.ServiceAccountCredentials.fromJson({
//   "private_key_id": ...,
//   "private_key": ...,
//   "client_email": ...,
//   "client_id": ...,
//   "type": "service_account"
// });

// final scopes = ['https://www.googleapis.com/auth/drive'];

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  // late Position _position;
  // late double distanceInMeters;
  // String strCapitania = "-----";
  late bool btnLogin = false;

  // List<dynamic> lst = [];

  // late Capitania xCapitania;

  // _getCurrentLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   setState(() {
  //     _position = position;
  //     calculateDistance(position.latitude, position.longitude);
  //   });
  // }

  // Future calculateDistance(double latitud, double longitud) async {
  //   for (var i = 0; i < capitania.length; i++) {
  //     final capitaniasDistancia = Geolocator.distanceBetween(
  //         latitud, longitud, capitania[i].latitud, capitania[i].longitud);
  //     capitania[i].metros = capitaniasDistancia;
  //   }

  //   capitania.sort((a, b) => a.metros.compareTo(b.metros));

  //   xCapitania = Capitania(
  //       nombre: capitania[0].nombre,
  //       codigo: 1,
  //       ubicacion: capitania[0].ubicacion,
  //       latitud: capitania[0].latitud,
  //       longitud: capitania[0].longitud,
  //       metros: 1);
  //   print(xCapitania.nombre);
  // }

  @override
  void initState() {
    super.initState();
    btnLogin = false;
    // print(LocalStorageHelper().getValue('token_wkf_inea'));
    if (LocalStorageHelper().getValue('token_wkf_inea') != null) {
      btnLogin = true;
      //const Home();
      // LocalStorageHelper().setValue("token_wkf_inea", "testing");
    }
  }

  @override
  Widget build(BuildContext context) {
    // double ancho = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/group/fondo_app.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            logoInea(),
            SizedBox(
              height: 50,
            ),
            centro(context),
            SizedBox(
              height: 80,
            ),
            // GestureDetector(
            //   child: centro(context),
            //   onTap: () {
            //     homePage();
            //   },
            // ),

            // Image(
            //   alignment: Alignment.bottomRight,
            //   image: AssetImage('assets/group/comprometidos.png'),
            // ),
            Container(
              // width: ancho - 100,
              alignment: Alignment.bottomCenter,
              height: 200,
              child: Image(
                alignment: Alignment.bottomRight,
                image: AssetImage('assets/group/comprometidos.png'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container logoInea() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // const Image(
            //   image: AssetImage("assets/group/inea.png"),
            //   width: 58,
            // ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 80,
            ),
            GestureDetector(
              child: Image(
                image: AssetImage("assets/group/sobre.png"),
                width: 30,
              ),
              onTap: () {
                homePage();
              },
            )
          ],
        ));
  }

  Column centro(BuildContext context) {
    return Column(
      children: [
        const Image(
          image: AssetImage("assets/group/logo_app.png"),
          width: 140,
        ),
        const SizedBox(
          height: 30,
        ),
        Visibility(visible: btnLogin, child: buttomNext(context)),
        Visibility(visible: !btnLogin, child: buttomNextGoogle(context))
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
                    minimumSize: Size(150, 40),
                    maximumSize: Size(150, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () {
                    homePage();
                  },
                  child: const Text(
                    'Crear Reporte',
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

  SizedBox buttomNextGoogle(BuildContext context) {
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
                    minimumSize: Size(150, 40),
                    maximumSize: Size(150, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () {
                    LoginGoogle()
                        .singInWithGoogle()
                        .then((value) => {homePage()});

                    // localStorage().setValue("token_wkf_inea", data)

                    //  print(data), print(data.user)})
                    // .error((err) => {btnLogin = false});
                  },
                  child: const Row(
                    children: [
                      Image(
                        image: AssetImage('assets/group/google.png'),
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        'Iniciar sesión',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }

  void homePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MakeReport()),
    );
  }
}
