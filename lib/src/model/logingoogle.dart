import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:te_escucha/src/model/localstoragehelper.dart';
import 'package:te_escucha/src/model/user_perfil.dart';

/// The scopes required by this application.
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

class LoginGoogle {
  static const TAG = "LoginGoogle";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignIn googleSignIn = GoogleSignIn(
    // Optional clientId
    clientId:
        '334220154678-7nvfvo343haoum6budgke20reo84qu3k.apps.googleusercontent.com',
    scopes: scopes,
  );

  Future<UserCredential> singInWithGoogle() async {
    // log("${TAG}, signInWithGoogle");
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    // log("${TAG}, signInWithGoogle ${googleSignInAccount!.email}");

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    // UserCredential userCredential =
    //     await _auth.signInWithCredential(credential);

    // return userCredential.user;
    final credencial =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // final jsonResult = credencial.toString();
    // print(credencial.user);
    // print(jsonResult);

    LocalStorageHelper().setValue('token_wkf_inea', credencial.user.toString());

    return credencial;
  }

  // Future<void> handleSignIn() async {
  //   try {
  //     await _googleSignIn.signIn();
  //   } catch (error) {
  //     print(error);
  //   }
  // }

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
}
