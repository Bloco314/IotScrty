import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/navigation_bar.dart';

class CadEquip extends StatelessWidget {
  final String nome;
  final String email;

  CadEquip({required this.nome, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarCoordenador(
            email: email,
            nome: nome,
            cont: context,
            pageName: 'cadastrar_equipamentos'),
        appBar: AppBar(
          title: const Text('Equipamentos'),
          backgroundColor: PersonalColors.primaryGreen,
        ),
        body: Container());
  }
}
