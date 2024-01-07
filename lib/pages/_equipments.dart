import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/table_elements.dart';
import 'package:iot_scrty/components/top_bar.dart';

class ViewEquipment extends StatefulWidget {
  final String nome;
  final String email;

  ViewEquipment({required this.email, required this.nome});

  @override
  Equipments createState() => Equipments(nome: nome, email: email);
}

class Equipments extends State<ViewEquipment> {
  final List<List<String>> dados = List.generate(
      20, (index) => ['Equipamento ${index + 1}', 'Ambiente ${index + 1}']);

  final String nome;
  final String email;

  int currentPage = 0;
  static const int itemsPerPage = 5;

  List<String> get currentData {
    int startIndex = currentPage * itemsPerPage;
    int endIndex = (currentPage + 1) * itemsPerPage;
    return dados
        .map((e) => e[0])
        .toList()
        .sublist(startIndex, endIndex.clamp(0, dados.length));
  }

  void nextPage() {
    setState(() {
      currentPage =
          (currentPage + 1).clamp(0, (dados.length / itemsPerPage).ceil() - 1);
    });
  }

  void previousPage() {
    setState(() {
      currentPage =
          (currentPage - 1).clamp(0, (dados.length / itemsPerPage).ceil() - 1);
    });
  }

  void navigateTo(context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  Equipments({required this.nome, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarCoordenador(
            email: email,
            nome: nome,
            cont: context,
            pageName: 'cadastrar_equipamentos'),
        appBar: TopBar(text: 'Equipamentos'),
        body: Column(children: [
          //Conteudo da tabela
          DefaultTable(
              headerTexts: const ['Nome', 'Ambiente associado', 'Editar'],
              items: currentData,
              secItems: dados.map((e) => e[1]).toList(),
              actions: [(context, index) => null],
              icones: const [Icons.edit]),
          // Botões de navegação
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: currentPage > 0 ? previousPage : null,
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          disabledBackgroundColor: Colors.transparent,
                          foregroundColor: PersonalColors.darkerGreen,
                          shape: const LinearBorder()),
                      child: const Row(children: [
                        Icon(Icons.arrow_back),
                        Text('Anterior'),
                      ])),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed:
                        currentPage < (dados.length / itemsPerPage).ceil() - 1
                            ? nextPage
                            : null,
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        disabledBackgroundColor: Colors.transparent,
                        foregroundColor: PersonalColors.darkerGreen,
                        shape: const LinearBorder()),
                    child: const Row(
                        children: [Text('Próximo'), Icon(Icons.arrow_forward)]),
                  )
                ],
              )),
          // Botão para novo Equipamento
          PrimaryButton(
            text: 'Novo ',
            width: 110,
            height: 40,
            onPressed: () => null,
            icon: Icons.add_sharp,
          )
        ]));
  }
}
