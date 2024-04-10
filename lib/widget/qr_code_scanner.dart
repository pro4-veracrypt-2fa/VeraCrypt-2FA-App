import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

typedef QrCodeScanCallback = Future<void> Function(BarcodeCapture);

/// A widget that provides a QR code scanner functionality.
///
/// The [QrCodeScanner] widget allows users to scan QR codes using the provided [cameraController].
/// The [onScan] callback is triggered when a QR code is successfully scanned.
/// The [coolDownSeconds] parameter specifies the cooldown period in seconds between consecutive scans.
class QrCodeScanner extends StatefulWidget {
  final MobileScannerController cameraController;
  final QrCodeScanCallback onScan;
  final int coolDownSeconds;

  const QrCodeScanner({
    Key? key,
    required this.cameraController,
    required this.onScan,
    this.coolDownSeconds = 2,
  });

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  DateTime? _lastScanTime;

  _onScan(BarcodeCapture capture) async {
    // Make sure that the scan is not triggered too often
    final currentScanTime = DateTime.now();
    if (_lastScanTime == null ||
        currentScanTime.difference(_lastScanTime!) >
            Duration(seconds: widget.coolDownSeconds)) {
      _lastScanTime = currentScanTime;
      await widget.onScan(capture);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: widget.cameraController,
      onDetect: (capture) async => await _onScan(capture),
    );
  }
}