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
  const Colaboradores({super.key});

  @override
  ColaboradoresState createState() => ColaboradoresState();
}

class ColaboradoresState extends State<Colaboradores> {
  List<List<String>> data = [
    const ['Nome', 'Email', 'Tipo']
  ];

  @override
  void initState() {
    super.initState();
    listaColaboradores();
  }

  void listaColaboradores() async {
    try {
      final url = Uri.parse('http://${NetConfig.link}/users/list_colaborator/');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          final List<dynamic> brute =
              json.decode(response.body)['colaborators'];
          setState(() {
            for (var element in brute) {
              List<String> emailsTipos = [];
              for (var e in element) {
                emailsTipos.add(e);
              }
              data.add(emailsTipos);
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
        appBar: const TopBar(text: 'Colaboradores'),
        drawer: NavBarCoordenador(cont: context, pageName: 'colaborador'),
        body: Column(children: [
          DefaultTable(items: data, iconActions: const []),
          PrimaryButton(
              text: 'Novo',
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ColaboradoresC()))
                  })
        ]));
  }
}

class ColaboradoresC extends StatefulWidget {
  const ColaboradoresC({super.key});

  @override
  ColaboradoresCState createState() => ColaboradoresCState();
}

class ColaboradoresCState extends State<ColaboradoresC> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String tipo = tipos.first;

  Future<void> criaUsuario() async {
    try {
      var url = Uri.parse(
          'http://${NetConfig.link}/users/?email=${emailController.text}&senha=${senhaController.text}&name=${nameController.text}&tipo=$tipo');
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
      appBar: const TopBar(text: 'Criar novo usuario'),
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
