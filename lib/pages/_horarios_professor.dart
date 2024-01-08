import 'package:flutter/material.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/table_elements.dart';
import 'package:iot_scrty/components/top_bar.dart';

class Horarios extends StatelessWidget {
  final String nome;
  final String email;
  //puxar do back
  final List<String> horarios = ['10:50 - 11:40','11:40 - 12:30'];
  final List<String> locais = ['Sala 1','Sala 2'];

  Horarios({required this.email, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarProfessor(
            cont: context, pageName: 'Horarios', nome: nome, email: email),
        appBar: TopBar(text: 'Horarios'),
        body: DefaultTable(
            headerTexts: ['Horarios','Locais'],
            items: horarios,
            secItems: locais,
            actions: [],
            icones: []));
  }
}
