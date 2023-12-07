import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/input_fields.dart';
import 'package:iot_scrty/components/navigatio_bar.dart';
import 'package:iot_scrty/components/table_elements.dart';
import 'package:iot_scrty/components/top_bar.dart';

class ViewEnvironments extends StatelessWidget {
  final String nome;
  final String email;

  final List<Map<String, dynamic>> dados = [
    {'nome': 'ambiente 1', 'horarios': 'sim', 'algo': 'mais'},
    {'nome': 'ambiente 2', 'horarios': 'nao', 'algo': 'mais'},
    {'nome': 'ambiente 3', 'horarios': 'sim', 'algo': 'mais'},
  ];

  ViewEnvironments({required this.nome, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCoordenador(email: email, nome: nome, cont: context),
      appBar: TopBar(text: 'Ambientes'),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            //Cabeçalho
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    HeaderCell(text: 'Nome'),
                    HeaderCell(text: 'Horarios'),
                    HeaderCell(text: 'Algo mais'),
                    HeaderCell(text: 'Editar'),
                    HeaderCell(text: 'Excluir')
                  ],
                ),
              ],
            ),
            //Dados da tabela
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: dados.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> rowData = entry.value;

                return TableRow(
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
                  ),
                  children: [
                    BodyCell(text: rowData['nome']),
                    BodyCell(text: rowData['horarios'].toString()),
                    BodyCell(text: rowData['algo']),
                    TableCell(
                      child: ElevatedButton(
                        onPressed: () => null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: PersonalColors.buttonGrey,
                            minimumSize: const Size(5.0, 10.0),
                            maximumSize: const Size(5.0, 50.0)),
                        child: const Icon(
                          Icons.edit,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TableCell(
                      child: ElevatedButton(
                        onPressed: () => null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: PersonalColors.buttonGrey,
                            minimumSize: const Size(10.0, 10.0),
                            maximumSize: const Size(10.0, 50.0)),
                        child: const Icon(Icons.delete,
                            size: 30.0, color: Colors.white),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            //Botão
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CadEnviroment(
                              email: email,
                              nome: nome,
                            ))),
                child: Text('Novo Ambiente'))
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

  void cadastrarEquipamento() {
    print(nomeSala.text + horariosSala.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCoordenador(email: email, nome: nome, cont: context),
      appBar: TopBar(text: 'Ambientes'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CampoCadastro(labelText: 'Nome da sala', controller: nomeSala),
            CampoCadastro(labelText: 'Horario', controller: horariosSala),
            TextButton(
                onPressed: cadastrarEquipamento, child: Text('Cadastrar'))
          ],
        ),
      ),
    );
  }
}
