import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/input_fields.dart';
import 'package:iot_scrty/components/top_bar.dart';

class Recover extends StatefulWidget {
  const Recover({super.key});

  @override
  RecoverState createState() => RecoverState();
}

class RecoverState extends State<Recover> {
  final TextEditingController email = TextEditingController();

  void send() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBar(text: 'Recuperar senha'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Informe o seu e-mail para recuperar a senha:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              CampoCadastro(controller: email, labelText: ''),
              const SizedBox(height: 20),
              GenericButton(
                  text: 'Enviar instruções',
                  color: PersonalColors.red,
                  width: 200,
                  height: 40,
                  onPressed: () => send()),
            ],
          ),
        ));
  }
}
