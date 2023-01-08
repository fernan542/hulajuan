/// Convenient extensions for [String] objects.
extension StringX on String {
  /// Shuffles the characters of the word while skipping
  /// the space character if there is.
  String get shuffled {
    final letters = split('')
      ..removeWhere((letter) => letter == ' ')
      ..shuffle();

    return replaceAllMapped(
      RegExp('[^ ]'),
      (match) =>
          Iterable.generate(match[0]!.length, (_) => letters.removeLast())
              .join(),
    );
  }
}
