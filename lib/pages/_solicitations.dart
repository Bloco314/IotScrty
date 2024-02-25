import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iot_scrty/pages/login.dart';

import 'package:iot_scrty/utils.dart';
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
  List<List<dynamic>> lista = [];

  void novo() {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CreateSolicitacao()))
        .then((value) => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Solicitacoes())));
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final url =
        Uri.parse('http://${NetConfig.link}/solicitation/get/$userEmail/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final dados = json.decode(response.body)['solicitacoes'];
        setState(() {
          for (var e in dados) {
            lista.add(e);
          }
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Não foi possivel carregar seus dados');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarProfessor(cont: context, pageName: 'solicitacoes'),
        appBar: const TopBar(text: 'Suas solicitações'),
        body: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
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
                                  MediaQuery.of(context).size.width * 0.05,
                              vertical: 5),
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              color: PersonalColors.smoothWhite,
                              border: Border.all(color: Colors.black)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Texto(
                                    text: 
                                        'Solicitado: ${lista[index][1]}, em: ${lista[index][0]} ${textToData(lista[index][3])}',
                                    cor: PersonalColors.darkerGreen,
                                    size: 12),
                                const SizedBox(width: 10),
                                if (lista[index].last == 'Aceito')
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                else if (lista[index].last == 'Analise')
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

class CreateSolicitacao extends StatefulWidget {
  const CreateSolicitacao({super.key});

  @override
  CreateSolicitacaoState createState() => CreateSolicitacaoState();
}

class CreateSolicitacaoState extends State<CreateSolicitacao> {
  late List<String> horarios = [];
  late List<String> envs = [];
  late String horariosSelected = ' ';
  late String envSelected = ' ';
  late String day = '';

  @override
  void initState() {
    super.initState();
    fetchEnvOptions().then((value) => fetchHorarioOptions());
  }

  Future<void> fetchEnvOptions() async {
    try {
      final url = Uri.parse('http://${NetConfig.link}/env/list');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        for (var e in json.decode(response.body)['names']) {
          setState(() {
            envs.add(e[0]);
          });
        }
        setState(() {
          if (envs.isNotEmpty) {
            envSelected = envs.first;
          }
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e', timeInSecForIosWeb: 10);
    }
  }

  Future<void> fetchHorarioOptions() async {
    try {
      final url =
          Uri.parse('http://${NetConfig.link}/hour/?env_name=$envSelected');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        horarios.clear();
        for (var e in json.decode(response.body)['horarios']) {
          setState(() {
            horarios.add(textToDataHora(e[0]));
          });
        }
        setState(() {
          if (horarios.isNotEmpty) {
            horariosSelected = horarios.first;
          }
          day = nextDay(horariosSelected.substring(8));
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  void onchangeEnv(String? value) {
    if (value != null) {
      setState(() {
        envSelected = value;
      });
      fetchHorarioOptions();
    }
  }

  void emprestar() async {
    day = day.replaceAll('/', '');
    String email = userEmail ?? '';
    final url = Uri.parse(
        "http://${NetConfig.link}/solicitation/create/?horario_valor=$horariosSelected&env_name=$envSelected&user_email=$email&dia=$day");

    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Solicitado com sucesso');
        Navigator.pop(context);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Não foi possível criar sua solicitação');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBar(text: 'Solicitar emprestimo'),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Texto(
              text: "Fazendo solicitação como: ${userName ?? 'Anonimo'}",
              size: 16,
              cor: PersonalColors.darkerGreen),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            // DropDown de ambiente
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                color: PersonalColors.lightGrey,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(children: [
                  const Texto(
                      size: 14,
                      text: 'Selecione um ambiente:',
                      cor: PersonalColors.darkerGreen),
                  DropdownButton<String>(
                    style: const TextStyle(
                        color: PersonalColors.darkerGreen, fontSize: 18),
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    iconEnabledColor: PersonalColors.darkerGreen,
                    alignment: Alignment.center,
                    underline: Container(),
                    value: envSelected,
                    items: envs.map((String v) {
                      return DropdownMenuItem<String>(value: v, child: Text(v));
                    }).toList(),
                    onChanged: onchangeEnv,
                  )
                ])),

            // DropDown do horario
            if (horarios.isNotEmpty)
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  color: PersonalColors.lightGrey,
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    const Texto(
                        size: 14,
                        text: 'Selecione um horario:  ',
                        cor: PersonalColors.darkerGreen),
                    DropdownButton<String>(
                      style: const TextStyle(
                          color: PersonalColors.darkerGreen, fontSize: 18),
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      iconEnabledColor: PersonalColors.darkerGreen,
                      alignment: Alignment.center,
                      underline: Container(),
                      value: horariosSelected,
                      items: horarios.map((String v) {
                        return DropdownMenuItem<String>(
                            value: v, child: Text(v));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          horariosSelected = value!;
                          day = nextDay(horariosSelected.substring(8));
                        });
                      },
                    ),
                    Text(day)
                  ]))
            else
              const Text('sem horarios livres'),
          ]),
          PrimaryButton(text: 'Solicitar', onPressed: emprestar)
        ]));
  }
}

class SolicitacoesCoord extends StatefulWidget {
  const SolicitacoesCoord({super.key});

  @override
  SolicitacoesCoordState createState() => SolicitacoesCoordState();
}

class SolicitacoesCoordState extends State<SolicitacoesCoord> {
  List<List<dynamic>> lista = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final url = Uri.parse('http://${NetConfig.link}/solicitation/list/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final dados = json.decode(response.body)['solicitacoes'];
        setState(() {
          for (var e in dados) {
            lista.add(e);
          }
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Não foi possivel carregar seus dados');
    }
  }

  void editar() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarCoordenador(cont: context, pageName: 'solicitacoes'),
        appBar: const TopBar(text: 'Solicitações'),
        body: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
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
                                  MediaQuery.of(context).size.width * 0.05,
                              vertical: 5),
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              color: PersonalColors.smoothWhite,
                              border: Border.all(color: Colors.black)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Texto(
                                    text:
                                        'Solicitado: ${lista[index][1]}, em: ${lista[index][0]} ${textToData(lista[index][3])}',
                                    cor: PersonalColors.darkerGreen,
                                    size: 12),
                                const SizedBox(width: 10),
                                if (lista[index].last == 'Aceito')
                                  IconButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith((states) =>
                                                  PersonalColors.lightGrey)),
                                      icon: const Icon(Icons.check,
                                          color: Colors.green),
                                      onPressed: editar)
                                else if (lista[index].last == 'Analise')
                                  IconButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith((states) =>
                                                  PersonalColors.lightGrey)),
                                      icon: const Icon(Icons.restore_outlined,
                                          color: Colors.blueAccent),
                                      onPressed: editar)
                                else
                                  IconButton(
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateColor.resolveWith((states) => PersonalColors.lightGrey)),
                                      icon: const Icon(Icons.close, color: Colors.red),
                                      onPressed: editar)
                              ]));
                    })),
          )
        ]));
  }
}
