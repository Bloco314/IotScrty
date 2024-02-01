import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/top_bar.dart';

//Pagina de Solicitações do professor
class Solicitacoes extends StatelessWidget {
  final String nome;
  final String email;

  Solicitacoes({required this.email,required this.nome});

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      drawer: NavBarProfessor(cont: context,email: email,nome: nome, pageName: 'solicitacoes_professor'),
      appBar: TopBar(text: 'Suas solicitações'),
      body: Container()
    );
  }
}

//Solicitações para o coordenador
class ViewSolicitacoes extends StatelessWidget {
  final String nome;
  final String email;

  final Map<String, List<String>> solicitacoes = {
    'Ambiente 1': ['Professor Santos', '10:50 - 12:30'],
    'Ambiente 2': ['Professor Silva', '09:10- 10:50'],
    'Ambiente 3': ['Professor Silva', '09:10- 10:50'],
    'Ambiente 4': ['Professor Silva', '09:10- 10:50'],
    'Ambiente 5': ['Professor Silva', '09:10- 10:50'],
    'Ambiente 6': ['Professor Silva', '09:10- 10:50'],
    'Ambiente 7': ['Professor Silva', '09:10- 10:50'],
    'Ambiente 8': ['Professor Silva', '09:10- 10:50'],
    'Ambiente 9': ['Professor Silva', '09:10- 10:50'],
  };

  ViewSolicitacoes({required this.email, required this.nome});

  String truncate(String text) {
    return text.length >= 15 ? text.substring(0, 15) : text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCoordenador(
        email: email,
        nome: nome,
        cont: context,
        pageName: 'solicitacoes',
      ),
      appBar: TopBar(text: 'Solicitações'),
      body: solicitacoes.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Ambiente',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Solicitante',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Horário',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: solicitacoes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ambiente =
                          truncate(solicitacoes.keys.elementAt(index));
                      final solicitante =
                          truncate(solicitacoes[ambiente]?[0] ?? '');
                      final horario =
                          truncate(solicitacoes[ambiente]?[1] ?? '');

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: Text(ambiente,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16))),
                              Expanded(
                                  child: Text(solicitante,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16))),
                              Expanded(
                                  child: Text(horario,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16))),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      side: const BorderSide(
                                          color: PersonalColors.lightGrey),
                                      backgroundColor: Colors.transparent),
                                  child: const Icon(Icons.check,
                                      color: PersonalColors.darkerGreen)),
                              const SizedBox(width: 2),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      side: const BorderSide(
                                          color: PersonalColors.lightGrey),
                                      backgroundColor: Colors.transparent),
                                  child: const Icon(Icons.cancel_outlined,
                                      color: PersonalColors.red))
                            ],
                          ),
                          Divider()
                        ],
                      );
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: Text('Nenhum registro encontrado.'),
            ),
    );
  }
}
