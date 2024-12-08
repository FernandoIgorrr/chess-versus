import 'value_object.dart';

class TotalNumberOfRounds implements ValueObject {
  final int _value;

  TotalNumberOfRounds(this._value);

  @override
  String? validator([Object? obj]) {
    if (_value < 2) {
      return 'Invalid number of rounds';
    }
    return null;
  }

  @override
  String toString() => _value.toString();
}
