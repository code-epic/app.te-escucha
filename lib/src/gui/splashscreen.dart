import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:te_escucha/src/gui/inicio.dart';
import 'package:te_escucha/src/gui/home.dart';

import '../model/localstoragehelper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    if (LocalStorageHelper().getValue('token_wkf_inea') != null) {
      isLoggedIn = true;
      //const Home();
      // LocalStorageHelper().setValue("token_wkf_inea", "testing");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (isLoggedIn) {
            return const Home();
          } else {
            return const Inicio();
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
