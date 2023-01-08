import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulajuan/src/hulajuan/hulajuan.dart';
import 'package:hulajuan_ui/hulajuan_ui.dart';

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        final position = state.position;
        final minutesStr =
            ((position / 60) % 60).floor().toString().padLeft(2, '0');
        final secondsStr = (position % 60).floor().toString().padLeft(2, '0');

        final status = state.status;
        final isHalfTime = state.isHalfTime;

        final textColor = status.isRunning ? Colors.white : Colors.grey;
        final cardColor = status.isRunning
            ? isHalfTime
                ? Colors.red.withOpacity(0.9)
                : Colors.black.withOpacity(0.8)
            : Colors.black.withOpacity(0.5);

        return Center(
          child: BouncingWidgetWrapper(
            onPressed: () {
              if (state.status.isCompleted || state.status.isInitial) {
                context.read<TimerBloc>().add(const TimerStartedEvent());
              } else {
                context.read<TimerBloc>().add(const TimerStoppedEvent());
              }
            },
            child: Card(
              elevation: 10,
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text('$minutesStr:$secondsStr',
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                            color: textColor,
                          )),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
