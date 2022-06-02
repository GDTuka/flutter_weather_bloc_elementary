import 'package:bloc/bloc.dart';
import 'package:elementary_bloc_weather/data/api/repository.dart';
import 'package:elementary_bloc_weather/data/models/weather_model_current.dart';
import 'package:elementary_bloc_weather/weather/screens/main_screen/bloc/events.dart';
import 'package:elementary_bloc_weather/weather/screens/main_screen/bloc/states.dart';

class MainBloc extends Bloc<MainEvents, MainStates> {
  MainBloc({required this.apiRepository}) : super(LoadingState()) {
    on<LoadWeatherEvent>(_loadWeatherData);
  }
  final ApiRepository apiRepository;

  Future<void> _loadWeatherData(LoadWeatherEvent event, Emitter emit) async {
    emit(LoadingState());
    if (await _geoAccsess(emit)) {
      MainWeather weather = await apiRepository.getWeather();
      emit(WeatherLoaded(weather));
    }
  }

  Future<bool> _geoAccsess(Emitter emit) async {
    String result = await apiRepository.geoAccsess();
    if (result == "Геолокация недоступна") {
      emit(ErrorState(result));
      return false;
    }
    if (result == "Нет разрешения на геолоакцию") {
      emit(ErrorState(result));
      return false;
    }
    if (result == "Невозможно получить разрешение на геологацию") {
      emit(ErrorState(result));
      return false;
    }
    return true;
  }
}
