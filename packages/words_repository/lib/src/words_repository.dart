import 'package:words_repository/words_repository.dart';

/// {@template words_repository}
/// App package that handles `words` domain.
/// {@endtemplate}
class WordsRepository {
  /// {@macro words_repository}
  const WordsRepository();

  /// Fetches the group of available words and can be filtered if
  /// [category] is supplied.
  ///
  /// Defaults to all categories.
  List<Word> fetchWords([
    WordCategory category = WordCategory.all,
  ]) {
    final words = rawWords
        .map((dynamic e) => Word.fromJson(e as Map<String, dynamic>))
        .toList();
    if (category.isAll) return words;

    return [...words.where((w) => w.category == category)];
  }
}
