import 'package:elementary_bloc_weather/app/di/app_scope.dart';
import 'package:elementary_bloc_weather/common/di_scope.dart';
import 'package:elementary_bloc_weather/navigation/domain/delegate/app_router_delegate.dart';
import 'package:elementary_bloc_weather/navigation/domain/entity/app_coordinate.dart';
import 'package:elementary_bloc_weather/navigation/domain/parser/app_route_informantion_parser.dart';
import 'package:elementary_bloc_weather/navigation/services/coordinator.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late IAppScope _scope;

  @override
  void initState() {
    _scope = AppScope();
    super.initState();
    _setUpRouting(_scope.coordinator);
  }

  @override
  Widget build(BuildContext context) {
    return DiScope<IAppScope>(
        factory: () {
          return _scope;
        },
        child: MaterialApp.router(
          routeInformationParser: AppRouteInformationParser(),
          routerDelegate: AppRouterDelegate(_scope.coordinator),
        ));
  }

  void _setUpRouting(Coordinator coordinator) {
    coordinator
      ..initialCoordinate = AppCoordinates.initScreen
      ..registerCoordinates('/', appCoordinates);
  }
}
