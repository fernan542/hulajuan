// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      json['value'] as String,
      $enumDecode(_$WordCategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'value': instance.value,
      'category': _$WordCategoryEnumMap[instance.category],
    };

const _$WordCategoryEnumMap = {
  WordCategory.all: 'all',
  WordCategory.tao: 'tao',
  WordCategory.bagay: 'bagay',
  WordCategory.hayop: 'hayop',
  WordCategory.lugar: 'lugar',
  WordCategory.pagkain: 'pagkain',
};
