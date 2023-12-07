import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/navigatio_bar.dart';

class CadEquip extends StatelessWidget {
final String nome;
  final String email;

  CadEquip({required this.nome, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCoordenador(email: email,nome: nome,cont: context),
      appBar: AppBar(
        title: const Text('Equipamentos'),
        backgroundColor: PersonalColors.primaryGreen,
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
                    backgroundColor: PersonalColors.primaryGreen),
                child: const Text('Retorna')),
          ],
        ),
      ),
    );
  }
}
