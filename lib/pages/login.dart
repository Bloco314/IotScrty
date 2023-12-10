import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/input_fields.dart';
import 'package:iot_scrty/components/top_bar.dart';
import 'package:iot_scrty/pages/_home_coordenador.dart';
import 'package:iot_scrty/pages/_home_professor.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final key = 'LoginS';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void validarLogin(context) {
    if (_emailController.text != 'professor') {
      navigateTo(
          context,
          HomeCState(
              email: _emailController.text, nome: _passwordController.text));
    } else {
      navigateTo(
          context,
          HomePState(
              email: _emailController.text, nome: _passwordController.text));
    }
  }

  void navigateTo(context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void criarConta() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(text: 'Login'),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7.5)),
                  color: PersonalColors.backgroundGrey),
              child: Column(children: [
                CampoCadastro(labelText: 'email', controller: _emailController),
                const SizedBox(height: 16.0),
                CampoCadastro(
                    labelText: 'senha', controller: _passwordController)
              ]),
            ),
            PrimaryButton(
                text: 'Entrar', onPressed: () => validarLogin(context)),
            GenericButton(
                text: 'Esqueceu sua senha?',
                width: 200,
                height: 30,
                onPressed: () => criarConta(),
                color: Colors.transparent,
                textColor: Colors.grey)
          ],
        ),
      ),
    );
  }
}
