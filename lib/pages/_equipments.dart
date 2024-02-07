import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/table_elements.dart';
import 'package:iot_scrty/components/top_bar.dart';

class ViewEquipment extends StatefulWidget {
  final String nome;
  final String email;

  const ViewEquipment({super.key, required this.email, required this.nome});

  @override
  Equipments createState() => Equipments();
}

class Equipments extends State<ViewEquipment> {
  final List<List<String>> dados = [
    ['nome', 'ambiente'],
    ['eq1', 'abc'],
    ['eq2', 'bca']
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarCoordenador(
            email: widget.email,
            nome: widget.nome,
            cont: context,
            pageName: 'cadastrar_equipamentos'),
        appBar: TopBar(text: 'Equipamentos'),
        body: Column(children: [
          DefaultTable(
              items: dados, iconActions: const []), // Botões de navegação
          if (dados.isNotEmpty)
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
                      child: const Row(children: [
                        Text('Próximo'),
                        Icon(Icons.arrow_forward)
                      ]),
                    )
                  ],
                )),
          // Botão para novo Equipamento
          PrimaryButton(
            text: 'Novo ',
            width: 110,
            height: 40,
            onPressed: () => navigateTo(context, CadEquip()),
            icon: Icons.add_sharp,
          )
        ]));
  }
}

class CadEquip extends StatefulWidget {
  @override
  CadEquipState createState() => CadEquipState();
}

class CadEquipState extends State<CadEquip> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
