import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulajuan/constants.dart';
import 'package:hulajuan/src/src.dart';
import 'package:hulajuan_core/hulajuan_core.dart';
import 'package:hulajuan_ui/hulajuan_ui.dart';

const _boxShadow = [
  BoxShadow(blurRadius: 30, spreadRadius: 5, color: Colors.black38)
];

class WordText extends StatefulWidget {
  const WordText({Key? key}) : super(key: key);

  @override
  State<WordText> createState() => _WordTextState();
}

class _WordTextState extends State<WordText> {
  @override
  void initState() {
    super.initState();
    context.read<HulajuanBloc>().add(
          const HulajuanNewWordRequestedEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final bkgColor = context.select((SettingsCubit c) => c.state.bkgColor);

    return LayoutBuilder(
      builder: (context, constraints) {
        return BouncingWidgetWrapper(
          onPressed: () {
            context.read<HulajuanBloc>().add(
                  const HulajuanNewWordRequestedEvent(),
                );

            // Reset the timer if the word was changed.
            context.read<TimerBloc>().add(const TimerResetEvent());
          },
          child: AnimatedContainer(
            duration: kAnimationDuration,
            height: constraints.maxWidth,
            width: constraints.maxWidth,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: bkgColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
              boxShadow: _boxShadow,
            ),
            alignment: Alignment.center,
            child: BlocBuilder<HulajuanBloc, HulajuanState>(
              builder: (context, state) {
                final word = state.word;
                final status = state.status;
                if (status.isLoading || word == null) {
                  return const _LoadingView();
                }

                final timerStatus = context.select(
                  (TimerBloc b) => b.state.status,
                );

                if (timerStatus.isRunning || timerStatus.isCompleted) {
                  return _WordAnimator(word.value.toUpperCase());
                }

                // Default view.
                return const _TapToStartView();
              },
            ),
          ),
        );
      },
    );
  }
}

class _WordAnimator extends StatefulWidget {
  const _WordAnimator(this.word);

  final String word;

  @override
  State<_WordAnimator> createState() => _WordAnimatorState();
}

class _WordAnimatorState extends State<_WordAnimator> {
  late Timer _timer;
  late String displayWord;

  @override
  void initState() {
    super.initState();
    final isShuffled = context.read<SettingsCubit>().state.isShuffled;
    displayWord = isShuffled ? widget.word.shuffled : widget.word;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final tick = timer.tick + 1;
      if (tick < 12) {
        if (isShuffled) {
          if (tick % 3 == 0) {
            displayWord = widget.word.shuffled;
            setState(() {});
          }
        }
      } else {
        // Back to original.
        displayWord = widget.word;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = context.select((SettingsCubit c) => c.state.textColor);
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.displayLarge?.copyWith(
      fontSize: 500,
      color: textColor,
      fontWeight: FontWeight.bold,
    );

    final isCompleted = context.select(
      (TimerBloc b) => b.state.status.isCompleted,
    );

    if (isCompleted) {
      _timer.cancel();
      displayWord = widget.word;
    }

    return FittedBox(
      fit: BoxFit.cover,
      child: Text(displayWord, style: textStyle),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final textColor = context.select((SettingsCubit c) => c.state.textColor);
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.displayLarge?.copyWith(
      fontSize: 500,
      color: textColor,
      fontWeight: FontWeight.bold,
    );

    const beginOffset = Duration(seconds: 1);
    const endOffset = Duration(seconds: 5);
    final animation = Tween<Duration>(begin: beginOffset, end: endOffset);
    return TweenAnimationBuilder(
      tween: animation,
      duration: endOffset,
      curve: Curves.easeIn,
      builder: (context, _, child) {
        final display = 'HULAJUAN'.shuffled;
        return FittedBox(
          fit: BoxFit.cover,
          child: Text(display, style: textStyle),
        );
      },
    );
  }
}

class _TapToStartView extends StatelessWidget {
  const _TapToStartView();

  @override
  Widget build(BuildContext context) {
    final textColor = context.select((SettingsCubit c) => c.state.textColor);
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.displayLarge?.copyWith(
      fontSize: 500,
      color: textColor,
      fontWeight: FontWeight.bold,
    );

    const message = 'tap timer to start';

    return FittedBox(
      fit: BoxFit.cover,
      child: Text(message.toUpperCase(), style: textStyle),
    );
  }
}
