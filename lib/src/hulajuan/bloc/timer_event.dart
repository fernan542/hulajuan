part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStartedEvent extends TimerEvent {
  const TimerStartedEvent();
}

class TimerStoppedEvent extends TimerEvent {
  const TimerStoppedEvent();
}

class TimerResetEvent extends TimerEvent {
  const TimerResetEvent();
}

class TimerTickedEvent extends TimerEvent {
  const TimerTickedEvent({required this.second});
  final int second;

  @override
  List<Object> get props => [second];
}

class TimerMaxTimeChangedEvent extends TimerEvent {
  const TimerMaxTimeChangedEvent({required this.second});
  final int second;

  @override
  List<Object> get props => [second];
}
