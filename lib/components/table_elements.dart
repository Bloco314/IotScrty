import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';

class HeaderCell extends StatelessWidget {
  final String text;

  HeaderCell({required this.text});
  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black))),
            child: Text(text,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center)));
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

class BoxCell extends StatelessWidget {
  final StatelessWidget? wi;

  BoxCell({this.wi});

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.black),
              left: BorderSide(color: Colors.black),
              right: BorderSide(color: Colors.black),
              top: BorderSide(color: Colors.black))),
      child: wi,
    ));
  }
}
