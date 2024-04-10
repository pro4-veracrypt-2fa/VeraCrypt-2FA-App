import 'package:flutter/material.dart';

/// This is the [FirstSteps] widget, which displays a series of steps for the user to follow.
/// It is typically used in the login screen of the application.
class FirstSteps extends StatelessWidget {
  const FirstSteps({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the text style for the link
    TextStyle linkStyle = const TextStyle(
      color: Color(0xFF0C76AB),
      decoration: TextDecoration.underline,
    );

    // Define the text style for the document uploader
    TextStyle docUploaderStyle = const TextStyle(
      color: Color(0xFF0C76AB),
      decoration: TextDecoration.none,
    );

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      padding: const EdgeInsets.all(25.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stepper(
            number: 1,
            text: TextSpan(
              children: [
                TextSpan(text: 'Info-Text eins'),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Stepper(
            number: 2,
            text: TextSpan(
              children: [
                TextSpan(text: 'Hier könnten Schritte zur Vorgehensweise (Installation, Einrichtung, etc.) stehen.'),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Stepper(
            number: 3,
            text: TextSpan(
              children: [
                TextSpan(text: 'Im Generellen wird hier erklärt, wie man sein Smartphone mit dem PC Verbindet.'),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Stepper(
            number: 4,
            text: TextSpan(
              children: [
                TextSpan(text: 'Danach ist es möglich, 2FA Anfragen vom PC auf das Smartphone weiterzuleiten.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Stepper extends StatelessWidget {
  final int number;
  final TextSpan text;

  const Stepper({super.key, required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.teal, width: 1.5),
              ),
            ),
            Text(
              number.toString(),
              style: const TextStyle(fontSize: 16, color: Colors.teal),
            ),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text.rich(text),
        ),
      ],
    );
  }
}
