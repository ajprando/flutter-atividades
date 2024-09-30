import 'package:flutter02/domain/client.dart';
import 'package:flutter02/domain/entity.dart';

class BankAccount extends Entity {
  int _balance = 0;
  late final Client _client;

  BankAccount(Client client) {
    _client = client;
  }

  getBalance() {
    return _balance;
  }

  Client getClient() {
    return _client;
  }

  void withdraw(int quantity) {
    if (_balance - quantity < 0) throw Error();
    _balance -= quantity;
  }

  void deposit(int quantity) {
    _balance += quantity;
  }
}
