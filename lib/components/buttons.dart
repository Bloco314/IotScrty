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
  final double? width;
  final double? height;
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final Color? color;
  final double radius;

  const GenericButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.color,
      this.height,
      this.width,
      this.textColor = Colors.white,
      this.icon,
      this.iconColor = Colors.white,
      this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 120,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            foregroundColor: textColor,
            backgroundColor: color,
            shape: radius == 0
                ? const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)))
                : OvalBorder(
                    eccentricity: radius,
                    side: const BorderSide(color: Colors.black))),
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
  const PrimaryButton(
      {super.key,
      required super.text,
      super.onPressed,
      super.width,
      super.height,
      super.icon})
      : super(color: PersonalColors.green);
}

class SecondaryButton extends GenericButton {
  const SecondaryButton(
      {super.key,
      required super.text,
      super.onPressed,
      super.width,
      super.height})
      : super(color: PersonalColors.red);
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
        decoration: BoxDecoration(
            border: Border.all(color: PersonalColors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        child: GenericButton(
            text: text.length <= 4 ? text : text.substring(0, 4),
            onPressed: onPressed,
            icon: icon,
            iconColor: PersonalColors.darkerGreen,
            textColor: PersonalColors.darkerGreen,
            color: PersonalColors.smoothWhite,
            height: 45,
            width: 105));
  }
}
