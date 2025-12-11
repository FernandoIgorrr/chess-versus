import 'value_object.dart';

class TournamentName implements ValueObject {
  final String _value;

  TournamentName(this._value);

  @override
  String? validator([Object? obj]) {
    if (_value.isEmpty) {
      return 'Name can\'t be empty';
    } else if (_value.length >= 35) {
      return 'The name must have fewer than 35 characters';
    }
    return null;
  }

  @override
  String toString() => _value;
}
