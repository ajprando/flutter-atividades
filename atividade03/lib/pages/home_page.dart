import 'package:appbanco/pages/cofrinho_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicação Bancária'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CofrinhoPage()),
            );
          },
          child: Text('Acessar Cofrinho'),
        ),
      ),
    );
  }
}
