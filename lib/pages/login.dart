import 'package:flutter/material.dart';
import 'package:iot_scrty/components/campo_cadastro.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import '../pages/cad_enviroment.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final key = 'LoginS';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void telaCadEnviroment(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CadEnviroment()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CampoCadastro(labelText: 'email', controller: _emailController),
            const SizedBox(height: 16.0),
            CampoCadastro(labelText: 'senha', controller: _passwordController),
            const SizedBox(height: 32.0),
            ElevatedButton(
                onPressed: () => {telaCadEnviroment(context)},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(74, 188, 216, 1),
                    shape: const LinearBorder()),
                child: const Text('Entrar')),
          ],
        ),
      ),
    );
  }
}
