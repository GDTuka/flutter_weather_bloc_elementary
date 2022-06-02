import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:elementary_bloc_weather/app/di/app_scope.dart';
import 'package:elementary_bloc_weather/data/models/weather_model_current.dart';
import 'package:elementary_bloc_weather/weather/screens/main_screen/bloc/events.dart';
import 'package:elementary_bloc_weather/weather/screens/main_screen/bloc/states.dart';
import 'package:elementary_bloc_weather/weather/screens/main_screen/main_screen.dart';
import 'package:elementary_bloc_weather/weather/screens/main_screen/main_screen_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

abstract class IMainScreenModel extends IWidgetModel {
  ListenableState<EntityState<MainWeather>> get mainWeatherEntityState;
}

MainScreenWidgetModel mainScreenWidgetModelFactory(BuildContext context) {
  final appDependencies = context.read<IAppScope>();

  final model = MainScreenModel(appDependencies.apiRepository, appDependencies.mainBloc);
  return MainScreenWidgetModel(model: model);
}

class MainScreenWidgetModel extends WidgetModel<MainScreen, MainScreenModel> implements IMainScreenModel {
  final _mainScreenEntityState = EntityStateNotifier<MainWeather>();

  late final StreamSubscription<MainStates> _stateStatusSubscription;
  late final MainWeather weather;
  MainScreenWidgetModel({
    required MainScreenModel model,
  }) : super(model);

  @override
  void initWidgetModel() {
    _stateStatusSubscription = model.mainStateStream.listen(_updateState);
    _updateState(model.currentState);
    loadData();
    super.initWidgetModel();
  }

  @override
  ListenableState<EntityState<MainWeather>> get mainWeatherEntityState => _mainScreenEntityState;

  void _updateState(MainStates state) {
    if (state is LoadingState) {
      _mainScreenEntityState.loading();
    }
    if (state is WeatherLoaded) {
      _mainScreenEntityState.content(state.weather);
      weather = state.weather;
    }
  }

  void loadData() {
    model.mainBloc.add(LoadWeatherEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }
}
