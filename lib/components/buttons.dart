import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';

class GenericButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final double? width;
  final double? height;
  final Color? textColor;
  final IconData? icon;

  GenericButton(
      {required this.text,
      this.onPressed,
      this.color,
      this.height,
      this.width,
      this.textColor,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 120,
      height: height ?? 50,
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: color,
          shape: const LinearBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (text.isNotEmpty)
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor),
                ),
              ),
            if (icon != null) Icon(icon),
          ],
        ),
      ),
    );
  }
}

class PrimaryButton extends GenericButton {
  PrimaryButton(
      {required String text,
      VoidCallback? onPressed,
      double? width,
      double? height,
      IconData? icon})
      : super(
            text: text,
            onPressed: onPressed,
            height: height,
            width: width,
            color: PersonalColors.green,
            icon: icon);
}

class SecondaryButton extends GenericButton {
  SecondaryButton(
      {required String text,
      VoidCallback? onPressed,
      double? width,
      double? height})
      : super(
            text: text,
            onPressed: onPressed,
            height: height,
            width: width,
            color: PersonalColors.red);
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
