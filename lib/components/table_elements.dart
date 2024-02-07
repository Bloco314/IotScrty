import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/text.dart';

class DefaultTable extends StatelessWidget {
  final List<List<String>> items;
  final List<IconAction> iconActions;

  const DefaultTable({
    super.key,
    required this.items,
    required this.iconActions,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 120),
        child: Center(
          child: Text(
            'Sem cadastros.',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      );
    }

    List<String> headerTexts = items.first;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          // Cabeçalho
          Table(
            border: TableBorder.all(color: Colors.black),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children:
                    headerTexts.map((txt) => HeaderCell(text: txt)).toList(),
              ),
            ],
          ),
          const SizedBox(height: 2),
          // Corpo da tabela
          Table(
            border: TableBorder.all(color: Colors.black),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: items.skip(1).map((row) {
              return TableRow(
                children: [
                  ...row.map(
                    (cellText) => TableCell(
                      child: Center(child: BodyCell(text: cellText)),
                    ),
                  ),
                  ...iconActions.map(
                    (iconAction) => TableCell(
                      child: TableButton(
                        icon: iconAction.icon,
                        onPressed: () =>
                            iconAction.action(context, row.join(',')),
                        text: iconAction.text,
                      ),
                    ),
                  )
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}



double textSize(length) {
  return length > 20
      ? 10
      : length >= 12
          ? 14
          : 18;
}

class BodyCell extends StatelessWidget {
  final String text;

  const BodyCell({super.key, required this.text});

  @override 
  Widget build(BuildContext context) {
    return Texto(
        size: textSize(text.length),
        text: text,
        cor: PersonalColors.darkerGreen);
  }
}

class HeaderCell extends StatelessWidget {
  final String text;

  const HeaderCell({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Container(
            color: PersonalColors.green,
            height: 50,
            alignment: Alignment.center,
            child: Texto(
                size: textSize(text.length),
                text: text,
                cor: PersonalColors.darkerGreen)));
  }
}
