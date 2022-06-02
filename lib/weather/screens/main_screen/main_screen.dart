import 'package:elementary/elementary.dart';
import 'package:elementary_bloc_weather/data/models/weather_model_current.dart';
import 'package:elementary_bloc_weather/weather/screens/main_screen/main_screen_widget_model.dart';
import 'package:flutter/material.dart';

class MainScreen extends ElementaryWidget<MainScreenWidgetModel> {
  const MainScreen({Key? key, WidgetModelFactory wmFactory = mainScreenWidgetModelFactory}) : super(wmFactory, key: key);

  @override
  Widget build(MainScreenWidgetModel wm) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hello world"),
        ),
        body: EntityStateNotifierBuilder<MainWeather>(
          listenableEntityState: wm.mainWeatherEntityState,
          loadingBuilder: (context, _) {
            return const _LoadingWidget();
          },
          errorBuilder: (context, _, __) {
            return const _ErrorWidget();
          },
          builder: (context, data) {
            return _WeatherWidget(
              weather: wm.weather,
            );
          },
        ));
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _WeatherWidget extends StatelessWidget {
  const _WeatherWidget({Key? key, required this.weather}) : super(key: key);
  final MainWeather weather;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(weather.name),
    );
  }
}
