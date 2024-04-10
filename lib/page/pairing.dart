import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:veracrypt_2fa_app/widget/app_bar.dart';
import 'package:veracrypt_2fa_app/widget/first_steps.dart';
import 'package:veracrypt_2fa_app/widget/qr_code_controls.dart';
import 'package:veracrypt_2fa_app/widget/qr_code_scanner.dart';

// ignore: must_be_immutable
class PairingPage extends StatelessWidget {
  MobileScannerController cameraController = MobileScannerController();

  PairingPage({super.key});

  _pairingCodeScanned(BuildContext context, BarcodeCapture capture) async {
    if (capture.barcodes.isEmpty || capture.barcodes.first.rawValue == null) {
      return;
    }

    // Retrieve device identifier
    var pairingCode = capture.barcodes.first.rawValue!;
  }

  @override
  Widget build(BuildContext context) {
    // API.isPaired().then((isPaired) {
    //   if (isPaired) {
    //     context.go(Routes.profile);
    //   }
    // });

    return Scaffold(
      appBar: const VeraCryptAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                QrCodeScanner(
                  cameraController: cameraController,
                  onScan: (capture) => _pairingCodeScanned(context, capture),
                ),
                QrCodeControls(cameraController: cameraController),
              ],
            ),
          ),
          const FirstSteps(),
        ],
      ),
    );
  }
}