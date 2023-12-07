import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/navigation_bar.dart';

class Solicitacoes extends StatelessWidget {
  final String nome;
  final String email;

  Solicitacoes({required this.email, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarCoordenador(
            email: email,
            nome: nome,
            cont: context,
            pageName: 'solicitacoes'),
        appBar: AppBar(
          title: const Text('Solicitações'),
          backgroundColor: PersonalColors.primaryGreen,
        ),
        body: Container());
  }
}
