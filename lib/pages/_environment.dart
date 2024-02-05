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

class ViewEnvironments extends StatefulWidget {
  final String nome;
  final String email;

  ViewEnvironments({required this.nome, required this.email});

  @override
  ViewEnvironmentsState createState() => ViewEnvironmentsState();
}

class ViewEnvironmentsState extends State<ViewEnvironments> {
  List<String> dados = [];

  Future<void> getData() async {
    try {
      final url = Uri.parse('http://${NetConfig.Link}/env/list');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          for (var e in json.decode(response.body)['names']) {
            dados.add(e[0]);
          }
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Houve um erro ao carregar os dados$e');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  int currentPage = 0;
  static const int itemsPerPage = 5;

  List<String> get currentData {
    int startIndex = currentPage * itemsPerPage;
    int endIndex = (currentPage + 1) * itemsPerPage;
    return dados.sublist(startIndex, endIndex.clamp(0, dados.length));
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
    navigateTo(context,
        Enviroment(nome: widget.nome, email: widget.email, editando: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarCoordenador(
          email: widget.email,
          nome: widget.nome,
          cont: context,
          pageName: 'visualizar_ambientes',
        ),
        appBar: TopBar(text: 'Ambientes'),
        body: Column(
          children: [
            // Tabela
            DefaultTable(headerTexts: const [
              'Nome',
              'Equipamentos',
              'Horarios',
              'Editar'
            ], actions: [
              (context, index) => modalEquipamentos(context, index),
              (context, index) => modalHorarios(context, index),
              (context, index) => editarAmbiente(context, index)
            ], icones: const [
              Icons.computer_sharp,
              Icons.watch_later,
              Icons.edit
            ], items: currentData),
            // Botões de navegação
            if (dados.isNotEmpty)
              Padding(
                  padding: EdgeInsets.only(
                      top: 10, bottom: 200 - currentData.length * 40),
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
                        onPressed: currentPage <
                                (dados.length / itemsPerPage).ceil() - 1
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
                      ),
                    ],
                  )),
            // Botão para novo ambiente
            PrimaryButton(
              text: 'Novo ',
              width: 110,
              height: 40,
              onPressed: () => navigateTo(
                  context,
                  Enviroment(
                      nome: widget.nome, email: widget.email, editando: false)),
              icon: Icons.add,
            )
          ],
        ));
  }
}

class Enviroment extends StatefulWidget {
  final String nome;
  final String email;
  final bool editando;

  Enviroment({required this.nome, required this.email, required this.editando});

  @override
  EnviromentState createState() => EnviromentState(nome: nome, email: email);
}

class EnviromentState extends State<Enviroment> {
  final String nome;
  final String email;

  final TextEditingController nomeSala = TextEditingController();
  final TextEditingController descricao = TextEditingController();
  final TextEditingController horariosSala = TextEditingController();
  final List<String> horariosAdicionados = [];

  EnviromentState({required this.nome, required this.email});

  @override
  void initState() {
    super.initState();
    if(!widget.editando){
      return;
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

    final url = Uri.parse(
        'http://${NetConfig.Link}/env/create/?name=${nomeSala.text}&description=${descricao.text}');
    final body = jsonEncode({'list': horariosAdicionados});

    try {
      final response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final msg = json.decode(response.body)['msg'];
        if (msg == 'Created sucessfully!') {
          Fluttertoast.showToast(msg: 'Criado com sucesso');
          goback();
        } else if (msg == 'PK-ERROR') {
          Fluttertoast.showToast(msg: 'Nomes não devem se repetir');
        } else if (msg == 'OP-ERROR') {
          Fluttertoast.showToast(msg: 'Houve um erro no servidor');
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e', timeInSecForIosWeb: 10);
    }
  }

  void goback() {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewEnvironments(nome: nome, email: email)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(text: 'Ambientes'),
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
            Row(
              children: [
                Expanded(
                    child: CampoCadastro(
                        labelText: 'Acrescentar horario',
                        controller: horariosSala)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (horariosSala.text.isNotEmpty) {
                      setState(() {
                        horariosAdicionados.add(horariosSala.text);
                        horariosSala.clear();
                      });
                    }
                  },
                ),
              ],
            ),
            const Divider(),
            const Text('Horários:'),
            const Divider(),
            SizedBox(
                height: 180,
                child: Expanded(
                    child: ListView.builder(
                  itemCount: horariosAdicionados.length,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(horariosAdicionados[index],
                              textAlign: TextAlign.center),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => excluirHorario(index),
                          )
                        ],
                      ),
                      const Divider()
                    ]);
                  },
                ))),
            PrimaryButton(
                text: widget.editando ? 'Atualizar' : 'Cadastrar',
                onPressed: criarAmbiente),
            GenericButton(
              text: 'Cancelar',
              onPressed: () => Navigator.pop(context),
              color: Colors.transparent,
              textColor: Colors.red,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class ModalHorarios extends StatefulWidget {
  final String env;

  ModalHorarios({required this.env});

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
        Uri.parse('http://${NetConfig.Link}/hour/?env_name=${widget.env}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        for (var i in json.decode(response.body)['horarios']) {
          horarios.add(i[0]);
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

class ModalEquipamentos extends StatelessWidget {
  final String enviromentName;

  //Pegar dados do back
  final Map<String, List<String>> equips = {};

  ModalEquipamentos({required this.enviromentName});

  @override
  Widget build(BuildContext context) {
    List<String>? equipsList = equips[enviromentName];
    return Expanded(
        child: AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      title: const Text('Equipamentos'),
      content: Container(
        height: 400,
        width: 300,
        child: equipsList != null && equipsList.isNotEmpty
            ? ListView.builder(
                itemCount: equipsList.length,
                itemBuilder: (BuildContext context, int index) {
                  String horarioValue = equipsList[index];

                  return Column(
                    children: [
                      ListTile(
                        title: Text(horarioValue),
                      ),
                      if (index < equipsList.length - 1) const Divider()
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
