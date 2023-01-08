part of 'settings_cubit.dart';

@immutable
class SettingsState extends Equatable {
  const SettingsState({
    required this.bkgColor,
    required this.textColor,
    this.bkgPath = kDefaultBkgImage,
    this.durationInSeconds = kSecondsPerRound,
    this.category = WordCategory.all,
    this.isShuffled = false,
  });

  /// Background color of the word.
  final Color bkgColor;

  /// Background image path.
  final String bkgPath;

  /// Text color of the word.
  final Color textColor;

  /// Round duration in seconds.
  final int durationInSeconds;

  /// Filter for categories.
  final WordCategory category;

  /// Flag for shuffled letters feature.
  final bool isShuffled;

  @override
  List<Object> get props => [
        bkgPath,
        bkgColor,
        category,
        textColor,
        isShuffled,
        durationInSeconds,
      ];

  SettingsState copyWith({
    Color? bkgColor,
    String? bkgPath,
    Color? textColor,
    int? durationInSeconds,
    WordCategory? category,
    bool? isShuffled,
  }) {
    return SettingsState(
      bkgColor: bkgColor ?? this.bkgColor,
      bkgPath: bkgPath ?? this.bkgPath,
      textColor: textColor ?? this.textColor,
      durationInSeconds: durationInSeconds ?? this.durationInSeconds,
      category: category ?? this.category,
      isShuffled: isShuffled ?? this.isShuffled,
    );
  }
}
