import 'package:geolocator/geolocator.dart';

class ErrorHanlder {
  Future<String> geoAccessHandler() async {
    bool isServicesAvaible = await Geolocator.isLocationServiceEnabled();
    if (!isServicesAvaible) {
      return "Геолокация недоступна";
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return "Нет разрешения на геолоакцию";
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return "Невозможно получить разрешение на геологацию";
    }
    return "NoError";
  }

  Future<bool> serverHandler() async {
    return false;
  }
}
