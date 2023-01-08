import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulajuan/src/hulajuan/hulajuan.dart';
import 'package:hulajuan/src/settings/settings.dart';

class HulaJuanView extends StatelessWidget {
  const HulaJuanView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = AppBar().preferredSize.height;

    final maxHeight = screenSize.height - (height);
    final maxWidth = screenSize.width * 0.95;

    final bkgImagePath = context.select((SettingsCubit c) => c.state.bkgPath);

    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(bkgImagePath),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SizedBox(
            height: maxHeight,
            width: maxWidth,
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                    child: const _SettingsButton(),
                  ),
                  SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.5,
                    child: const WordText(),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.2,
                    child: const TimerText(),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () {
          HapticFeedback.vibrate();
          showDialog(
            context: context,
            useSafeArea: true,
            barrierDismissible: true,
            builder: (context) => const AlertDialog(
              scrollable: true,
              insetPadding: EdgeInsets.all(0),
              title: Text('Settings'),
              content: SettingsPage(),
            ),
          );
        },
        icon: const Icon(Icons.settings),
      ),
    );
  }
}
