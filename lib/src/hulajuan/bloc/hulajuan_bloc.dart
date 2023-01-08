import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:words_repository/words_repository.dart';

part 'hulajuan_event.dart';
part 'hulajuan_state.dart';

class HulajuanBloc extends Bloc<HulajuanEvent, HulajuanState> {
  HulajuanBloc({
    required WordsRepository repository,
  })  : _repository = repository,
        super(const HulajuanState()) {
    on<HulajuanInitEvent>(_onInitEvent);
    on<HulajuanNewWordRequestedEvent>(_onNewWordRequested);
  }

  final WordsRepository _repository;

  Future<void> _onNewWordRequested(
    HulajuanNewWordRequestedEvent event,
    Emitter<HulajuanState> emit,
  ) async {
    final words = [...state.words];
    emit(state.copyWith(status: HulaJuanStatus.loading));
    await Future.delayed(const Duration(seconds: 2));

    final previousWord = state.word;
    final index = words.indexWhere((w) => w.value == previousWord?.value);
    late final Word nextWord;
    if (index == -1) {
      // Generate new word.
      final nextWordIndex = Random().nextInt(words.length - 1);
      nextWord = words[nextWordIndex];
    } else {
      // Remove previous word.
      words.removeAt(index);
      // Generate new word.
      final nextWordIndex = Random().nextInt(words.length - 1);
      nextWord = words[nextWordIndex];
    }

    return emit(state.copyWith(
      word: () => nextWord,
      status: HulaJuanStatus.ready,
    ));
  }

  void _onInitEvent(
    HulajuanInitEvent event,
    Emitter<HulajuanState> emit,
  ) {
    emit(state.copyWith(word: () => null));
    final words = _repository.fetchWords();
    emit(state.copyWith(words: words));
  }
}
