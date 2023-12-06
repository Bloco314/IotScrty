import 'package:flutter/material.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/top_bar.dart';

class HomeCState extends StatelessWidget {
  final String email;
  final String nome;

  HomeCState({required this.email, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCoordenador(email: email, nome: nome, cont: context),
      appBar: TopBar(text: 'Bem-vindo, $nome'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(  
                    foregroundColor: Colors.black,
                    backgroundColor: Color.fromARGB(255, 208, 227, 232)),
                child: const Text('Retorna')),
          ],
        ),
      ),
    );
  }
}
