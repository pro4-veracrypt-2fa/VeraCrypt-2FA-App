import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veracrypt_2fa_app/widget/app_bar.dart';

class IncomingRequestPage extends StatefulWidget {
  const IncomingRequestPage({super.key});

  @override
  State<IncomingRequestPage> createState() => _IncomingRequestPageState();
}

class _IncomingRequestPageState extends State<IncomingRequestPage> {

  Future<void> _reject() async {
    GoRouter.of(context).pop();
  }

  Future<void> _accept() async {
    GoRouter.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VeraCryptAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.warning_outlined,
              size: 100,
              color: Colors.grey.shade800,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(0, 32, 0, 0)),
                const Text(
                  "Möchten Sie den Start von ",
                  style: TextStyle(fontSize: 16),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
                Text(
                  "Robin's PC",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.teal.shade600),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
                const Text(
                  "autorisieren?",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 128, 32, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () => _accept(),
                      color: Colors.green.shade600,
                      textColor: Colors.white,
                      child: const Text("Zulassen"),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(16, 0, 16, 0)),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () => _reject(),
                      color: Colors.red.shade600,
                      textColor: Colors.white,
                      child: const Text("Ablehnen"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
