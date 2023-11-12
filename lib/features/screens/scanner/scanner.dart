import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerQR extends StatelessWidget {
  const ScannerQR({super.key, Key? key1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MobileScanner(
        fit: BoxFit.contain,
        controller: MobileScannerController(
          facing: CameraFacing.back,
          torchEnabled: false,
          returnImage: true,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;

          for (final barcode in barcodes) {
            debugPrint('Barcode found! ${barcode.rawValue}');

            // Navigate to a new page when a barcode is detected
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => BarcodeDetailsScreen(
            //       barcodeValue: barcode.rawValue,
            //       capturedImage: image,
            //     ),
            //   ),
            // );
          }
        },
      ),
    );
  }
}


