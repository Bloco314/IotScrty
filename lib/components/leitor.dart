import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Leitor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MobileScanner(onDetect: (capture) {
      Navigator.pop(context, capture.barcodes[0].rawValue.toString());
    });
  }
}
