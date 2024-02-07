import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';

class IconAction {
  final IconData icon;
  final Function(BuildContext context, String) action;
  final String text;

  IconAction({
    required this.icon,
    required this.action,
    required this.text,
  });
}

class GenericButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final double? width;
  final double? height;
  final Color? textColor;
  final IconData? icon;
  final Color? iconColor;
  final double radius;
  final double? margin;

  GenericButton(
      {required this.text,
      this.onPressed,
      this.color,
      this.height,
      this.width,
      this.textColor,
      this.icon,
      this.iconColor = Colors.white,
      this.radius = 0,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 120,
      height: height ?? 50,
      margin: EdgeInsets.all(margin ?? 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            foregroundColor: Colors.white,
            backgroundColor: color,
            shape: radius == 0
                ? const LinearBorder()
                : OvalBorder(eccentricity: radius)),
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
            if (icon != null) Icon(icon, color: iconColor),
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
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const TableButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        child: IconButton.filled(
          onPressed: onPressed,
          icon: Icon(icon),
          iconSize: 30,
          tooltip: text,
          mouseCursor: MaterialStateMouseCursor.clickable,
          color: PersonalColors.darkerGreen,
          style: ButtonStyle(
              side: MaterialStateProperty.resolveWith(
                  (states) => const BorderSide(color: Colors.black)),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => PersonalColors.smoothWhite)),
        ));
  }
}
