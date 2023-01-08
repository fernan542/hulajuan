import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template bouncing_widget_wrapper}
/// Simple widget wrapper for widget from bouncing_widget package.
/// {@endtemplate}
class BouncingWidgetWrapper extends StatelessWidget {
  /// {@macro bouncing_widget_wrapper}
  const BouncingWidgetWrapper({
    Key? key,
    required this.child,
    required this.onPressed,
    this.duration,
  }) : super(key: key);

  /// Content of the button.
  final Widget child;

  /// Callback when the button was pressed.
  final VoidCallback onPressed;

  /// Custom duration for bounce animation.
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      duration: duration ?? const Duration(milliseconds: 100),
      scaleFactor: 1.5,
      child: child,
      onPressed: () {
        HapticFeedback.vibrate();
        onPressed.call();
      },
    );
  }
}
