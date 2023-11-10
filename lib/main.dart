import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:te_escucha/src/model/const.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCUGHiFdbR9u6tAcIDieJuOodLKa6RPbGA',
          appId: '1:334220154678:web:8d62e84539db47866c4597',
          messagingSenderId: '334220154678',
          projectId: 'inea-875c7'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inea te escucha',
      debugShowCheckedModeBanner: false,
      routes: routers,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'), // Spanish
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const Login(),
    );
  }
}
