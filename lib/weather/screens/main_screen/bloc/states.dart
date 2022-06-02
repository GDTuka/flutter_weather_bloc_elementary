import 'package:elementary_bloc_weather/data/models/weather_model_current.dart';

abstract class MainStates {}

class LoadingState extends MainStates {}

class WeatherLoaded extends MainStates {
  MainWeather weather;
  WeatherLoaded(this.weather);
}

class GetAccessState extends MainStates {}

class ErrorState extends MainStates {
  String error;
  ErrorState(this.error);
}
