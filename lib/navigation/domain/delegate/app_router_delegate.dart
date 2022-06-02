import 'package:elementary_bloc_weather/navigation/domain/entity/coordinate.dart';
import 'package:elementary_bloc_weather/navigation/services/coordinator.dart';
import 'package:flutter/cupertino.dart';

class AppRouterDelegate extends RouterDelegate<Coordinate> with ChangeNotifier, PopNavigatorRouterDelegateMixin<Coordinate> {
  final Coordinator coordinator;

  AppRouterDelegate(this.coordinator) : navigatorKey = GlobalKey<NavigatorState>() {
    coordinator.addListener(notifyListeners);
  }

  @override
  GlobalKey<NavigatorState>? navigatorKey;

  @override
  void dispose() {
    coordinator.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        pages: coordinator.pages,
        onPopPage: (route, Object? result) {
          if (!route.didPop(result)) {
            return false;
          } else {
            coordinator.pop();
            return true;
          }
        });
  }

  @override
  Future<void> setNewRoutePath(Coordinate configuration) async {}
}
