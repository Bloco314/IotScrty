import 'package:iot_scrty/utils.dart';
import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/top_bar.dart';
import 'package:iot_scrty/components/input_fields.dart';
import 'package:iot_scrty/pages/_home_page.dart';
import 'package:iot_scrty/pages/_recover_password.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String? userName;
String? userEmail;

class Login extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController senha = TextEditingController();

  Login({super.key});

  void validarLogin(context) async {
    try {
      if (email.text.isEmpty || senha.text.isEmpty) {
        Fluttertoast.showToast(msg: 'Por favor, preencha os campos');
        return;
      }

      var url = Uri.parse(
          'http://${NetConfig.link}/users/login/${email.text}/${senha.text}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decode = json.decode(response.body);

        if (tipos.contains(decode["tipo"])) {
          userName = decode["name"];
          userEmail = email.text;
          email.text = '';
          senha.text = '';
          navigateTo(context, HomePage(coord: decode["tipo"] == tipos[0]));
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Não foi possível realizar Login');
    }
  }

  void navigateTo(context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(text: 'Login'),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.15,
                  vertical: 10),
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.05,
                  horizontal: 10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7.5)),
                  color: PersonalColors.lightGrey),
              child: Column(children: [
                CampoCadastro(
                  labelText: 'email',
                  controller: email,
                  tipo: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16.0),
                CampoCadastro(
                    labelText: 'senha',
                    controller: senha,
                    tipo: TextInputType.visiblePassword,
                    obscure: true)
              ]),
            ),
            PrimaryButton(
                text: 'Entrar', onPressed: () => validarLogin(context)),
            GenericButton(
                text: 'Esqueceu sua senha?',
                width: 200,
                height: 30,
                onPressed: () => navigateTo(context, const Recover()),
                color: Colors.transparent,
                textColor: Colors.grey)
          ],
        ),
      ),
    );
  }
}
