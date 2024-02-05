import 'package:flutter/material.dart';

class CampoCadastro extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool border;
  final bool enabled;

  CampoCadastro(
      {required this.labelText, required this.controller, this.border = true, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: TextFormField(
            enabled: enabled,
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
