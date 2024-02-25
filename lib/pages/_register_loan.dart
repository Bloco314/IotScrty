import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/text.dart';
import 'package:iot_scrty/components/top_bar.dart';
import 'package:iot_scrty/utils.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:http/http.dart' as http;

class CheckinEquip extends StatefulWidget {
  const CheckinEquip({super.key});

  @override
  CheckinEquipState createState() => CheckinEquipState();
}

List<List<String>> lista = [];

class CheckinEquipState extends State<CheckinEquip> {
  String matricula = '';
  String tombo = '';
  bool lendo = true;

  String get currentState {
    if (matricula.isEmpty && tombo.isEmpty) {
      return 'Lendo matricula';
    } else if (matricula.isNotEmpty && tombo.isEmpty) {
      return 'Lendo tombo';
    } else {
      return 'Confirmar';
    }
  }

  void read(capture) {
    String value = capture.barcodes[0].rawValue!;
    if (currentState == 'Lendo matricula') {
      setState(() {
        matricula = value;
        lendo = false;
      });
    } else {
      setState(() {
        tombo = value;
        lendo = false;
      });
    }
  }

  void mainAction() {
    if (currentState == 'Confirmar') {
      setState(() {
        lista.add([matricula, tombo]);
        matricula = '';
        tombo = '';
        lendo = true;
      });
    } else {
      setState(() {
        lendo = true;
      });
    }
  }

  void openModal() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ModalV();
        });
  }

  void finalizar() async {
    lista.add([matricula, tombo]);
    final url = Uri.parse('http://${NetConfig.link}/register/create_many/');
    final body = jsonEncode({'list': lista});
    try {
      final response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final a = json.decode(response.body)['hora'];
        Fluttertoast.showToast(msg: 'Reservado em $a');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Houve um erro');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarProfessor(
        cont: context,
        pageName: 'Checkin',
      ),
      appBar: TopBar(text: currentState),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(children: [
              Texto(
                  size: 16,
                  text: "Matricula: $matricula",
                  cor: PersonalColors.darkerGreen),
              Texto(
                  size: 16,
                  text: "Equipamento: $tombo",
                  cor: PersonalColors.darkerGreen)
            ]),
            IconButton(
                onPressed: openModal, icon: const Icon(Icons.info_outline)),
          ]),
          if (lendo)
            Container(
              height: 300,
              margin: const EdgeInsets.all(5),
              child: MobileScanner(
                fit: BoxFit.fitHeight,
                onDetect: read,
              ),
            ),
          if (!lendo) const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!lendo)
                PrimaryButton(
                  text:
                      currentState == 'Confirmar' ? 'Proximo aluno' : 'Proximo',
                  onPressed: mainAction,
                ),
              if (currentState == 'Confirmar') const SizedBox(width: 20),
              if (currentState == 'Confirmar')
                PrimaryButton(text: 'Finalizar', onPressed: finalizar)
            ],
          )
        ],
      ),
    );
  }
}

class ModalV extends StatelessWidget {
  const ModalV({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Texto(text: 'Registros', size: 22, cor: Colors.black),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Expanded(
                child: ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      return Text('${lista[index].first} ${lista[index].last}',
                          softWrap: false);
                    }))),
        actions: const [],
        actionsAlignment: MainAxisAlignment.center);
  }
}
