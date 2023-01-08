import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

/// {@template theme_cubit}
/// A simple [Cubit] that manages the [ThemeMode] as its state.
/// {@endtemplate}
class ThemeCubit extends Cubit<ThemeMode> {
  /// {@macro theme_cubit}
  ThemeCubit() : super(ThemeMode.system);

  /// Toggles the current theme between light, dark and system.
  void toggleTheme(ThemeMode mode) => emit(mode);
}
