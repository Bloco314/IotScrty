import 'package:flutter/material.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/top_bar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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

    if (result != null && mounted) {
      setState(() {
        matricula = result;
      });
    } else {
      setState(() {
        matricula = '';
      });
    }
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

class Leitor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MobileScanner(onDetect: (capture) {
      final result = capture.barcodes[0].rawValue.toString();
      Navigator.pop(context, result);
    });
  }
}
