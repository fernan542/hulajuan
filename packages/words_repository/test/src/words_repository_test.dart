// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:words_repository/words_repository.dart';

void main() {
  group('WordsRepository', () {
    test('can be instantiated', () {
      expect(WordsRepository(), isNotNull);
    });
  });
}
