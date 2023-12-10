import 'package:flutter/material.dart';
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

  void modalEquipamentos(context) {}

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
            Table(
              border: TableBorder.all(color: Colors.black),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: currentData.asMap().entries.map((entry) {
                int index = entry.key;

                return TableRow(
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
                  ),
                  children: [
                    BodyCell(text: entry.value),
                    // Abre modal de equipamentos
                    TableCell(
                      child: TableButton(
                        icone: Icons.computer_sharp,
                        onPressed: () => modalEquipamentos(context),
                      ),
                    ),
                    // Abre modal de horarios
                    TableCell(
                      child: TableButton(
                        icone: Icons.watch_later,
                        onPressed: () =>
                            modalHorarios(context, currentData[index]),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            // Botões de navegação
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: currentPage > 0 ? previousPage : null,
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        disabledBackgroundColor: Colors.transparent,
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
                      shape: const LinearBorder()),
                  child: const Row(
                      children: [Text('Próximo'), Icon(Icons.arrow_forward)]),
                ),
              ],
            ),
            // Botão para novo ambiente
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: PrimaryButton(
                text: 'Novo ambiente',
                width: 160,
                onPressed: () => navigateTo(context,
                    CadEnviroment(nome: widget.nome, email: widget.email)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CadEnviroment extends StatelessWidget {
  final String nome;
  final String email;
  final TextEditingController nomeSala = TextEditingController();
  final TextEditingController horariosSala = TextEditingController();

  CadEnviroment({required this.nome, required this.email});

  void cadastrarEquipamento() {}

  void cancelar(context) {
    Navigator.pop(context);
  }

  void cadastrar() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCoordenador(
          email: email,
          nome: nome,
          cont: context,
          pageName: 'cadastrar_ambientes'),
      appBar: TopBar(text: 'Ambientes'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CampoCadastro(labelText: 'Nome da sala', controller: nomeSala),
          CampoCadastro(labelText: 'Horarios', controller: horariosSala),
          PrimaryButton(text: 'Cadastrar', onPressed: cadastrar),
          GenericButton(
              text: 'Cancelar',
              onPressed: () => cancelar(context),
              color: Colors.transparent,
              textColor: Colors.red,
              height: 20)
        ]),
      ),
    );
  }
}

class ModalHorarios extends StatelessWidget {
  final String enviromentName;

  final Map<String, List<String>> horarios = {
    'Ambiente 1': ['09:10 - 10:50','10:50 - 12:30'],
    'Ambiente 2': ['09:10 - 10:50']
  };

  ModalHorarios({required this.enviromentName});

  @override
  Widget build(BuildContext context) {
    List<String>? horariosList = horarios[enviromentName];

    return AlertDialog(
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
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Fechar'),
        ),
      ],
    );
  }
}
