import 'package:flutter02/domain/entity.dart';

class Client extends Entity {
  final String _name;

  Client(this._name);

  String getName() {
    return _name;
  }
}
