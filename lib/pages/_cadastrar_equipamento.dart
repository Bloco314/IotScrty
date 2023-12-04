import 'package:flutter/material.dart';
import 'package:iot_scrty/components/navigation_bar.dart';

class CadEnviroment extends StatefulWidget {
  @override
  CadEnviromentState createState() => CadEnviromentState();
}

class CadEnviromentState extends State<CadEnviroment> {
  final key = 'cadEnvState';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarProfessor(email: 'jmcds',nome: 'jose'),
      appBar: AppBar(
        title: const Text('Cadastrar ambiente'),
        backgroundColor: const Color.fromRGBO(74, 188, 216, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(74, 188, 216, 1)),
                child: const Text('Retorna')),
          ],
        ),
      ),
    );
  }
}
