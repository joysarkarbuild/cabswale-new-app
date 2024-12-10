// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppDataModelImpl _$$AppDataModelImplFromJson(Map<String, dynamic> json) =>
    _$AppDataModelImpl(
      appStoreUrl: json['appStoreUrl'] as String? ?? '',
      playStoreUrl: json['playStoreUrl'] as String,
      policy: json['policy'] as String,
      appVersion: (json['appVersion'] as num?)?.toInt() ?? 0,
      iosVersion: (json['iosVersion'] as num?)?.toInt() ?? 0,
      forceUpdate: json['forceUpdate'] as bool? ?? false,
    );

Map<String, dynamic> _$$AppDataModelImplToJson(_$AppDataModelImpl instance) =>
    <String, dynamic>{
      'appStoreUrl': instance.appStoreUrl,
      'playStoreUrl': instance.playStoreUrl,
      'policy': instance.policy,
      'appVersion': instance.appVersion,
      'iosVersion': instance.iosVersion,
      'forceUpdate': instance.forceUpdate,
    };
