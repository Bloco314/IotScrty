import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/campo_cadastro.dart';
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

  void homeProfessor(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePState(
                  email: _emailController.text,
                  nome: _passwordController.text,
                )));
  }

  void homeCoordenador(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeCState(
                  email: _emailController.text,
                  nome: _passwordController.text,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: PersonalColors.primaryGreen,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: PersonalColors.backgroundGrey,
              child: Column(children: [
                const SizedBox(height: 16.0),
                CampoCadastro(labelText: 'email', controller: _emailController),
                const SizedBox(height: 16.0),
                CampoCadastro(
                    labelText: 'senha', controller: _passwordController),
                const SizedBox(height: 32.0),
              ]),
            ),
            ElevatedButton(
                onPressed: () => {homeProfessor(context)},
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: PersonalColors.primaryGreen,
                    shape: const LinearBorder()),
                child: const Text('Entrar')),
          ],
        ),
      ),
    );
  }
}
