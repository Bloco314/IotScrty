import 'package:flutter/material.dart';

import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/input_fields.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/table_elements.dart';
import 'package:iot_scrty/components/top_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iot_scrty/constants.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Colaboradores extends StatefulWidget {
  final String nome;
  final String email;

  Colaboradores({required this.email, required this.nome});

  @override
  ColaboradoresState createState() =>
      ColaboradoresState(email: email, nome: nome);
}

class ColaboradoresState extends State<Colaboradores> {
  final String nome;
  final String email;
  List<String> emailNomes = [];
  List<String> tipos = [];

  ColaboradoresState({required this.email, required this.nome});

  @override
  void initState() {
    super.initState();
    listaColaboradores();
  }

  void listaColaboradores() async {
    try {
      final url = Uri.parse('http://${NetConfig.Link}/users/list_colaborator/');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          final List<dynamic> brute =
              json.decode(response.body)['colaborators'];
          setState(() {
            for (var element in brute) {
              emailNomes.add(element[1] + ' : ' + element[0]);
              tipos.add(element[2]);
            }
          });
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(text: 'Colaboradores'),
        drawer: NavBarCoordenador(
            nome: nome, email: email, cont: context, pageName: 'colaborador'),
        body: Column(children: [
          DefaultTable(
              headerTexts: const ['Nome: Email', 'Tipo'],
              items: emailNomes,
              secItems: tipos,
              actions: const [],
              icones: const []),
          PrimaryButton(
              text: 'Novo',
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ColaboradoresC(email: email, nome: nome)))
                  })
        ]));
  }
}

class ColaboradoresC extends StatefulWidget {
  final String nome;
  final String email;

  ColaboradoresC({required this.email, required this.nome});

  @override
  ColaboradoresCState createState() =>
      ColaboradoresCState(email: email, nome: nome);
}

class ColaboradoresCState extends State<ColaboradoresC> {
  final String nome;
  final String email;
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String tipo = tipos.first;

  ColaboradoresCState({required this.email, required this.nome});

  Future<void> criaUsuario() async {
    try {
      var url = Uri.parse(
          'http://${NetConfig.Link}/users/?email=${emailController.text}&senha=${senhaController.text}&name=${nameController.text}&tipo=${tipo}');
      final response = await http.post(url);

      if (response.statusCode == 200) {
        setState(() {
          emailController.text = '';
          senhaController.text = '';
          nameController.text = '';
          Fluttertoast.showToast(msg: 'Criado com sucesso!');
        });
      } else {
        Fluttertoast.showToast(msg: 'Não foi possível criar');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(text: 'Criar novo usuario'),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CampoCadastro(labelText: 'Nome', controller: nameController),
        CampoCadastro(labelText: 'Email', controller: emailController),
        CampoCadastro(labelText: 'Senha', controller: senhaController),
        Container(
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: DropdownButton<String>(
                value: tipo,
                icon: const Icon(Icons.arrow_downward),
                padding: const EdgeInsets.all(15),
                elevation: 0,
                iconEnabledColor: PersonalColors.darkerGreen,
                focusColor: Colors.transparent,
                underline: Container(color: Colors.transparent, height: 1),
                style: const TextStyle(color: PersonalColors.darkerGreen),
                onChanged: (String? value) {
                  setState(() {
                    tipo = value!;
                  });
                },
                items: tipos.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList())),
        const SizedBox(height: 50),
        PrimaryButton(text: 'Criar', onPressed: () => criaUsuario()),
        GenericButton(
            text: 'Cancelar',
            color: Colors.transparent,
            textColor: PersonalColors.red,
            onPressed: () => {Navigator.pop(context)})
      ]),
    );
  }
}
