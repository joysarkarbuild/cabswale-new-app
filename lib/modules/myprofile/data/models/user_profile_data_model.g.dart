// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileDataModelImpl _$$UserProfileDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserProfileDataModelImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      city: json['city'] as String?,
      experience: (json['experience'] as num?)?.toInt(),
      profileUrl: json['profileUrl'] as String?,
      profileImage: json['profile_image'] as String?,
      isAadhaarVerified: json['isAadhaarVerified'] as bool?,
      isDLVerified: json['isDLVerified'] as bool?,
      verified: json['verified'] as bool?,
      callReceivedCount: (json['callReceivedCount'] as num?)?.toInt(),
      callDoneCount: (json['callDoneCount'] as num?)?.toInt(),
      leads: json['leads'] as Map<String, dynamic>?,
      routes: json['routes'] as List<dynamic>?,
      vehicles: json['vehicles'] as List<dynamic>?,
      getDutyAlerts: json['getDutyAlerts'] as bool?,
      connectionCount: (json['connectionCount'] as num?)?.toInt(),
      aadharCard: json['aadharCard'] == null
          ? null
          : AadhaarCard.fromJson(json['aadharCard'] as Map<String, dynamic>),
      license: json['license'] == null
          ? null
          : License.fromJson(json['license'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserProfileDataModelImplToJson(
        _$UserProfileDataModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'experience': instance.experience,
      'profileUrl': instance.profileUrl,
      'profile_image': instance.profileImage,
      'isAadhaarVerified': instance.isAadhaarVerified,
      'isDLVerified': instance.isDLVerified,
      'verified': instance.verified,
      'callReceivedCount': instance.callReceivedCount,
      'callDoneCount': instance.callDoneCount,
      'leads': instance.leads,
      'routes': instance.routes,
      'vehicles': instance.vehicles,
      'getDutyAlerts': instance.getDutyAlerts,
      'connectionCount': instance.connectionCount,
      'aadharCard': instance.aadharCard,
      'license': instance.license,
    };

_$AadhaarCardImpl _$$AadhaarCardImplFromJson(Map<String, dynamic> json) =>
    _$AadhaarCardImpl(
      id: json['id'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$AadhaarCardImplToJson(_$AadhaarCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'images': instance.images,
    };

_$LicenseImpl _$$LicenseImplFromJson(Map<String, dynamic> json) =>
    _$LicenseImpl(
      id: json['id'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$LicenseImplToJson(_$LicenseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'images': instance.images,
    };

_$NotificationLocationImpl _$$NotificationLocationImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationLocationImpl(
      location: json['location'] as String?,
      coordinates: json['coordinates'] == null
          ? null
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$NotificationLocationImplToJson(
        _$NotificationLocationImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'coordinates': instance.coordinates,
    };

_$CoordinatesImpl _$$CoordinatesImplFromJson(Map<String, dynamic> json) =>
    _$CoordinatesImpl(
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
    );

Map<String, dynamic> _$$CoordinatesImplToJson(_$CoordinatesImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
