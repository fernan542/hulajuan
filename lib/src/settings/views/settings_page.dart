import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulajuan/src/hulajuan/hulajuan.dart';
import 'package:hulajuan/src/settings/settings.dart';
import 'package:hulajuan_ui/hulajuan_ui.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final maxHeight = screenSize.height * 0.5;
    final maxWidth = screenSize.width * 0.5;

    final state = context.select((SettingsCubit c) => c.state);
    final backgroundColor = state.bkgColor;
    final textColor = state.textColor;
    final duration = state.durationInSeconds;

    return SizedBox(
      height: maxHeight,
      width: maxWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          child: ListView(
            controller: scrollController,
            children: [
              const TileLabel('Appearance'),
              UiColorTile(
                color: backgroundColor,
                label: 'Background Color',
                onColorChanged: (color) => color != null
                    ? context.read<SettingsCubit>().onBkgColorChanged(color)
                    : null,
              ),
              UiColorTile(
                color: textColor,
                label: 'Text Color',
                onColorChanged: (color) => color != null
                    ? context.read<SettingsCubit>().onTextColorChanged(color)
                    : null,
              ),
              const BkgImageTile(),
              const SizedBox(height: 8.0),
              const TileLabel('Mechanics'),
              DurationTile(
                initialValue: duration.toString(),
                onEditingCompleted: (value) {
                  context.read<SettingsCubit>().onDurationChanged(value);
                  context.read<TimerBloc>().add(
                        TimerMaxTimeChangedEvent(second: value),
                      );
                },
              ),
              const ShuffleLettersTile(),
              const SizedBox(height: 8.0),
              const TileLabel('About'),
              const VersionTile(),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
