import 'dart:convert';

import 'package:elementary_bloc_weather/data/api/server/server_data.dart';
import 'package:elementary_bloc_weather/data/models/weather_model_current.dart';

class WeatherApi {
  Future<MainWeather> getWeather() async {
    Server _server = Server();
    String weatherStringData = await _server.getData();
    MainWeather weather = MainWeather.fromJson(json.decode(weatherStringData));
    return weather;
  }
}
