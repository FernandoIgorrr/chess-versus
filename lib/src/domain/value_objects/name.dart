import 'value_object.dart';

class Name implements ValueObject {
  final String _value;

  Name(this._value);

  @override
  String? validator([Object? obj]) {
    if (_value.isEmpty) {
      return 'Name can\'t be empty';
    } else if (_value == 'bye') {
      return 'Name can\'t be bye';
    }
    return null;
  }

  @override
  String toString() => _value;
}
