import 'package:flutter02/domain/entity.dart';

class Repository<T extends Entity> {
  final List<T> _database = [];

  void create(T entity) {
    this._database.add(entity);
  }

  List<T> findAll() {
    return this._database;
  }

  T? findOne(String id) {
    for (var entity in _database) {
      if (entity.getId() == id) {
        return entity;
      }
    }
    return null;
  }

  bool delete(String id) {
    final entity = this.findOne(id);

    if (entity == null) {
      return false;
    }

    this._database.remove(entity);
    return true;
  }
}
