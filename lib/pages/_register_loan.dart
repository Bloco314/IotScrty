import 'package:flutter/material.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/leitor.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/top_bar.dart';

class CheckinEquip extends StatefulWidget {
  final String nome;
  final String email;

  CheckinEquip({required this.email, required this.nome});

  @override
  StateCheckinEquip createState() =>
      StateCheckinEquip(email: email, nome: nome);
}

class StateCheckinEquip extends State<CheckinEquip> {
  final String nome;
  final String email;
  String matricula = '';
  bool leu = false;

  StateCheckinEquip({required this.email, required this.nome});

  Future<void> openReader(context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Leitor()),
    );

    if (!mounted) return;

    setState(() {
      matricula = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarProfessor(
        cont: context,
        pageName: 'Checkin',
        nome: nome,
        email: email,
      ),
      appBar: TopBar(text: 'Leitor'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Matricula: $matricula"),
            PrimaryButton(
              text: 'Ler',
              icon: Icons.qr_code,
              onPressed: () => openReader(context),
            ),
          ],
        ),
      ),
    );
  }
}
