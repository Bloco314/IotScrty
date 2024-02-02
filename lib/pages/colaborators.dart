import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/input_fields.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/top_bar.dart';

import 'package:http/http.dart' as http;
import 'package:iot_scrty/constants.dart';

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
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String tipo = tipos.first;
  String mensagem = '';

  ColaboradoresState({required this.email, required this.nome});

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
          mensagem = 'Criado com sucesso!';
        });
      } else {
        mensagem = 'Houve um erro';
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCoordenador(
          nome: nome, email: email, cont: context, pageName: 'colaboradores'),
      appBar: TopBar(text: 'Colaboradores'),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Criar novo usuario', style: TextStyle(fontSize: 20)),
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
        Text(mensagem),
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
