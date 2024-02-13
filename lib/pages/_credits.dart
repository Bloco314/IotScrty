import 'package:flutter/material.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/text.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
            color: Colors.black,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Texto(
                  size: 20, text: 'Prof. Jonathas Silva', cor: Colors.white),
              const Texto(size: 20, text: 'José Manuel', cor: Colors.white),
              const Texto(size: 20, text: 'Luis Henrique', cor: Colors.white),
              const Texto(size: 20, text: 'Lucas Migliorin', cor: Colors.white),
              const SizedBox(height: 20),
              GenericButton(
                  color: Colors.green,
                  icon: Icons.arrow_back,
                  text: '',
                  onPressed: () => {Navigator.pop(context)})
            ])));
  }
}
