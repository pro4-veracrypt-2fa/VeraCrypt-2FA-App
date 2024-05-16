import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:veracrypt_2fa_app/api.dart';
import 'package:veracrypt_2fa_app/routes.dart';
import 'package:veracrypt_2fa_app/snackbar.dart';
import 'package:veracrypt_2fa_app/widget/app_bar.dart';
import 'package:veracrypt_2fa_app/widget/first_steps.dart';
import 'package:veracrypt_2fa_app/widget/qr_code_controls.dart';
import 'package:veracrypt_2fa_app/widget/qr_code_scanner.dart';

// ignore: must_be_immutable
class PairingPage extends StatelessWidget {
  MobileScannerController cameraController = MobileScannerController();

  PairingPage({super.key});

  final _pairingCodeController = TextEditingController();

  _pairingCodeScanned(BuildContext context, BarcodeCapture capture) async {
    print("barcodes: ${capture.barcodes}");
    if (capture.barcodes.isEmpty || capture.barcodes.first.rawValue == null) {
      return;
    }

    // Retrieve device identifier
    var pairingCode = capture.barcodes.first.rawValue!;
    print("pairing code: $pairingCode");
    _pair(context, pairingCode);
  }

  _pair(BuildContext context, String pairingCode) async {
    var partnerPcName = await API.pair(pairingCode);
    if (partnerPcName != null) {
      Future.delayed(Duration.zero, () async => GoRouter.of(context).go(Routes.home));
    }
    else {
      Snackbar.showAsync(context, "Ungültiger Pairing-Code.");
    }
  }

  @override
  Widget build(BuildContext context) {

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
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: "Pairing-Code (Temporär)",
                        border: OutlineInputBorder(),
                      ),
                      controller: _pairingCodeController,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(16, 0, 16, 0)),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () => _pair(context, _pairingCodeController.text.trim()),
                      color: Colors.teal.shade500,
                      textColor: Colors.white,
                      child: const Text("Senden"),
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}