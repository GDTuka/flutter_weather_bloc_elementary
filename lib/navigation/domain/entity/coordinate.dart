import 'package:flutter/cupertino.dart';

typedef CoordinateBuilder = Widget Function(BuildContext context, Object? data);

abstract class Coordinate {
  final String _value;
  const Coordinate._(this._value);
  @override
  String toString() => _value;
}
