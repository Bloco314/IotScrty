import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/input_fields.dart';
import 'package:iot_scrty/components/top_bar.dart';
import 'package:iot_scrty/constants.dart';
import 'package:iot_scrty/pages/_home_page.dart';
import 'package:iot_scrty/pages/_recoverPassword.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Login({super.key});

  void validarLogin(context) async {
    try {
      if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
        Fluttertoast.showToast(msg: 'Por favor, preencha os campos');
        return;
      }

      var url = Uri.parse(
          'http://${NetConfig.Link}/users/login/${_emailController.text}/${_passwordController.text}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decode = json.decode(response.body);
        if (decode["tipo"] == 'coordenador') {
          _emailController.text = '';
          _passwordController.text = '';
          navigateTo(context, HomePage(coord: true));
        } else if (decode["tipo"] == 'professor') {
          _emailController.text = '';
          _passwordController.text = '';
          navigateTo(context, HomePage(coord: false));
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Houve um erro');
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
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7.5)),
                  color: PersonalColors.lightGrey),
              child: Column(children: [
                CampoCadastro(
                  labelText: 'email',
                  controller: _emailController,
                  tipo: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16.0),
                CampoCadastro(
                    labelText: 'senha',
                    controller: _passwordController,
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
                onPressed: () => navigateTo(context, Recover()),
                color: Colors.transparent,
                textColor: Colors.grey)
          ],
        ),
      ),
    );
  }
}
