import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulajuan/constants.dart';
import 'package:hulajuan/src/src.dart';
import 'package:hulajuan_ui/hulajuan_ui.dart';
import 'package:words_repository/words_repository.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.ticker,
    required this.wordsRepository,
  });

  final WordsRepository wordsRepository;
  final Ticker ticker;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: wordsRepository),
      ],
      child: Builder(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ThemeCubit()),
            BlocProvider(
              create: (context) => SettingsCubit(
                  initialBackgroundColor: Colors.white,
                  initialTextColor: Colors.black),
            ),
            BlocProvider(
              create: (context) => TimerBloc(
                ticker: ticker,
                maxDuration: kSecondsPerRound,
              ),
            ),
          ],
          child: const _AppView(),
        );
      }),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        return MaterialApp(
          scaffoldMessengerKey: kGlobalScaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          theme: HulaJuanTheme.light,
          darkTheme: HulaJuanTheme.dark,
          themeMode: mode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (context) {
                switch (routeSettings.name) {
                  case HulaanPage.routeName:
                    return const HulaanPage();
                  case SettingsPage.routeName:
                    return const SettingsPage();
                  default:
                    return const HulaanPage();
                }
              },
            );
          },
        );
      },
    );
  }
}
