import 'package:flutter/material.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/text.dart';

class Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
            color: Colors.black,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Texto(size: 20, text: 'Prof. Jonathas Silva', cor: Colors.white),
              Texto(size: 20, text: 'José Manuel', cor: Colors.white),
              Texto(size: 20, text: 'Luis Henrique', cor: Colors.white),
              Texto(size: 20, text: 'Lucas Migliorin', cor: Colors.white),
              const SizedBox(height: 20),
              GenericButton(
                  color: Colors.green,
                  icon: Icons.arrow_back,
                  text: '',
                  onPressed: () => {Navigator.pop(context)})
            ])));
  }
}
