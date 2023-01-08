import 'package:flutter/material.dart';

/// {@template tile_label}
/// Reusable widget which can be used for consistent labels.
/// {@endtemplate}
class TileLabel extends StatelessWidget {
  /// {@macro tile_label}
  const TileLabel(this.title, {Key? key}) : super(key: key);

  /// Title of the label.
  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      );
}
