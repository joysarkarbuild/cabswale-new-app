// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeadModelImpl _$$LeadModelImplFromJson(Map<String, dynamic> json) =>
    _$LeadModelImpl(
      id: json['id'] as String?,
      createdAt:
          const TimestampToDateTimeConverter().fromJson(json['createdAt']),
      active: json['active'] as bool?,
      verified: json['verified'] as bool?,
      createdBy: json['createdBy'] == null
          ? null
          : CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
      from: json['from'] == null
          ? null
          : From.fromJson(json['from'] as Map<String, dynamic>),
      to: json['to'] == null
          ? null
          : From.fromJson(json['to'] as Map<String, dynamic>),
      carType: json['carType'] as String?,
      message: json['message'] as String?,
      status: json['status'] as String?,
      at: json['at'],
      metaData: json['metaData'],
      leadType: json['leadType'] as String?,
      shareImage: json['shareImage'] as String?,
      otp: (json['otp'] as num?)?.toInt() ?? 100000,
    );

Map<String, dynamic> _$$LeadModelImplToJson(_$LeadModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt':
          const TimestampToDateTimeConverter().toJson(instance.createdAt),
      'active': instance.active,
      'verified': instance.verified,
      'createdBy': instance.createdBy,
      'from': instance.from,
      'to': instance.to,
      'carType': instance.carType,
      'message': instance.message,
      'status': instance.status,
      'at': instance.at,
      'metaData': instance.metaData,
      'leadType': instance.leadType,
      'shareImage': instance.shareImage,
      'otp': instance.otp,
    };

_$CreatedByImpl _$$CreatedByImplFromJson(Map<String, dynamic> json) =>
    _$CreatedByImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phoneNo: json['phoneNo'] as String?,
      verified: json['verified'] as bool?,
      city: json['city'] as String?,
      connections: (json['connections'] as num?)?.toInt(),
      fraud: json['fraud'] as bool?,
      profileImage: json['profileImage'] as String?,
    );

Map<String, dynamic> _$$CreatedByImplToJson(_$CreatedByImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNo': instance.phoneNo,
      'verified': instance.verified,
      'city': instance.city,
      'connections': instance.connections,
      'fraud': instance.fraud,
      'profileImage': instance.profileImage,
    };

_$FromImpl _$$FromImplFromJson(Map<String, dynamic> json) => _$FromImpl(
      city: json['city'] as String?,
    );

Map<String, dynamic> _$$FromImplToJson(_$FromImpl instance) =>
    <String, dynamic>{
      'city': instance.city,
    };
