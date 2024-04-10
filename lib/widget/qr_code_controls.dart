import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// A widget that displays the controls for a QR code scanner.
///
/// This widget is responsible for rendering the torch toggle button and the camera switch button.
/// It takes a [cameraController] as a required parameter, which is used to control the scanner's camera.
/// The [cameraController] should be an instance of [MobileScannerController].
class QrCodeControls extends StatelessWidget {
  const QrCodeControls({
    super.key,
    required this.cameraController,
  });

  final MobileScannerController cameraController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 5,
      bottom: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              padding:
                  MaterialStateProperty.all(const EdgeInsets.all(12)),
              backgroundColor:
                  MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(const CircleBorder()),
            ),
            onPressed: () => cameraController.toggleTorch(),
            child: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off,
                        color: Colors.black, size: 24);
                  case TorchState.on:
                    return const Icon(Icons.flash_on,
                        color: Colors.black, size: 24);
                }
                
              },
            ),
          ),
          const SizedBox(width: 1),
          ElevatedButton(
            style: ButtonStyle(
              padding:
                  MaterialStateProperty.all(const EdgeInsets.all(12)),
              backgroundColor:
                  MaterialStateProperty.all(Colors.teal),
              shape: MaterialStateProperty.all(const CircleBorder()),
            ),
            onPressed: () => cameraController.switchCamera(),
            child: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.cameraswitch,
                        color: Colors.white, size: 24);
                  case CameraFacing.back:
                    return const Icon(Icons.cameraswitch_outlined,
                        color: Colors.white, size: 24);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}