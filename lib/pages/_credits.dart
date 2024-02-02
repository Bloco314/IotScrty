import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';

class Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Prof. Jonathas Silva',
              style: TextStyle(
                  color: PersonalColors.darkerGreen,
                  decoration: TextDecoration.none,
                  fontSize: 20.0)),
          const Text('José Manuel',
              style: TextStyle(
                  color: PersonalColors.darkerGreen,
                  decoration: TextDecoration.none,
                  fontSize: 20.0)),
          const Text('Luis Henrique',
              style: TextStyle(
                  color: PersonalColors.darkerGreen,
                  decoration: TextDecoration.none,
                  fontSize: 20.0)),
          const Text('Lucas Migliorin',
              style: TextStyle(
                  color: PersonalColors.darkerGreen,
                  decoration: TextDecoration.none,
                  fontSize: 20.0)),
          const SizedBox(height: 20),
          PrimaryButton(
              text: 'voltar', onPressed: () => {Navigator.pop(context)})
        ]));
  }
}
