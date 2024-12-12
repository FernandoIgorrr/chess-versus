import 'package:chess_versus/src/domain/value_objects/value_object.dart';

class Score extends ValueObject {
  final double _value;

  Score(this._value);

  @override
  String? validator([Object? obj]) {
    if (_value < 0.0) {
      return 'Score can\'t be negative';
    }
    return null;
  }

  @override
  String toString() => _value.toString();

  double get toDouble => _value;
}
