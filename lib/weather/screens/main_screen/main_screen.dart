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
            return _ErrorWidget(
              errorMessage: wm.errorMessage,
            );
          },
          builder: (context, data) {
            return _WeatherWidget(
              weather: wm.weather,
              mainImage: wm.mainImage,
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
  const _ErrorWidget({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMessage),
    );
  }
}

class _WeatherWidget extends StatelessWidget {
  const _WeatherWidget({
    Key? key,
    required this.weather,
    required this.mainImage,
  }) : super(key: key);
  final MainWeather weather;
  final AssetImage mainImage;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "Страна : ${weather.sys.country}",
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(margin: const EdgeInsets.only(top: 5), child: Text("Местонахождения : ${weather.name}", style: const TextStyle(fontSize: 20))),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
              width: 150,
              height: 150,
              margin: const EdgeInsets.only(top: 50),
              child: Image(
                image: mainImage,
              )),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  margin: const EdgeInsets.only(left: 7),
                  child: Image.asset("assets/weatherPic/cloud.png"),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 7),
                  child: Text("${weather.clouds.all}%", style: const TextStyle(fontSize: 20)),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 7),
                  width: 25,
                  height: 25,
                  child: Image.asset("assets/weatherPic/wind.png"),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 7),
                  child: Text("${weather.wind.speed}м/c", style: const TextStyle(fontSize: 20)),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 7),
                  width: 25,
                  height: 25,
                  child: Image.asset("assets/weatherPic/visibility.png"),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 7),
                  child: Text("${weather.visibility / 100}%", style: const TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${weather.main.temp}F",
                    style: const TextStyle(fontSize: 70),
                  ),
                ],
              )),
          Column(
            children: [
              InkWell(
                  onTap: () {},
                  child: Center(
                    child: Container(
                        width: 300,
                        height: 50,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(color: Colors.blueAccent, border: Border.all(color: Colors.white, width: 1), borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Посмотреть погоду на 5 дней", style: TextStyle(color: Colors.white, fontSize: 20)),
                              ],
                            )
                          ],
                        )),
                  )),
              InkWell(
                  onTap: () {},
                  child: Center(
                    child: Container(
                        width: 300,
                        height: 50,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(color: Colors.blueAccent, border: Border.all(color: Colors.white, width: 1), borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Поделиться погодой", style: TextStyle(color: Colors.white, fontSize: 20)),
                              ],
                            )
                          ],
                        )),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
