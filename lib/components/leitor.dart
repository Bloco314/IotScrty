import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Leitor extends StatelessWidget {
  const Leitor({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileScanner(onDetect: (capture) {
      final result = capture.barcodes[0].rawValue.toString();
      Navigator.pop(context, result);
    });
  }
}
