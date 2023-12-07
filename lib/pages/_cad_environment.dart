import 'package:flutter/material.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/input_fields.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/table_elements.dart';
import 'package:iot_scrty/components/top_bar.dart';

class ViewEnvironments extends StatelessWidget {
  final String nome;
  final String email;

  final List<String> dados = [
    'Ambiente 1',
    'Ambiente 2',
    'Ambiente 3',
    'Ambiente 4',
    'Ambiente 5'
  ];

  ViewEnvironments({required this.nome, required this.email});

  void navigateTo(context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void modalHorarios(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalHorarios();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCoordenador(
          email: email,
          nome: nome,
          cont: context,
          pageName: 'visualizar_ambientes'),
      appBar: TopBar(text: 'Ambientes'),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            //Cabeçalho
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    HeaderCell(text: 'Nome'),
                    HeaderCell(text: 'Equipamentos'),
                    HeaderCell(text: 'Horarios')
                  ],
                ),
              ],
            ),
            //Dados da tabela
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: dados.asMap().entries.map((entry) {
                int index = entry.key;

                return TableRow(
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
                  ),
                  children: [
                    BodyCell(text: entry.value),
                    //Abre modal de equipamentos
                    TableCell(
                        child: TableButton(
                            icone: Icons.computer_sharp,
                            onPressed: () => null)),
                    //Abre modal de horarios
                    TableCell(
                        child: TableButton(
                            icone: Icons.watch_later,
                            onPressed: () => modalHorarios(context))),
                  ],
                );
              }).toList(),
            ),
            //Botão para novo ambiente
            Container(
                margin: EdgeInsets.only(),
                child: DefaultButton(
                    text: 'Novo ambiente',
                    onPressed: () => navigateTo(
                        context, CadEnviroment(nome: nome, email: email)))),
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
      drawer: NavBarCoordenador(
          email: email,
          nome: nome,
          cont: context,
          pageName: 'cadastrar_ambientes'),
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

class ModalHorarios extends StatelessWidget {
  final List<String> horarios = ['10-10', '20-20', '30-30', '40-40'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: LinearBorder(),
      title: Text('Horários'),
      content: Container(
        height: 400,
        width: 300,
        child: ListView.builder(
          itemCount: horarios.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              ListTile(
                title: Text(horarios[index]),
              ),
              Divider()
            ]); 
          },
        ),
      ),
      actions: [
        DefaultButton(text: 'Fechar', onPressed: () => Navigator.pop(context))
      ],
    );
  }
}
