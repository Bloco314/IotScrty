import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';

class Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(5),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Prof. Jonathas Silva',
              style: TextStyle(
                  color: PersonalColors.darkerGreen,
                  decoration: TextDecoration.none)),
          Text('José Manuel',
              style: TextStyle(
                  color: PersonalColors.darkerGreen,
                  decoration: TextDecoration.none)),
          Text('Luis Henrique',
              style: TextStyle(
                  color: PersonalColors.darkerGreen,
                  decoration: TextDecoration.none)),
          Text('Lucas Migliorin',
              style: TextStyle(
                  color: PersonalColors.darkerGreen,
                  decoration: TextDecoration.none))
        ]));
  }
}
