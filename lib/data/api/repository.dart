import 'package:elementary_bloc_weather/common/error_hanlder.dart';
import 'package:elementary_bloc_weather/data/api/weather/weather_api.dart';
import 'package:elementary_bloc_weather/data/models/weather_model_current.dart';

class ApiRepository {
  final WeatherApi _weatherApi = WeatherApi();
  final ErrorHanlder _errorHanlder = ErrorHanlder();
  Future<MainWeather> getWeather() async => _weatherApi.getWeather();
  Future<String> geoAccsess() async => _errorHanlder.geoAccessHandler();
}
