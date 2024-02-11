import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/input_fields.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/table_elements.dart';
import 'package:iot_scrty/components/top_bar.dart';
import 'package:iot_scrty/constants.dart';
import 'package:http/http.dart' as http;

class ViewEquipment extends StatefulWidget {
  const ViewEquipment({super.key});

  @override
  Equipments createState() => Equipments();
}

class Equipments extends State<ViewEquipment> {
  List<List<String>> dados = [];

  Future<void> getData() async {
    try {
      final url = Uri.parse('http://${NetConfig.Link}/equips/list');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          try {
            for (var e in json.decode(response.body)['equips']) {
              List<String> sub = [];
              for (var i in e) {
                sub.add(i);
              }
              //ignora a descrição
              sub.removeAt(1);
              dados.add(sub);
            }
          } catch (e) {
            // Não a dados cadastrados de fato
          }
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Houve um erro ao carregar os dados');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  int currentPage = 0;
  static const int itemsPerPage = 5;

  List<List<String>> get currentData {
    int startIndex = currentPage * itemsPerPage;
    int endIndex = (currentPage + 1) * itemsPerPage;
    List<List<String>> result = [
      const ['Nome', 'Ambiente', 'Tipo', 'Editar']
    ];

    List<List<String>> subset =
        dados.sublist(startIndex, endIndex.clamp(0, dados.length));

    for (var element in subset) {
      result.add(element);
    }

    return result;
  }

  void nextPage() {
    setState(() {
      currentPage = (currentPage + 1)
          .clamp(0, ((dados.length - 1) / itemsPerPage).floor());
    });
  }

  void previousPage() {
    setState(() {
      currentPage =
          (currentPage - 1).clamp(0, (dados.length - 1) / itemsPerPage).floor();
    });
  }

  void equipCreateUpdate(context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page)).then(
        (value) => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ViewEquipment())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarCoordenador(
            cont: context, pageName: 'cadastrar_equipamentos'),
        appBar: const TopBar(text: 'Equipamentos'),
        body: Column(children: [
          DefaultTable(items: currentData, iconActions: [
            IconAction(
              icon: Icons.edit,
              action: (context, index) => equipCreateUpdate(
                  context, CadEquip(editando: true, equipName: index)),
              text: '',
            )
          ]),
          // Botões de navegação
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
            onPressed: () =>
                equipCreateUpdate(context, const CadEquip(editando: false)),
            icon: Icons.add_sharp,
          )
        ]));
  }
}

class CadEquip extends StatefulWidget {
  final bool editando;
  final String? equipName;

  const CadEquip({super.key, required this.editando, this.equipName});

  @override
  CadEquipState createState() => CadEquipState();
}

class CadEquipState extends State<CadEquip> {
  TextEditingController nome = TextEditingController();
  TextEditingController tipo = TextEditingController();
  TextEditingController descricao = TextEditingController();
  List<String> options = [];
  late String selected;

  @override
  void initState() {
    super.initState();
    selected = '';
    fillEnvNames();
    if (widget.editando) {
      getEquipInformation();
    }
  }

  Future<void> getEquipInformation() async {
    final url =
        Uri.parse('http://${NetConfig.Link}/equip/get/${widget.equipName}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          nome.text = widget.equipName!;
          descricao.text = data[1];
          selected = data[2];
          tipo.text = data[3];
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  Future<void> fillEnvNames() async {
    final url = Uri.parse('http://${NetConfig.Link}/env/list/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['names'];

        setState(() {
          options = List<String>.from(data.map((e) => e[0]));
          selected = options.isNotEmpty ? options.first : '';
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  Future<void> cadastrar() async {
    if (nome.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Preencha o campo nome');
      return;
    }
    final url = Uri.parse(
        'http://${NetConfig.Link}/equip/create/?name=${nome.text}&description=${descricao.text}&tag=${tipo.text}&env=$selected');
    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'salvo');
        Navigator.pop(context);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  Future<void> deleteEquip() async {
    final url =
        Uri.parse('http://${NetConfig.Link}/equip/delete/${widget.equipName}');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        Navigator.pop(context);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
          text:
              widget.editando ? 'Editar Equipamento' : 'Cadastrar Equipamento'),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            CampoCadastro(
                labelText: 'Nome', controller: nome, enabled: !widget.editando),
            CampoCadastro(labelText: 'Tipo', controller: tipo),
            CampoCadastro(labelText: 'Descrição', controller: descricao),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                width: 180,
                height: 50,
                color: PersonalColors.lightGrey,
                padding: const EdgeInsets.all(10),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(),
                  style: const TextStyle(
                      color: PersonalColors.darkerGreen, fontSize: 18),
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  iconEnabledColor: PersonalColors.darkerGreen,
                  value: selected,
                  items: options.map((String v) {
                    return DropdownMenuItem<String>(value: v, child: Text(v));
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selected = value!;
                    });
                  },
                )),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              PrimaryButton(text: 'Cadastrar', onPressed: cadastrar),
              if (widget.editando) const SizedBox(width: 10),
              if (widget.editando)
                SecondaryButton(text: 'Deletar', onPressed: deleteEquip)
            ])
          ],
        ),
      ),
    );
  }
}
