part of 'hulajuan_bloc.dart';

abstract class HulajuanEvent extends Equatable {
  const HulajuanEvent();

  @override
  List<Object> get props => [];
}

class HulajuanNewWordRequestedEvent extends HulajuanEvent {
  const HulajuanNewWordRequestedEvent();
}

class HulajuanInitEvent extends HulajuanEvent {
  const HulajuanInitEvent([this.category = WordCategory.all]);

  final WordCategory category;

  @override
  List<Object> get props => [category];
}
