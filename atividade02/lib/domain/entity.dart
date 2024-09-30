import 'package:uuid/uuid.dart';

class Entity {
  late final String _id;

  Entity() {
    _id = Uuid().v4();
  }

  String getId() {
    return _id;
  }
}
