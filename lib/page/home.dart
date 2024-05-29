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
  late String? _partnerPCName;

  _handleRefresh(BuildContext context) async {
    var pullResult = await API.pull(context);
    if (pullResult == null) {
      // ignore: use_build_context_synchronously
      Snackbar.show(context, "Keine ausstehenden Anfragen.");
    } else {
      // ignore: use_build_context_synchronously
      GoRouter.of(context).push(Routes.incomingRequest);
    }
  }

  @override
  void initState() {
    super.initState();
    _partnerPCName = API.partnerPCName;
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
              Icons.computer,
              size: 100,
              color: Colors.grey.shade800,
            ),
            _partnerPCName != null
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
                        _partnerPCName!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : const Text("Noch nicht mit einem Computer verbunden."),
            const Padding(padding: EdgeInsets.fromLTRB(0, 128, 0, 0)),
            _partnerPCName != null
                ? const Text("Aktuell sind keine Anfragen vorhanden.")
                : Container(),
            const Padding(padding: EdgeInsets.fromLTRB(0, 64, 0, 0)),
            MaterialButton(
              onPressed: () => {_handleRefresh(context)},
              color: Colors.teal.shade600,
              child: const Text("Refresh",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            MaterialButton(
              onPressed: () async => {
                GoRouter.of(context).push(Routes.pairing).then(
                      (_) => {
                        setState(() {
                          _partnerPCName = API.partnerPCName;
                        })
                      },
                    )
              },
              child: const Text("Setup Test"),
            ),
          ],
        ),
      ),
    );
  }
}
