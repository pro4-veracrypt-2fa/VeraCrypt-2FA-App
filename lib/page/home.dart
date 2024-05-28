import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veracrypt_2fa_app/Routes.dart';
import 'package:veracrypt_2fa_app/api.dart';
import 'package:veracrypt_2fa_app/widget/app_bar.dart';
import 'package:veracrypt_2fa_app/snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _handleRefresh(BuildContext context) async {
    var pullResult = await API.pull();
    if (pullResult == null) {
      // ignore: use_build_context_synchronously
      Snackbar.show(context, "Keine ausstehenden Anfragen.");
    } else {
      // ignore: use_build_context_synchronously
      GoRouter.of(context).push(Routes.incomingRequest);
    }
  }

  @override
  Widget build(BuildContext context) {
    var partnerPcName = API.partnerPCName;

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
            partnerPcName != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Verbunden mit',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                      ),
                      Text(
                        partnerPcName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : const Text("Noch nicht mit einem Computer verbunden."),
            const Padding(padding: EdgeInsets.fromLTRB(0, 128, 0, 0)),
            const Text("Aktuell sind keine Anfragen vorhanden."),
            const Padding(padding: EdgeInsets.fromLTRB(0, 64, 0, 0)),
            MaterialButton(
              onPressed: () => {_handleRefresh(context)},
              color: Colors.teal.shade600,
              child: const Text("Refresh",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            MaterialButton(
              onPressed: () => {
                setState(() {
                  GoRouter.of(context).push(Routes.pairing);
                })
              },
              child: const Text("Setup Test"),
            ),
          ],
        ),
      ),
    );
  }
}
