import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/input_fields.dart';
import 'package:iot_scrty/components/modal_exclusao.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/table_elements.dart';
import 'package:iot_scrty/components/text.dart';
import 'package:iot_scrty/components/top_bar.dart';
import 'package:iot_scrty/utils.dart';
import 'package:http/http.dart' as http;

class ViewEnvironments extends StatefulWidget {
  const ViewEnvironments({super.key});

  @override
  ViewEnvironmentsState createState() => ViewEnvironmentsState();
}

class ViewEnvironmentsState extends State<ViewEnvironments> {
  List<String> dados = [];

  Future<void> getData() async {
    try {
      final url = Uri.parse('http://${NetConfig.link}/env/list');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          try {
            for (var e in json.decode(response.body)['names']) {
              dados.add(e[0]);
            }
          } catch (e) {
            // Não há dados cadastrados de fato
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
  int itemsPerPage = 5;

  List<List<String>> get currentData {
    itemsPerPage =
        MediaQuery.of(context).orientation == Orientation.landscape ? 2 : 5;
    int startIndex = currentPage * itemsPerPage;
    int endIndex = (currentPage + 1) * itemsPerPage;
    List<List<String>> result = [
      const ['Nome', 'Ver equipamentos', 'Ver horarios', 'editar sala']
    ];

    List<String> subset =
        dados.sublist(startIndex, endIndex.clamp(0, dados.length));

    for (var element in subset) {
      result.add([element]);
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

  void navigateToAndReload(context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page)).then(
        (value) => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ViewEnvironments())));
  }

  void modalHorarios(context, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalHorarios(env: name);
      },
    );
  }

  void modalEquipamentos(context, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalEquipamentos(enviromentName: name);
      },
    );
  }

  void editarAmbiente(context, String name) {
    navigateToAndReload(context, Enviroment(editando: true, envName: name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarCoordenador(
          cont: context,
          pageName: 'visualizar_ambientes',
        ),
        appBar: const TopBar(text: 'Ambientes'),
        body: Column(
          children: [
            // Tabela
            DefaultTable(
                items: currentData,
                iconActions: [
                  IconAction(
                    icon: Icons.computer_sharp,
                    action: (context, index) =>
                        modalEquipamentos(context, index),
                    text: '',
                  ),
                  IconAction(
                    icon: Icons.watch_later,
                    action: (context, index) => modalHorarios(context, index),
                    text: '',
                  ),
                  IconAction(
                    icon: Icons.edit,
                    action: (context, index) => editarAmbiente(context, index),
                    text: '',
                  ),
                ],
                cardmode: true),
            // Botão para novo ambiente
            if (dados.isEmpty)
              const Texto(
                  size: 16,
                  text: 'Sem registros, tente criar um ambiente',
                  cor: PersonalColors.darkerGreen),
            const SizedBox(height: 10),
            PrimaryButton(
              text: 'Novo ',
              width: 110,
              height: 40,
              onPressed: () => navigateToAndReload(
                  context, const Enviroment(editando: false)),
              icon: Icons.add,
            ),
            if (dados.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: currentPage == 0 ? null : previousPage,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      disabledBackgroundColor: Colors.transparent,
                      foregroundColor: PersonalColors.darkerGreen,
                      shape: const LinearBorder(),
                    ),
                    child: const Row(children: [
                      Icon(Icons.arrow_back),
                      Text('Anterior'),
                    ]),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: currentPage <
                            ((dados.length - 1) / itemsPerPage).floor()
                        ? nextPage
                        : null,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      disabledBackgroundColor: Colors.transparent,
                      foregroundColor: PersonalColors.darkerGreen,
                      shape: const LinearBorder(),
                    ),
                    child: const Row(children: [
                      Text('Próximo'),
                      Icon(Icons.arrow_forward),
                    ]),
                  ),
                ],
              ),
          ],
        ));
  }
}

class Enviroment extends StatefulWidget {
  final bool editando;
  final String? envName;

  const Enviroment({super.key, required this.editando, this.envName});

  @override
  EnviromentState createState() => EnviromentState();
}

class EnviromentState extends State<Enviroment> {
  final TextEditingController nomeSala = TextEditingController();
  final TextEditingController descricao = TextEditingController();
  final TextEditingController hora = TextEditingController();
  final TextEditingController minuto = TextEditingController();
  final List<String> dias = ['SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB', 'DOM'];
  String dia = ' ';
  List<String> horariosAdicionados = [];

  @override
  void initState() {
    super.initState();
    dia = dias.first;
    if (!widget.editando) {
      return;
    }
    fetchData();

    nomeSala.text = widget.envName ?? '';
  }

  Future<void> fetchData() async {
    final url = Uri.parse('http://${NetConfig.link}/env/get/${widget.envName}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final dados = json.decode(response.body);
        descricao.text = dados['descricao'];
        for (var i in dados['horarios']) {
          setState(() {
            final String text = i[0];
            horariosAdicionados.add(textToData(text));
          });
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Houve um erro ao carregar os dados');
      Navigator.pop(context);
    }
  }

  void adicionaHorario() {
    if (hora.text.isNotEmpty && minuto.text.isNotEmpty) {
      if (horariosAdicionados
          .contains(textToDataJoin(hora.text, minuto.text, dia))) {
        Fluttertoast.showToast(msg: 'Este horario já está adicionado');
      } else {
        if (int.parse(hora.text) < 10) {
          hora.text = '0${hora.text}';
        }
        if (int.parse(minuto.text) < 10) {
          minuto.text = '0${minuto.text}';
        }
        setState(() {
          horariosAdicionados.add(textToDataJoin(hora.text, minuto.text, dia));
          hora.clear();
          minuto.clear();
        });
      }
    } else {
      Fluttertoast.showToast(msg: 'Preencha os campos');
    }
  }

  void excluirHorario(int index) {
    setState(() {
      horariosAdicionados.removeAt(index);
    });
  }

  Future<void> criarAmbiente() async {
    if (nomeSala.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Preenha o nome por favor');
      return;
    }

    final url = widget.editando
        ? Uri.parse(
            'http://${NetConfig.link}/env/update/?description=${descricao.text}&name=${nomeSala.text}')
        : Uri.parse(
            'http://${NetConfig.link}/env/create/?name=${nomeSala.text}&description=${descricao.text}');

    final body = jsonEncode(
        {'list': horariosAdicionados.map((e) => dataToText(e)).toList()});

    try {
      final response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final msg = json.decode(response.body)['msg'];
        if (msg == 'Created sucessfully!' || msg == 'Updated sucessfully!') {
          Fluttertoast.showToast(
              msg: widget.editando
                  ? 'Atualizado com sucesso'
                  : 'Criado com sucesso');
          Navigator.pop(context);
        } else if (msg == 'PK-ERROR') {
          Fluttertoast.showToast(msg: 'Nomes não devem se repetir');
        } else if (msg == 'OP-ERROR') {
          Fluttertoast.showToast(msg: 'Houve um erro no servidor');
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  void excluir(context) async {
    bool deletar = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalConfirmarExclusao(envName: nomeSala.text);
      },
    );

    if (deletar) {
      final url =
          Uri.parse('http://${NetConfig.link}/env/delete/${nomeSala.text}');
      try {
        final response = await http.delete(url);
        if (response.statusCode == 200) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: 'Excluido!');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'Não foi possível deletar');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(text: 'Ambientes'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CampoCadastro(
                labelText: 'Nome da sala',
                controller: nomeSala,
                enabled: !widget.editando),
            CampoCadastro(
                labelText: 'Descrição (opcional)', controller: descricao),
            const Text('Horarios:'),
            Expanded(
                child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration:
                  BoxDecoration(border: Border.all(color: PersonalColors.grey)),
              child: ListView.builder(
                itemCount: horariosAdicionados.length + 1,
                itemBuilder: (context, index) {
                  if (index < horariosAdicionados.length) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 100,
                          margin: EdgeInsets.only(
                              left: 8, bottom: 5, top: index == 0 ? 10 : 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: PersonalColors.grey)),
                          child: Text(horariosAdicionados[index]),
                        ),
                        GenericButton(
                          text: '',
                          icon: Icons.delete,
                          iconColor: PersonalColors.red,
                          onPressed: () => excluirHorario(index),
                        ),
                      ],
                    );
                  } else {
                    return Column(children: [
                      const Divider(),
                      Row(
                        children: [
                          HoraMinuto(hora: hora, minuto: minuto),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: DropdownButton(
                              value: dia,
                              items: dias.map((String v) {
                                return DropdownMenuItem<String>(
                                  value: v,
                                  child: Text(v),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dia = value!;
                                });
                              },
                            ),
                          ),
                          GenericButton(
                            text: '',
                            width: 80,
                            icon: Icons.add,
                            iconColor: PersonalColors.darkerGreen,
                            textColor: PersonalColors.darkerGreen,
                            color: PersonalColors.smoothWhite,
                            onPressed: adicionaHorario,
                          )
                        ],
                      )
                    ]);
                  }
                },
              ),
            )),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              PrimaryButton(
                  text: widget.editando ? 'Atualizar' : 'Cadastrar',
                  onPressed: criarAmbiente),
              const SizedBox(height: 10),
              if (widget.editando) const SizedBox(width: 10),
              if (widget.editando)
                SecondaryButton(
                    text: 'Excluir Ambiente', onPressed: () => excluir(context))
            ]),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class ModalHorarios extends StatefulWidget {
  final String env;

  const ModalHorarios({super.key, required this.env});

  @override
  ModalHorariosState createState() => ModalHorariosState();
}

class ModalHorariosState extends State<ModalHorarios> {
  List<String> horarios = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url =
        Uri.parse('http://${NetConfig.link}/hour/?env_name=${widget.env}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        for (var i in json.decode(response.body)['horarios']) {
          final String h = i[0];
          horarios.add(textToData(h));
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erro!');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      title: const Text('Horários'),
      content: SizedBox(
        height: 400,
        width: 300,
        child: horarios.isNotEmpty
            ? ListView.builder(
                itemCount: horarios.length,
                itemBuilder: (BuildContext context, int index) {
                  String horarioValue = horarios[index];

                  return Column(
                    children: [
                      ListTile(
                        title: Text(horarioValue),
                      ),
                      if (index < horarios.length - 1) const Divider()
                    ],
                  );
                },
              )
            : const Center(
                child: Text('Nenhum registro encontrado.'),
              ),
      ),
      actions: [
        SecondaryButton(
            text: 'Fechar',
            width: 92,
            height: 40,
            onPressed: () => Navigator.pop(context)),
      ],
    ));
  }
}

class ModalEquipamentos extends StatefulWidget {
  final String enviromentName;

  const ModalEquipamentos({super.key, required this.enviromentName});

  @override
  ModalEquipamentosState createState() => ModalEquipamentosState();
}

class ModalEquipamentosState extends State<ModalEquipamentos> {
  List<String> equips = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final url = Uri.parse(
        'http://${NetConfig.link}/equip/list/${widget.enviromentName}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['names'];
        for (var e in data) {
          setState(() {
            equips.add(e[0]);
          });
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      title: const Text('Equipamentos'),
      content: SizedBox(
        height: 400,
        width: 300,
        child: equips.isNotEmpty
            ? ListView.builder(
                itemCount: equips.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(equips[index]),
                      ),
                      if (index < equips.length - 1) const Divider()
                    ],
                  );
                },
              )
            : const Center(
                child: Text('Nenhum registro encontrado.'),
              ),
      ),
      actions: [
        SecondaryButton(
            text: 'Fechar',
            width: 92,
            height: 40,
            onPressed: () => Navigator.pop(context)),
      ],
    ));
  }
}
