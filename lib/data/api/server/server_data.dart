import 'package:elementary_bloc_weather/data/api/geo/geo_api.dart';
import 'package:http/http.dart' as http;

class Server {
  Future<String> _getLink() async {
    String key = "f4876622e673d6c0aa105651ec54576c";
    GeoApi geoApi = GeoApi();
    List<double> latLon = await geoApi.getCoords();
    return "https://api.openweathermap.org/data/2.5/weather?lat=${latLon[0]}&lon=${latLon[1]}&appid=$key";
  }

  Future<String> getData() async {
    http.Response response;
    response = await http.post(Uri.parse(await _getLink()));
    return response.body;
  }
}
