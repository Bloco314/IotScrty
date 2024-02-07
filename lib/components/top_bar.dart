import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const TopBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              PersonalColors.green,
              Color.fromARGB(255, 43, 112, 39),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(color: PersonalColors.darkerGreen),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
