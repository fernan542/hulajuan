import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hulajuan/constants.dart';
import 'package:hulajuan_ui/hulajuan_ui.dart';
import 'package:words_repository/words_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit({
    required Color initialBackgroundColor,
    required Color initialTextColor,
  }) : super(SettingsState(
          bkgColor: initialBackgroundColor,
          textColor: initialTextColor,
        ));

  /// Changes the background color of the word.
  void onBkgColorChanged(Color color) => emit(state.copyWith(bkgColor: color));

  /// Changes the background image of the app.
  void onBkgPathChanged(String path) => emit(state.copyWith(bkgPath: path));

  /// Changes the text color of the word.
  void onTextColorChanged(Color color) =>
      emit(state.copyWith(textColor: color));

  /// Changes the duration per round.
  void onDurationChanged(int seconds) =>
      emit(state.copyWith(durationInSeconds: seconds));

  /// Changes the category filter.
  void onCategoryChanged(WordCategory category) =>
      emit(state.copyWith(category: category));

  /// Changes the shuffle status feature.
  void onShuffleStatusChanged(bool flag) =>
      emit(state.copyWith(isShuffled: flag));

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    final bkgColor = Color(int.parse(json['bkg_color'] as String));
    final bkgPath = json['bkg_path'] as String? ?? kDefaultBkgImage;
    final textColor = Color(int.parse(json['text_color'] as String));
    final category =
        WordCategoryX.fromJson(json['category'] as String? ?? 'all');
    final duration = int.parse(
        json['duration_in_seconds'] as String? ?? '$kSecondsPerRound');
    final isShuffled =
        (json['is_shuffled'] as String? ?? 'false').toLowerCase() == 'true';

    return SettingsState(
      bkgColor: bkgColor,
      bkgPath: bkgPath,
      textColor: textColor,
      durationInSeconds: duration,
      category: category,
      isShuffled: isShuffled,
    );
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return <String, dynamic>{
      'duration_in_seconds': state.durationInSeconds.toString(),
      'text_color': state.textColor.value.toString(),
      'bkg_color': state.bkgColor.value.toString(),
      'is_shuffled': state.isShuffled.toString(),
      'category': state.category.name,
      'bkg_path': state.bkgPath,
    };
  }
}
