import 'package:geolocator/geolocator.dart';

abstract class Geo {
  Future<List<double>> getCoords();
}

class GeoApi extends Geo {
  @override
  Future<List<double>> getCoords() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return [position.latitude, position.longitude];
  }
}
