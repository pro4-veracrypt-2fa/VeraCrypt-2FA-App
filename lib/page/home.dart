import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veracrypt_2fa_app/Routes.dart';
import 'package:veracrypt_2fa_app/widget/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VeraCryptAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.computer,
              size: 100,
              color: Colors.grey.shade800,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verbunden mit',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                ),
                Text(
                  'Robin\'s PC',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 128, 0, 0)),
            const Text("Aktuell sind keine Anfragen vorhanden."),
            MaterialButton(
              onPressed: () => {
                GoRouter.of(context).push(Routes.incomingRequest),
              },
              child: const Text("Test"),
            ),
          ],
        ),
      ),
    );
  }
}