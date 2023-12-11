import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/input_fields.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/table_elements.dart';
import 'package:iot_scrty/components/top_bar.dart';

class ViewEnvironments extends StatefulWidget {
  final String nome;
  final String email;

  ViewEnvironments({required this.nome, required this.email});

  @override
  ViewEnvironmentsState createState() => ViewEnvironmentsState();
}

class ViewEnvironmentsState extends State<ViewEnvironments> {
  final List<String> dados =
      List.generate(20, (index) => 'Ambiente ${index + 1}');

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
        return ModalHorarios(enviromentName: name);
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
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            // Cabeçalho
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    HeaderCell(text: 'Nome'),
                    HeaderCell(text: 'Equipamentos'),
                    HeaderCell(text: 'Horarios'),
                  ],
                ),
              ],
            ),
            // Dados da tabela
            DefaultTable(
                primaryAction: (context, index) =>
                    modalEquipamentos(context, index),
                secondaryAction: (context, index) =>
                    modalHorarios(context, index),
                primaryIcon: Icons.computer_sharp,
                secondaryIcon: Icons.watch_later,
                items: currentData),
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
              onPressed: () => navigateTo(context,
                  CadEnviroment(nome: widget.nome, email: widget.email)),
              icon: Icons.add_sharp,
            ),
          ],
        ),
      ),
    );
  }
}

class CadEnviroment extends StatefulWidget {
  final String nome;
  final String email;

  CadEnviroment({required this.nome, required this.email});

  @override
  _CadEnviromentState createState() => _CadEnviromentState();
}

class _CadEnviromentState extends State<CadEnviroment> {
  final TextEditingController nomeSala = TextEditingController();
  final TextEditingController horariosSala = TextEditingController();
  final List<TextEditingController> horariosAdicionados = [];

  void excluirHorario(int index) {
    setState(() {
      horariosAdicionados.removeAt(index);
    });
  }

  void cancelar(context) {
    Navigator.pop(context);
  }

  void cadastrar() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(text: 'Ambientes'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CampoCadastro(labelText: 'Nome da sala', controller: nomeSala),
            Row(
              children: [
                Expanded(
                    child: CampoCadastro(
                        labelText: 'Acrescentar horario',
                        controller: horariosSala)),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (horariosSala.text.isNotEmpty) {
                      setState(() {
                        horariosAdicionados.add(
                          TextEditingController(text: horariosSala.text),
                        );
                        horariosSala.clear();
                      });
                    }
                  },
                ),
              ],
            ),
            Divider(),
            Text('Horários:'),
            Divider(),
            Container(
                height: 180,
                child: Expanded(
                    child: ListView.builder(
                  itemCount: horariosAdicionados.length,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(horariosAdicionados[index].text,
                              textAlign: TextAlign.center),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => excluirHorario(index),
                          )
                        ],
                      ),
                      Divider()
                    ]);
                  },
                ))),
            PrimaryButton(text: 'Cadastrar', onPressed: cadastrar),
            GenericButton(
              text: 'Cancelar',
              onPressed: () => cancelar(context),
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

class ModalHorarios extends StatelessWidget {
  final String enviromentName;

  final Map<String, List<String>> horarios = {
    'Ambiente 1': ['09:10 - 10:50', '10:50 - 12:30'],
    'Ambiente 2': ['09:10 - 10:50']
  };

  ModalHorarios({required this.enviromentName});

  @override
  Widget build(BuildContext context) {
    List<String>? horariosList = horarios[enviromentName];

    return Expanded(
        child: AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      title: const Text('Horários'),
      content: Container(
        height: 400,
        width: 300,
        child: horariosList != null && horariosList.isNotEmpty
            ? ListView.builder(
                itemCount: horariosList.length,
                itemBuilder: (BuildContext context, int index) {
                  String horarioValue = horariosList[index];

                  return Column(
                    children: [
                      ListTile(
                        title: Text(horarioValue),
                      ),
                      if (index < horariosList.length - 1) Divider()
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

  final Map<String, List<String>> equips = {
    'Ambiente 1': ['equip 1', 'equip 2', 'equip 3'],
    'Ambiente 2': ['equip 1']
  };

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
                      if (index < equipsList.length - 1) Divider()
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
