import 'package:flutter/material.dart';

/// Snackbar display type.
enum SnackBarType {
  /// Red.
  error,

  /// Blue.
  information,

  /// Green.
  success,
}

/// Helper for showing custom snackbar.
void showCustomSnackbar(
  BuildContext context, {
  Widget? trailing,
  required GlobalKey<ScaffoldMessengerState> key,
  required String message,
  required SnackBarType snackBarType,
}) {
  Color backGroundColor = Colors.red;

  if (snackBarType == SnackBarType.success) {
    backGroundColor = Colors.green;
  } else if (snackBarType == SnackBarType.information) {
    backGroundColor = Colors.blue;
  }

  key.currentState
    ?..clearSnackBars()
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: backGroundColor,
        padding: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
        content: Row(
          children: [
            Text(message),
            const Spacer(),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
}
