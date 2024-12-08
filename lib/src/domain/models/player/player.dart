import 'package:chess_versus/src/domain/value_objects/name.dart';
import 'package:uuid/uuid.dart';

class Player {
  /// id of the player
  final String _id;

  /// name of the player
  Name _name;

  Player({required String? id, required String name})
      : _id = id ?? const Uuid().v4(),
        _name = Name(name);

  String get id => _id;
  String get name => _name.toString();

  void setName(String name) => _name = Name(name);
}
