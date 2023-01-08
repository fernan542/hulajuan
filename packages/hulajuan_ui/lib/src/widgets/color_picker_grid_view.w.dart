import 'package:flutter/material.dart';

/// Colors bank.
const colors = [
  Colors.white,
  Colors.black,
  Colors.brown,
  Colors.red,
  Colors.blue,
  Colors.orange,
  Colors.yellow,
];

/// Callback for color selection.
typedef SelectedColorCallback = void Function(Color? color);

/// {@template color_picker_view}
/// Grid view for showing available colors that can be used on changing
/// ui default colors.
/// {@endtemplate}
class ColorPickerGridView extends StatelessWidget {
  /// {@macro color_picker_view}
  const ColorPickerGridView({
    super.key,
    required this.onColorSelected,
    required this.initialSelectedColor,
  });

  /// Callback method when selected color was changed.
  final SelectedColorCallback onColorSelected;

  /// Initial color for selection indicator.
  final Color initialSelectedColor;

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
          for (final color in colors)
            GestureDetector(
              onTap: () {
                onColorSelected.call(color);
                Navigator.of(context).pop();
              },
              child: Card(
                elevation: 5,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: color.value == initialSelectedColor.value
                      ? Icon(
                          Icons.check,
                          color: color == Colors.white || color == Colors.yellow
                              ? Colors.black
                              : Colors.white,
                        )
                      : null,
                ),
              ),
            )
        ],
      ),
    );
  }
}
