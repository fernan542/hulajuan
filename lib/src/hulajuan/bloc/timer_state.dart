part of 'timer_bloc.dart';

enum TimerStatus { running, initial, completed }

extension TimerStatusX on TimerStatus {
  bool get isInitial => this == TimerStatus.initial;
  bool get isRunning => this == TimerStatus.running;
  bool get isCompleted => this == TimerStatus.completed;
}

@immutable
class TimerState extends Equatable {
  final int position;
  final int maxDuration;
  final TimerStatus status;

  const TimerState({
    this.status = TimerStatus.initial,
    this.position = 0,
    this.maxDuration = 60,
  });

  @override
  List<Object> get props => [position, status, maxDuration];

  TimerState copyWith({
    int? position,
    int? maxDuration,
    TimerStatus? status,
  }) {
    return TimerState(
      position: position ?? this.position,
      maxDuration: maxDuration ?? this.maxDuration,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    final s = {
      'position': position,
      'maxDuration': maxDuration,
      'status': status,
    };
    return 'TimerState: $s';
  }

  bool get isHalfTime => maxDuration - 10 < position;
}
