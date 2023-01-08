import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulajuan/src/hulajuan/hulajuan.dart';
import 'package:hulajuan/src/settings/cubit/settings_cubit.dart';
import 'package:words_repository/words_repository.dart';

class HulaanPage extends StatelessWidget {
  static const routeName = '/hulaan';

  const HulaanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final category = context.select((SettingsCubit c) => c.state.category);

    return BlocProvider(
      create: (context) => HulajuanBloc(
        repository: context.read<WordsRepository>(),
      )..add(HulajuanInitEvent(category)),
      child: const HulaJuanView(),
    );
  }
}
