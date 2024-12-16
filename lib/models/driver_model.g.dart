// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverModelImpl _$$DriverModelImplFromJson(Map<String, dynamic> json) =>
    _$DriverModelImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phoneNo: json['phoneNo'] as String?,
      createdAt: json['createdAt'],
      deviceTokens: json['deviceTokens'] as List<dynamic>?,
      conditionAccepted: json['conditionAccepted'] as bool?,
      kyc: json['kyc'] == null
          ? null
          : Kyc.fromJson(json['kyc'] as Map<String, dynamic>),
      notificationPlace: json['notificationPlace'] as String?,
      notificationAlert: json['notificationAlert'] as bool?,
      notificationLocations: json['notificationLocations'] as List<dynamic>?,
      autoApproveLeads: json['autoApproveLeads'] as bool?,
      lastAccess:
          const TimestampToDateTimeConverter().fromJson(json['lastAccess']),
      verified: json['verified'] as bool?,
      stage: (json['stage'] as num?)?.toInt(),
      appVersion: (json['appVersion'] as num?)?.toInt(),
      deviceList: json['deviceList'] as List<dynamic>?,
      refer: json['refer'] == null
          ? null
          : Refer.fromJson(json['refer'] as Map<String, dynamic>),
      membership: json['membership'] == null
          ? null
          : Membership.fromJson(json['membership'] as Map<String, dynamic>),
      wallet: json['wallet'] == null
          ? null
          : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      totalLeads: (json['totalLeads'] as num?)?.toInt(),
      outGoingCalls: (json['outGoingCalls'] as num?)?.toInt(),
      dealCount: (json['dealCount'] as num?)?.toInt(),
      customOffer: json['customOffer'] as bool?,
      sessionId: json['sessionId'] as String?,
    );

Map<String, dynamic> _$$DriverModelImplToJson(_$DriverModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNo': instance.phoneNo,
      'createdAt': instance.createdAt,
      'deviceTokens': instance.deviceTokens,
      'conditionAccepted': instance.conditionAccepted,
      'kyc': instance.kyc,
      'notificationPlace': instance.notificationPlace,
      'notificationAlert': instance.notificationAlert,
      'notificationLocations': instance.notificationLocations,
      'autoApproveLeads': instance.autoApproveLeads,
      'lastAccess':
          const TimestampToDateTimeConverter().toJson(instance.lastAccess),
      'verified': instance.verified,
      'stage': instance.stage,
      'appVersion': instance.appVersion,
      'deviceList': instance.deviceList,
      'refer': instance.refer,
      'membership': instance.membership,
      'wallet': instance.wallet,
      'totalLeads': instance.totalLeads,
      'outGoingCalls': instance.outGoingCalls,
      'dealCount': instance.dealCount,
      'customOffer': instance.customOffer,
      'sessionId': instance.sessionId,
    };

_$KycImpl _$$KycImplFromJson(Map<String, dynamic> json) => _$KycImpl(
      verified: json['verified'] as bool?,
      submitted: json['submitted'] as bool?,
      address: json['address'] as String?,
      vehicleNo: json['vehicleNo'] as String?,
      aadhaarPic: json['aadhaarPic'],
      licensePic: json['licensePic'],
    );

Map<String, dynamic> _$$KycImplToJson(_$KycImpl instance) => <String, dynamic>{
      'verified': instance.verified,
      'submitted': instance.submitted,
      'address': instance.address,
      'vehicleNo': instance.vehicleNo,
      'aadhaarPic': instance.aadhaarPic,
      'licensePic': instance.licensePic,
    };

_$ReferImpl _$$ReferImplFromJson(Map<String, dynamic> json) => _$ReferImpl(
      code: (json['code'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      referBy: json['referBy'] as String?,
    );

Map<String, dynamic> _$$ReferImplToJson(_$ReferImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'count': instance.count,
      'referBy': instance.referBy,
    };

_$MembershipImpl _$$MembershipImplFromJson(Map<String, dynamic> json) =>
    _$MembershipImpl(
      active: json['active'] as bool,
      endDate: const TimestampToDateTimeConverter().fromJson(json['endDate']),
      plan: json['plan'] as String,
      startDate:
          const TimestampToDateTimeConverter().fromJson(json['startDate']),
      trial: json['trial'] as bool,
    );

Map<String, dynamic> _$$MembershipImplToJson(_$MembershipImpl instance) =>
    <String, dynamic>{
      'active': instance.active,
      'endDate': const TimestampToDateTimeConverter().toJson(instance.endDate),
      'plan': instance.plan,
      'startDate':
          const TimestampToDateTimeConverter().toJson(instance.startDate),
      'trial': instance.trial,
    };

_$WalletImpl _$$WalletImplFromJson(Map<String, dynamic> json) => _$WalletImpl(
      amount: json['amount'] as num,
    );

Map<String, dynamic> _$$WalletImplToJson(_$WalletImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
    };
