import 'package:flutter/material.dart';
import 'package:hulajuan_ui/hulajuan_ui.dart';

/// Helper for showing background image picker.
Future<void> showImagePicker(
  BuildContext context, {
  required String initialSelectedImage,
  required String label,
  required SelectedImageCallback onImageSelected,
}) async {
  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      insetPadding: EdgeInsets.zero,
      scrollable: true,
      title: Text('Select $label'),
      content: ImagePickerGridView(
        initialSelectedImage: initialSelectedImage,
        onImageSelected: onImageSelected,
      ),
    ),
  );

  onImageSelected.call(null);
}
