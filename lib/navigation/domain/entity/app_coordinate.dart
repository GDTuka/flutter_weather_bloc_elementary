import 'package:elementary_bloc_weather/navigation/domain/entity/coordinate.dart';
import 'package:elementary_bloc_weather/weather/screens/main_screen/main_screen.dart';

class AppCoordinates implements Coordinate {
  static const initScreen = AppCoordinates._('Main');

  final String _value;

  const AppCoordinates._(this._value);

  @override
  String toString() => _value;
}

final Map<AppCoordinates, CoordinateBuilder> appCoordinates = {
  AppCoordinates.initScreen: (_, __) => const MainScreen(),
};
