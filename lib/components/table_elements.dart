import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/text.dart';

class DefaultTable extends StatelessWidget {
  final List<List<String>> items;
  final List<IconAction> iconActions;
  final bool cardmode;

  const DefaultTable({
    super.key,
    required this.items,
    required this.iconActions,
    this.cardmode = false,
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

    if (cardmode) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length - 1,
              itemBuilder: (context, index) {
                List<String> row = items[index + 1];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: ListTile(
                    title: Texto(
                        text: row.first,
                        size: 18,
                        cor: PersonalColors.darkerGreen),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ...iconActions.map((iconAction) => TableButton(
                            icon: iconAction.icon,
                            onPressed: () =>
                                iconAction.action(context, row.first),
                            text: iconAction.text)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
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
                              iconAction.action(context, row.first),
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
