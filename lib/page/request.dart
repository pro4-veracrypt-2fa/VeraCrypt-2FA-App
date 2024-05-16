import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veracrypt_2fa_app/api.dart';
import 'package:veracrypt_2fa_app/snackbar.dart';
import 'package:veracrypt_2fa_app/widget/app_bar.dart';

class IncomingRequestPage extends StatefulWidget {
  const IncomingRequestPage({super.key});

  @override
  State<IncomingRequestPage> createState() => _IncomingRequestPageState();
}

class _IncomingRequestPageState extends State<IncomingRequestPage> {
  Future<void> _verify() async {
    var comparisonCode = _comparisonCodeController.text;
    if (comparisonCode.isEmpty) {
      await Snackbar.showAsync(
          context, "Bitte geben Sie den Vergleichswert ein");
      return;
    }

    var verified = await API.verify(comparisonCode);
    if (verified) {
      await Snackbar.showAsync(context, "Start autorisiert");
    } else {
      await Snackbar.showAsync(context, "Ungültiger Vergleichswert");
    }

    GoRouter.of(context).pop();
  }

  final _comparisonCodeController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();

    API.pull().then((comparisonCode) {
      if (comparisonCode != null) {
        _comparisonCodeController.text = comparisonCode;
      }
      else {
        GoRouter.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_comparisonCodeController.text.isEmpty) {
      return const Scaffold(
        appBar: VeraCryptAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
              Text("Lade ausstehende Anfragen ..."),
            ],
          ),
        ),
      );
    }

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
                const Padding(padding: EdgeInsets.fromLTRB(0, 32, 0, 0)),
                const Text(
                  "Geben Sie zum Start den Vergleichswert ein",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: "Vergleichswert",
                        border: OutlineInputBorder(),
                      ),
                      controller: _comparisonCodeController,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(16, 0, 16, 0)),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () => _verify(),
                      color: Colors.teal.shade500,
                      textColor: Colors.white,
                      child: const Text("Senden"),
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
