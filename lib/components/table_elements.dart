import 'package:flutter/material.dart';

class DefaultTable extends StatelessWidget {
  final List<String> items;
  final Function(BuildContext context, String) primaryAction;
  final Function(BuildContext context, String) secondaryAction;
  final IconData primaryIcon;
  final IconData secondaryIcon;

  DefaultTable({
    required this.primaryIcon,
    required this.secondaryIcon,
    required this.items,
    required this.primaryAction,
    required this.secondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: items.asMap().entries.map((entry) {
        int index = entry.key;

        return TableRow(
          decoration: BoxDecoration(
            color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
          ),
          children: [
            TableCell(
              child: BodyCell(text: entry.value),
            ),
            TableCell(
              child: TableButton(
                icon: primaryIcon,
                onPressed: () =>
                    primaryAction(context, 'Ambiente ${index + 1}'),
              ),
            ),
            TableCell(
              child: TableButton(
                icon: secondaryIcon,
                onPressed: () =>
                    secondaryAction(context, 'Ambiente ${index + 1}'),
              ),
            ),
          ],
        );
      }).toList(),
    );
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
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center)));
  }
}
