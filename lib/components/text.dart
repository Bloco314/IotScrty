import "package:flutter/material.dart";

class Texto extends StatelessWidget {
  final String text;
  final double size;
  final Color cor;

  Texto({required this.size, required this.text, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: cor, fontSize: size, decoration: TextDecoration.none),
      textAlign: TextAlign.center,
    );
  }
}
