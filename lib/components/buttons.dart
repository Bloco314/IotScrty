import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  DefaultButton({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: PersonalColors.primaryGreen,
            shape: const LinearBorder()),
        child: Text(text));
  }
}

class TableButton extends StatelessWidget {
  final IconData icone;
  final VoidCallback? onPressed;

  TableButton({required this.icone, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          minimumSize: const Size(10.0, 10.0),
          maximumSize: const Size(10.0, 50.0),
          shape: LinearBorder()),
      child: Icon(icone, size: 30.0, color: Colors.black),
    );
  }
}
