part of 'hulajuan_bloc.dart';

enum HulaJuanStatus { initial, loading, ready }

extension HulaJuanStatusX on HulaJuanStatus {
  bool get isInitial => this == HulaJuanStatus.initial;
  bool get isLoading => this == HulaJuanStatus.loading;
  bool get isReady => this == HulaJuanStatus.ready;
}

@immutable
class HulajuanState extends Equatable {
  const HulajuanState({
    this.status = HulaJuanStatus.initial,
    this.words = const [],
    this.word,
  });

  final List<Word> words;
  final Word? word;
  final HulaJuanStatus status;

  @override
  List<Object?> get props => [words, word, status];

  @override
  String toString() {
    final s = {
      'words': words.length,
      'word': word,
      'status': status,
    };
    return 'HulajuanState: $s';
  }

  HulajuanState copyWith({
    List<Word>? words,
    Word? Function()? word,
    HulaJuanStatus? status,
  }) {
    return HulajuanState(
      words: words ?? this.words,
      word: word != null ? word() : this.word,
      status: status ?? this.status,
    );
  }
}
