import 'package:flutter/material.dart';
import 'package:hulajuan/src/src.dart';
import 'package:words_repository/words_repository.dart';

bootstrap() {
  const wordsRepository = WordsRepository();
  const ticker = Ticker();

  runApp(const AppPage(
    wordsRepository: wordsRepository,
    ticker: ticker,
  ));
}
