import 'dart:ffi';

import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_model.freezed.dart';
part 'driver_model.g.dart';

@freezed
class DriverModel with _$DriverModel {
  const factory DriverModel({
    String? id,
    String? name,
    String? phoneNo,
    dynamic createdAt,
    List? deviceTokens,
    bool? conditionAccepted,
    Kyc? kyc,
    String? notificationPlace,
    bool? notificationAlert,
    List? notificationLocations,
    bool? autoApproveLeads,
    @TimestampToDateTimeConverter() DateTime? lastAccess,
    bool? verified,
    int? stage,
    int? appVersion,
    List<dynamic>? deviceList,
    Refer? refer,
    Membership? membership,
    Wallet? wallet,
    int? totalLeads,
    int? outGoingCalls,
    int? dealCount,
    bool? customOffer,
    String? sessionId,
  }) = _DriverModel;

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);
}

@freezed
class Kyc with _$Kyc {
  const factory Kyc({
    bool? verified,
    bool? submitted,
    String? address,
    String? vehicleNo,
    dynamic aadhaarPic,
    dynamic licensePic,
  }) = _Kyc;

  factory Kyc.fromJson(Map<String, dynamic> json) => _$KycFromJson(json);
}

@freezed
class Refer with _$Refer {
  const factory Refer({
    int? code,
    int? count,
    String? referBy,
  }) = _Refer;

  factory Refer.fromJson(Map<String, dynamic> json) => _$ReferFromJson(json);
}

@freezed
class Membership with _$Membership {
  const factory Membership({
    required bool active,
    @TimestampToDateTimeConverter() DateTime? endDate,
    required String plan,
    @TimestampToDateTimeConverter() DateTime? startDate,
    required bool trial,
  }) = _Membership;

  factory Membership.fromJson(Map<String, dynamic> json) =>
      _$MembershipFromJson(json);
}

@freezed
class Wallet with _$Wallet {
  const factory Wallet({
    required num amount,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
}
