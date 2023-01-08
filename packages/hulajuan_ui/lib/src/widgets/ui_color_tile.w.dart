import 'package:flutter/material.dart';
import 'package:hulajuan_ui/hulajuan_ui.dart';

/// {@template ui_color_tile}
/// Reusable widget which can be used for settings ui colors.
/// {@endtemplate}
class UiColorTile extends StatelessWidget {
  /// {@macro ui_color_tile}
  const UiColorTile({
    Key? key,
    required this.color,
    required this.onColorChanged,
    required this.label,
  }) : super(key: key);

  /// Initial selected color.
  final Color color;

  /// Callback when user changed the current selected color.
  final SelectedColorCallback onColorChanged;

  /// Label at top when modal appeared.
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        await showColorPicker(
          context,
          label: 'Background Color',
          initialSelectedColor: color,
          onColorSelected: (Color? value) {
            if (value != null && value != color) {
              onColorChanged.call(value);
            }
          },
        );
      },
      title: Text(label),
      trailing: Card(
        elevation: 5,
        color: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxHeight,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        ),
      ),
    );
  }
}
