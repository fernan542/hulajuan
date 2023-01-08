import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hulajuan/constants.dart';
import 'package:hulajuan/src/hulajuan/hulajuan.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({
    required Ticker ticker,
    int? maxDuration,
  })  : _ticker = ticker,
        super(TimerState(maxDuration: maxDuration ?? kSecondsPerRound)) {
    on<TimerStartedEvent>(_onStarted);
    on<TimerResetEvent>(_onReset);
    on<TimerTickedEvent>(_onTicked);
    on<TimerMaxTimeChangedEvent>(_onMaxTimeChanged);
    on<TimerStoppedEvent>(_onStopped);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(
    TimerStartedEvent event,
    Emitter<TimerState> emit,
  ) {
    final ticks = state.maxDuration;
    emit(state.copyWith(position: 0));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: ticks).listen(
          (second) => add(TimerTickedEvent(second: second)),
        );
  }

  void _onReset(
    TimerResetEvent event,
    Emitter<TimerState> emit,
  ) {
    _tickerSubscription?.cancel();
    emit(state.copyWith(position: 0, status: TimerStatus.initial));
  }

  void _onTicked(
    TimerTickedEvent event,
    Emitter<TimerState> emit,
  ) {
    final ticks = state.maxDuration;
    final current = event.second;
    emit(state.copyWith(
      position: current,
      status: current < ticks //
          ? TimerStatus.running
          : TimerStatus.completed,
    ));
  }

  void _onMaxTimeChanged(
    TimerMaxTimeChangedEvent event,
    Emitter<TimerState> emit,
  ) {
    _tickerSubscription?.cancel();
    emit(TimerState(maxDuration: event.second));
  }

  void _onStopped(
    TimerStoppedEvent event,
    Emitter<TimerState> emit,
  ) {
    _tickerSubscription?.cancel();
    emit(state.copyWith(status: TimerStatus.completed));
  }
}
