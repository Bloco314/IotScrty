import 'package:flutter/material.dart';
import 'package:iot_scrty/components/navigation_bar.dart';

class HomeCState extends StatelessWidget {
  final String email;
  final String nome;

  HomeCState({required this.email, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCoordenador(email: email, nome: nome),
      appBar: AppBar(
        title: Text("Bem-vindo $nome"),
        backgroundColor: const Color.fromRGBO(74, 188, 216, 1),
      ),
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
                    backgroundColor: const Color.fromRGBO(74, 188, 216, 1)),
                child: const Text('Retorna')),
          ],
        ),
      ),
    );
  }
}
