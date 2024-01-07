import 'package:flutter/material.dart';

/*
DefaultTable é uma tabela expansiva  que associa botões e ações
*/
class DefaultTable extends StatelessWidget {
  final List<String> headerTexts;
  final List<String> items;
  final List<Function(BuildContext context, String)> actions;
  final List<IconData> icones;

  DefaultTable({
    required this.headerTexts,
    required this.items,
    required this.actions,
    required this.icones,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Cabeçalho
      Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            ...headerTexts.map((txt) => HeaderCell(text: txt)).toList(),
          ])
        ],
      ),
      // Corpo
      Table(
        border: TableBorder.all(color: Colors.black),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: items.asMap().entries.map((entry) {
          int index = entry.key;

          return TableRow(
            decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
            ),
            children: [
              TableCell(child: Center(child: BodyCell(text: entry.value))),
              ...actions.asMap().entries.map((actionEntry) {
                int actionIndex = actionEntry.key;
                IconData icon = icones[actionIndex];

                return TableCell(
                  child: TableButton(
                    icon: icon,
                    onPressed: () =>
                        actions[actionIndex](context, 'Ambiente ${index + 1}'),
                  ),
                );
              }).toList(),
            ],
          );
        }).toList(),
      )
    ]);
  }
}

class BodyCell extends StatelessWidget {
  final String text;

  const BodyCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
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
            child: Text(text,
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center)));
  }
}
