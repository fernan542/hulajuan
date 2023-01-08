import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulajuan/src/settings/cubit/settings_cubit.dart';

class ShuffleLettersTile extends StatelessWidget {
  const ShuffleLettersTile({super.key});

  @override
  Widget build(BuildContext context) {
    final isShuffled = context.select((SettingsCubit c) => c.state.isShuffled);
    return ListTile(
      title: const Text('Shuffle Letters'),
      trailing: Checkbox(
        value: isShuffled,
        onChanged: (value) =>
            context.read<SettingsCubit>().onShuffleStatusChanged(
                  value ?? false,
                ),
      ),
    );
  }
}
