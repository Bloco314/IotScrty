import 'package:flutter/material.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/table_elements.dart';
import 'package:iot_scrty/components/top_bar.dart';

class Horarios extends StatelessWidget {
  final List<List<String>> horariosLocais = [
    ['10:50 - 11:40', 'Sala 1'],
    ['11:40 - 12:30', 'Sala 2']
  ];

  Horarios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarProfessor(cont: context, pageName: 'Horarios'),
        appBar: const TopBar(text: 'Horarios'),
        body: DefaultTable(items: horariosLocais, iconActions: const []));
  }
}
