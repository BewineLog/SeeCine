// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

data _$dataFromJson(Map<String, dynamic> json) => data(
      json['rank'] as String,
      json['openDt'] as String,
      json['movieNm'] as String,
      json['audiAcc'] as String,
      json['audiCnt'] as String,
    );

Map<String, dynamic> _$dataToJson(data instance) => <String, dynamic>{
      'movieNm': instance.movieNm,
      'rank': instance.rank,
      'openDt': instance.openDt,
      'audiAcc': instance.audiAcc,
      'audiCnt': instance.audiCnt,
    };
