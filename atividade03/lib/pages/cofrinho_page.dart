import 'package:flutter/material.dart';

class CofrinhoPage extends StatefulWidget {
  @override
  _CofrinhoPageState createState() => _CofrinhoPageState();
}

class _CofrinhoPageState extends State<CofrinhoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _valorController = TextEditingController();
  double _totalCofrinho = 0.0;
  List<double> _valoresAdicionados = [];

  void _adicionarDinheiro() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        double valor = double.parse(_valorController.text);
        _totalCofrinho += valor;
        _valoresAdicionados.add(valor);
        _valorController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Cofrinho'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Total no Cofrinho: R\$ $_totalCofrinho',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _valorController,
                decoration: InputDecoration(
                  labelText: 'Valor a adicionar',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um valor';
                  } else if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Insira um valor válido';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarDinheiro,
              child: Text('Adicionar ao Cofrinho'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _valoresAdicionados.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        'Valor Adicionado: R\$ ${_valoresAdicionados[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
