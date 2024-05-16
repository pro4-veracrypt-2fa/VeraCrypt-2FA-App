import 'package:flutter/material.dart';

/// A utility class for displaying snackbars.
class Snackbar {
  /// Shows a snackbar asynchronously.
  ///
  /// The [context] parameter is the build context.
  /// The [message] parameter is the message to be displayed in the snackbar.
  static Future showAsync(BuildContext context, String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF202020),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  /// Shows a snackbar.
  ///
  /// The [context] parameter is the build context.
  /// The [message] parameter is the message to be displayed in the snackbar.
  static void show(BuildContext context, String message) {
    // Use Future.delayed with no delay set in order to
    // work around asynchronous gaps.
    Future.delayed(const Duration(seconds: 0), () {
      showAsync(context, message);
    });
  }
}
