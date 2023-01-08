import 'package:flutter/material.dart';

/// Image paths bank.
const paths = [
  'assets/images/bkg-01.jpg',
  'assets/images/bkg-02.jpg',
  'assets/images/bkg-03.jpg',
  'assets/images/bkg-04.jpg',
  'assets/images/bkg-05.jpg',
];

/// Callback for image selection.
typedef SelectedImageCallback = void Function(String? path);

/// {@template image_picker_grid_view}
/// Grid view for showing available colors that can be used on changing
/// ui default colors.
/// {@endtemplate}
class ImagePickerGridView extends StatelessWidget {
  /// {@macro image_picker_grid_view}
  const ImagePickerGridView({
    super.key,
    required this.onImageSelected,
    required this.initialSelectedImage,
  });

  /// Callback method when selected image was changed.
  final SelectedImageCallback onImageSelected;

  /// Initial image for selection indicator.
  final String initialSelectedImage;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final maxHeight = screenSize.height * 0.5;
    final maxWidth = screenSize.width * 0.5;

    return SizedBox(
      height: maxHeight,
      width: maxWidth,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
        ),
        shrinkWrap: true,
        children: [
          for (final path in paths)
            GestureDetector(
              onTap: () {
                onImageSelected.call(path);
                Navigator.of(context).pop();
              },
              child: Card(
                elevation: 5,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(path),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: path == initialSelectedImage
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              ),
            )
        ],
      ),
    );
  }
}
