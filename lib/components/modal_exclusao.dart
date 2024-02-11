import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/text.dart';

class ModalConfirmarExclusao extends StatelessWidget {
  final String envName;

  const ModalConfirmarExclusao({super.key, required this.envName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        title: Texto(text: 'Confirmação', size: 22, cor: Colors.black),
        content: SizedBox(
            height: 80,
            child: Texto(
              text: 'Você tem certeza que deseja excluir $envName?',
              size: 16,
              cor: PersonalColors.red,
            )),
        actions: [
          PrimaryButton(
              text: 'Confimar',
              height: 40,
              onPressed: () => Navigator.pop(context, true)),
          SecondaryButton(
              text: 'Cancelar',
              height: 40,
              onPressed: () => Navigator.pop(context, false))
        ],
        actionsAlignment: MainAxisAlignment.center);
  }
}
