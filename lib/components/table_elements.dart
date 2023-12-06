import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';

class HeaderCell extends StatelessWidget {
  final String text;

  HeaderCell({required this.text});
  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Container(
            color: PersonalColors.backgroundGrey,
            child: Text(
              text,
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            )));
  }
}

class BodyCell extends StatelessWidget {
  final String text;

  BodyCell({required this.text});
  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Text(
      text,
      textAlign: TextAlign.center,
    ));
  }
}
