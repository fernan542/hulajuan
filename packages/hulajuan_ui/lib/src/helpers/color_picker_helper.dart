import 'package:flutter/material.dart';
import 'package:hulajuan_ui/hulajuan_ui.dart';

/// Helper for showing color picker.
Future<void> showColorPicker(
  BuildContext context, {
  required Color initialSelectedColor,
  required String label,
  required SelectedColorCallback onColorSelected,
}) async {
  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      insetPadding: EdgeInsets.zero,
      scrollable: true,
      title: Text('Select $label'),
      content: ColorPickerGridView(
        onColorSelected: onColorSelected,
        initialSelectedColor: initialSelectedColor,
      ),
    ),
  );

  onColorSelected.call(null);
}
