import 'package:elementary_bloc_weather/navigation/domain/entity/coordinate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../entity/app_coordinate.dart';

class AppRouteInformationParser extends RouteInformationParser<Coordinate> {
  @override
  Future<Coordinate> parseRouteInformation(RouteInformation routeInformation) => SynchronousFuture(AppCoordinates.initScreen);
}
