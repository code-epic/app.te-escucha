import 'dart:html';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps/google_maps.dart';
import 'package:te_escucha/src/model/const.dart';
import 'dart:ui' as ui;

class MapGoogle extends StatefulWidget {
  const MapGoogle({super.key});

  @override
  State<MapGoogle> createState() => _MapGoogleState();
}

class _MapGoogleState extends State<MapGoogle> {
  late Position _position;
  late double distanceInMeters;
  String strCapitania = "-----";

  late Capitania xCapitania;

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _position = position;
      calculateDistance(position.latitude, position.longitude);
    });
  }

  Future calculateDistance(double latitud, double longitud) async {
    for (var i = 0; i < capitania.length; i++) {
      final capitaniasDistancia = Geolocator.distanceBetween(
          latitud, longitud, capitania[i].latitud, capitania[i].longitud);
      capitania[i].metros = capitaniasDistancia;
    }

    capitania.sort((a, b) => a.metros.compareTo(b.metros));

    xCapitania = Capitania(
        nombre: capitania[0].nombre,
        codigo: 1,
        ubicacion: capitania[0].ubicacion,
        latitud: capitania[0].latitud,
        longitud: capitania[0].longitud,
        metros: 1);

    // debugPrint(xCapitania as String?);
    print(xCapitania.nombre);
    // print();
    // print(capitania[0].longitud);
    // print(capitania[0].metros);

    // for (var i = 0; i < capitania.length; i++) {
    //   print(capitania[i].nombre);
    //   print(capitania[i].latitud);
    //   print(capitania[i].longitud);
    //   print(capitania[i].metros);
    // }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    //calculateDistance();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff174076),
          elevation: 0.0,
          title: const Text('Inea te escucha - Ubica'),
          // backgroundColor: Colors.green[700],
        ),
        body: getMap(),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }

  Widget getMap() {
    String htmlId = "7";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final myLatlng = LatLng(10.4551088, -66.9111333);

      final mapOptions = MapOptions()
        ..zoom = 10
        ..center = LatLng(10.4551088, -66.9111333);

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = GMap(elem, mapOptions);

      Marker(MarkerOptions()
        ..position = myLatlng
        ..map = map
        ..title = 'Hello World!');

      return elem;
    });

    return HtmlElementView(viewType: htmlId);
  }
}
