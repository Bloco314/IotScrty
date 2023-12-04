import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String nome;

  TopBar({required this.nome});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Bem-vindo $nome"),
      backgroundColor: PersonalColors.primaryGreen,
      foregroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
