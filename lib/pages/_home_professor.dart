import 'package:flutter/material.dart';
import 'package:iot_scrty/components/navigatio_bar.dart';
import 'package:iot_scrty/components/top_bar.dart';

class HomePState extends StatelessWidget {
  final String email;
  final String nome;

  HomePState({required this.email, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarProfessor(email: email, nome: nome, cont: context),
      appBar: TopBar(text: nome),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(child: Text("Home sweet home")),
      ),
    );
  }
}
