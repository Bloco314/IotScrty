import 'package:flutter/material.dart';
import 'package:iot_scrty/assets/colors.dart';

class HeaderCell extends StatelessWidget {
  final String text;

  HeaderCell({required this.text});
  @override
  Widget build(BuildContext context) {
    return TableCell(child: Container(color: PersonalColors.backgroundGrey, child: Text(text)));
  }
}
