import 'package:flutter02/domain/bank_account.dart';
import 'package:flutter02/domain/client.dart';
import 'package:flutter02/repository/memory_repository.dart';
import 'package:test/test.dart';

void main() {
  final clientRepository = Repository<Client>();
  final bankAccountRepository = Repository<BankAccount>();

  test('should create and find a client', () {
    var client = Client('Baraldi');
    clientRepository.create(client);

    var foundClient = clientRepository.findOne(client.getId());

    expect(foundClient, isNotNull);
    expect(foundClient?.getName(), equals('Baraldi'));
  });

  test('should return all clients', () {
    var client1 = Client('Baraldi');
    var client2 = Client('joseph');
    clientRepository.create(client1);
    clientRepository.create(client2);

    var allClients = clientRepository.findAll();

    expect(allClients.length, greaterThanOrEqualTo(2));
  });

  test('should delete a bank account by ID', () {
    var client = Client('Baraldi');
    var bankAccount = BankAccount(client);

    clientRepository.create(client);
    bankAccountRepository.delete(bankAccount.getId());

    var deleted = clientRepository.delete(client.getId());

    expect(deleted, isTrue);
    expect(clientRepository.findOne(client.getId()), isNull);
  });
}
