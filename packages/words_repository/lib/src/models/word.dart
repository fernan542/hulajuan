import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:words_repository/src/models/json_map.dart';

part 'word.g.dart';

/// Word category filter para sa huhulaang salita.
@JsonEnum(fieldRename: FieldRename.snake)
enum WordCategory {
  /// All of the words can be used.
  all,

  /// Categories are limited to tao only.
  tao,

  /// Categories are limited to bagay only.
  bagay,

  /// Categories are limited to hayop only.
  hayop,

  /// Categories are limited to lugar only.
  lugar,

  /// Categories are limited to pagkain only.
  pagkain,
}

/// Convenient extension for word category enum.
extension WordCategoryX on WordCategory {
  /// Checks whether this category value is equal to `all`.
  bool get isAll => this == WordCategory.all;

  /// Converts a [WordCategory] from Json.
  static WordCategory fromJson(String json) {
    return $enumDecode(_$WordCategoryEnumMap, json);
  }
}

/// {@template word}
/// A single [Word] model.
///
/// [Word]s are immutable and can be deserialized
/// using [toJson] and [fromJson].
/// {@endtemplate}
@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class Word extends Equatable {
  /// {@macro word}
  const Word(this.value, this.category);

  /// The text value of this word.
  final String value;

  /// Filter for this word.
  final WordCategory category;

  /// Deserializes the given [JsonMap] into a [Word].
  static Word fromJson(JsonMap json) => _$WordFromJson(json);

  /// Converts this [Word] into a [JsonMap].
  JsonMap toJson() => _$WordToJson(this);

  @override
  List<Object?> get props => [value, category];
}
