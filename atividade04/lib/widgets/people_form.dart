import 'package:flutter04/domain/people.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PeopleForm extends StatefulWidget {
  const PeopleForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return PeopleFormState();
  }
}

class PeopleFormState extends State<PeopleForm> {
  final List<People> peoples = [];
  final TextEditingController _peopleNameController = TextEditingController();
  final TextEditingController _peopleAgeController = TextEditingController();
  String? _errorMessage;

  void _updatePeople(People people) {
    TextEditingController nameController =
        TextEditingController(text: people.name);
    TextEditingController ageController =
        TextEditingController(text: people.age.toString());
    String? dialogError;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Editar Pessoa"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(labelText: "Nome"),
                ),
                TextField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: "Idade"),
                ),
                if (dialogError != null)
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      dialogError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                else
                  const SizedBox(
                    height: 20,
                  ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Salvar'),
                onPressed: () {
                  String? name = nameController.text;
                  int? age = int.tryParse(ageController.text);
                  if(name == ""){
                    setState(() {
                      dialogError = "Preencha o campo 'Nome'";
                    });
                    return;
                  }
                  if(age == null){
                    setState(() {
                      dialogError = "Preencha o campo 'Idade'";
                    });
                    return;
                  }
                  setState(() {
                    people.name = name;
                    people.age = age;
                  });
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("Cancelar"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _removePeople(People people) {
    peoples.remove(people);
  }

  void _addPeople() {
    String? name = _peopleNameController.text;
    int? age = int.tryParse(_peopleAgeController.text);
    if (name == "") {
      setState(() {
        _errorMessage = "Preencha o campo 'Nome'";
      });
      return;
    }
    if (age == null) {
      setState(() {
        _errorMessage = "Preencha o campo 'Idade'";
      });
      _peopleAgeController.text = "";
      return;
    }
    setState(() {
      peoples.add(People(name: name, age: age));
      _peopleNameController.clear();
      _peopleAgeController.clear();
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pessoas",
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              width: 500,
              child: Column(
                children: [
                  TextField(
                    controller: _peopleNameController,
                    decoration: const InputDecoration(
                      labelText: "Nome",
                    ),
                  ),
                  TextField(
                    controller: _peopleAgeController,
                    decoration: const InputDecoration(labelText: "Idade"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _addPeople,
                    child: const Row(
                      children: [Icon(Icons.add), Text("Adicinoar Pessoa")],
                    ),
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  else
                    const SizedBox(
                      height: 20,
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 600,
              child: ListView.builder(
                itemCount: peoples.length,
                itemBuilder: (context, index) {
                  People people = peoples[index];
                  return Card(
                    child: SizedBox(
                      width: 300,
                      height: 80,
                      child: ListTile(
                          title: Text(people.name),
                          subtitle: Text("Idade: ${people.age.toString()}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                color: Colors.red,
                                onPressed: () {
                                  setState(() {
                                    _removePeople(people);
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.new_label_rounded),
                                color: Colors.blue,
                                onPressed: () {
                                  _updatePeople(people);
                                },
                              )
                            ],
                          )),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
