import 'package:flutter/material.dart';

class CampoCadastro extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool border;

  CampoCadastro(
      {required this.labelText, required this.controller, this.border = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: labelText,
              border: border
                  ? const OutlineInputBorder(borderRadius: BorderRadius.zero)
                  : InputBorder.none,
            ),
            controller: controller,
          ),
        ));
  }
}
