import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/text.dart';
import 'package:iot_scrty/components/top_bar.dart';

class Solicitacoes extends StatefulWidget {
  const Solicitacoes({super.key});

  @override
  SolicitacoesState createState() => SolicitacoesState();
}

class SolicitacoesState extends State<Solicitacoes> {
  final random = Random();

  List<List<String>> lista = [];

  void novo() {}

  @override
  void initState() {
    super.initState();
    lista =
        List.generate(110, (index) => ['Ambiente $index HH:MM - DIA', stateRandom()]);
  }

  String stateRandom() {
    final states = ['Aceito', 'Analise', 'Negado'];
    return states[random.nextInt(states.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarProfessor(cont: context, pageName: 'solicitacoes'),
        appBar: const TopBar(text: 'Suas solicitações'),
        body: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [PersonalColors.lightGrey, Colors.white]),
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Expanded(
                child: ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.2,
                              vertical: 5),
                          padding: const EdgeInsets.all(7),
                          width: 500,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              color: PersonalColors.smoothWhite,
                              border: Border.all(color: Colors.black)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Texto(
                                    text: lista[index][0],
                                    cor: PersonalColors.darkerGreen,
                                    size: 12),
                                const SizedBox(width: 10),
                                if (lista[index][1] == 'Aceito')
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                else if (lista[index][1] == 'Analise')
                                  const Icon(
                                    Icons.restore_outlined,
                                    color: Colors.blueAccent,
                                  )
                                else
                                  const Icon(Icons.close, color: Colors.red),
                              ]));
                    })),
          ),
          PrimaryButton(text: 'Novo', onPressed: novo)
        ]));
  }
}

//Solicitações para o coordenador
class ViewSolicitacoes extends StatelessWidget {
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

  ViewSolicitacoes({super.key});

  String truncate(String text) {
    return text.length >= 15 ? text.substring(0, 15) : text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCoordenador(
        cont: context,
        pageName: 'solicitacoes',
      ),
      appBar: const TopBar(text: 'Solicitações'),
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
                const Divider(),
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
                          const Divider()
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
