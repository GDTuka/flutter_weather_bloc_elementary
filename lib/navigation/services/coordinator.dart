import 'package:elementary_bloc_weather/navigation/domain/entity/coordinate.dart';
import 'package:elementary_bloc_weather/weather/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class Coordinator extends ChangeNotifier {
  final _coordinates = <Coordinate, _Route>{};

  final _pages = [const MaterialPage<void>(key: ValueKey('init'), name: '/init', child: MainScreen())];

  /// Initial screens coordinates.
  Coordinate? initialCoordinate;

  /// Coordinate list.
  Map<Coordinate, _Route> get coordinates => _coordinates;

  /// [Page]s list.
  List<Page> get pages => List.of(_pages);

  /// Initial screens route.
  String? get initialRoute => _coordinates[initialCoordinate]?.path;

  /// Method for registering new coordinate.
  void registerCoordinates(
    String name,
    Map<Coordinate, CoordinateBuilder> coordinates,
  ) {
    _coordinates.addEntries(
      coordinates.entries.map(
        (entry) => MapEntry(
          entry.key,
          _Route('$name${entry.key}', entry.value),
        ),
      ),
    );
  }

  /// Main method for navigation.
  void navigate(
    BuildContext context,
    Coordinate target, {
    Object? arguments,
    bool replaceCurrentCoordinate = false,
    bool replaceRootCoordinate = false,
  }) {
    final path = _coordinates[target]?.path;

    if (replaceRootCoordinate) {
      _pages.clear();
    } else if (replaceCurrentCoordinate) {
      _pages.removeLast();
    }
    _pages.add(_buildMaterialPage(context, target, arguments, path));

    debugPrint(_pages.map((e) => e.name).toList().toString());

    notifyListeners();
  }

  void pop() {
    assert(_pages.isNotEmpty);

    _pages.removeLast();

    debugPrint(_pages.map((e) => e.name).toList().toString());

    notifyListeners();
  }

  /// Method for deleting all routes except the first.
  void popUntilRoot() {
    assert(_pages.isNotEmpty);

    _pages.removeRange(1, _pages.length);

    debugPrint(_pages.map((e) => e.name).toList().toString());

    notifyListeners();
  }

  void replaceUntilRoot(
    BuildContext context,
    Coordinate target, {
    Object? arguments,
  }) {
    assert(_pages.isNotEmpty);
    final path = _coordinates[target]?.path;

    _pages
      ..removeRange(1, _pages.length)
      ..add(_buildMaterialPage(context, target, arguments, path));

    debugPrint(_pages.map((e) => e.name).toList().toString());

    notifyListeners();
  }

  MaterialPage<void> _buildMaterialPage(
    BuildContext context,
    Coordinate coordinate,
    Object? arguments,
    String? path,
  ) {
    final body = _coordinates[coordinate]!.builder.call(
          context,
          arguments,
        );

    return MaterialPage<void>(
      key: ValueKey(path),
      name: path,
      child: Scaffold(
        body: body,
      ),
      arguments: arguments,
    );
  }
}

class _Route {
  final String path;
  final CoordinateBuilder builder;
  const _Route(this.path, this.builder);
}
