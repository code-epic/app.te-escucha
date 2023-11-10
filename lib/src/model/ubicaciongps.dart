import 'package:geolocator/geolocator.dart';
import 'package:te_escucha/src/model/const.dart';

// Permite realizar la ubicacion GPS
class UbicacionGPS {
  late Position posicion;
  late double distanceInMeters;

  UbicacionGPS();

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
    //calculateDistance(position.latitude, position.longitude);
  }

  Future<Capitania> calculateDistance(double latitud, double longitud) async {
    for (var i = 0; i < capitania.length; i++) {
      final capitaniasDistancia = Geolocator.distanceBetween(
          latitud, longitud, capitania[i].latitud, capitania[i].longitud);
      capitania[i].metros = capitaniasDistancia;
    }

    capitania.sort((a, b) => a.metros.compareTo(b.metros));

    return Capitania(
        nombre: capitania[0].nombre,
        codigo: 1,
        ubicacion: capitania[0].ubicacion,
        latitud: capitania[0].latitud,
        longitud: capitania[0].longitud,
        metros: 1);
  }
}
