import 'package:flutter/material.dart';

class CampoCadastro extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool border;
  final bool enabled;
  final double? width;
  final double? height;
  final TextInputType? tipo;
  final bool? obscure;

  const CampoCadastro(
      {super.key,
      required this.labelText,
      required this.controller,
      this.border = true,
      this.enabled = true,
      this.width,
      this.height,
      this.tipo,
      this.obscure = false});

  void validacao(value) {}

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? 50,
          decoration: const BoxDecoration(color: Colors.white),
          child: TextFormField(
              enabled: enabled,
              obscureText: obscure!,
              decoration: InputDecoration(
                labelText: labelText,
                border: border
                    ? const OutlineInputBorder(borderRadius: BorderRadius.zero)
                    : InputBorder.none,
              ),
              keyboardType: tipo ?? TextInputType.name,
              controller: controller,
              onChanged: validacao),
        ));
  }
}

class InputHorario extends CampoCadastro {
  final bool validaHora;

  const InputHorario(this.validaHora,
      {super.key,
      required super.labelText,
      required super.controller,
      super.width,
      super.height,
      super.tipo = TextInputType.number});

  @override
  void validacao(value) {
    RegExp regex;

    if (validaHora) {
      regex = RegExp(r'^([01]?[0-9]|2[0-4])$');
    } else {
      regex = RegExp(r'^(?:[0-9]|[1-4][0-9]|5[0-9])$');
    }

    if (!regex.hasMatch(value)) {
      controller.text = controller.text.substring(
          0, controller.text.length - 1 >= 0 ? controller.text.length - 1 : 0);
    }
  }
}

class HoraMinuto extends StatelessWidget {
  final TextEditingController hora;
  final TextEditingController minuto;

  const HoraMinuto({super.key, required this.hora, required this.minuto});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      InputHorario(true,
          labelText: 'HH', controller: hora, width: 80, height: 50),
      const Text(':'),
      InputHorario(false,
          labelText: 'MM', controller: minuto, width: 80, height: 50),
    ]);
  }
}
