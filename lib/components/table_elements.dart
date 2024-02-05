import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/text.dart';

/*
DefaultTable é uma tabela expansiva  que associa botões e ações
*/
class DefaultTable extends StatelessWidget {
  final List<String> headerTexts;
  final List<String> items;
  final List<String>? secItems;
  final List<Function(BuildContext context, String)> actions;
  final List<IconData> icones;

  DefaultTable({
    required this.headerTexts,
    required this.items,
    this.secItems,
    required this.actions,
    required this.icones,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 120),
          child: Center(
              child:
                  Texto(text: 'Sem cadastros.', size: 20, cor: Colors.black)));
    }
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(children: [
          // Cabeçalho
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children:
                    headerTexts.map((txt) => HeaderCell(text: txt)).toList(),
              )
            ],
          ),
          // Corpo
          Table(
            border: TableBorder.all(color: Colors.black),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: items.asMap().entries.map((entry) {
              int index = entry.key;

              return TableRow(
                children: [
                  //item principal, primeira coluna
                  TableCell(child: Center(child: BodyCell(text: entry.value))),
                  //item secundario, se houver, segunda coluna
                  if (secItems != null && index < secItems!.length)
                    TableCell(
                      child: Center(
                        child: BodyCell(text: secItems![index]),
                      ),
                    ),
                  //resto da tabela definido pelos icones e suas ações
                  ...actions.asMap().entries.map((actionEntry) {
                    int actionIndex = actionEntry.key;
                    IconData icon = icones[actionIndex];

                    return TableCell(
                      child: TableButton(
                        icon: icon,
                        onPressed: () =>
                            actions[actionIndex](context, entry.value),
                      ),
                    );
                  }).toList(),
                ],
              );
            }).toList(),
          )
        ]));
  }
}

class TableButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const TableButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
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

  const BodyCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Texto(
          size: textSize(text.length),
          text: text,
          cor: PersonalColors.darkerGreen),
    );
  }
}

class HeaderCell extends StatelessWidget {
  final String text;

  HeaderCell({required this.text});
  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                border: Border(
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black))),
            child: Texto(
                size: textSize(text.length), text: text, cor: Colors.black)));
  }
}
