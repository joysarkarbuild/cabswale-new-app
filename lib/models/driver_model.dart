import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_model.freezed.dart';
part 'driver_model.g.dart';

@freezed
class DriverModel with _$DriverModel {
  const factory DriverModel({
    @Default('') String id,
    @Default('') String name,
    @Default('') String phoneNo,
    dynamic createdAt,
    @Default([]) List deviceTokens,
    @Default(false) bool conditionAccepted,
    Kyc? kyc,
    @Default('') String notificationPlace,
    @Default(false) bool notificationAlert,
    @Default([]) List notificationLocations,
    @Default(false) bool autoApproveLeads,
    @TimestampToDateTimeConverter() DateTime? lastAccess,
    @Default(false) bool verified,
    @Default(0) int stage,
    @Default(0) int appVersion,
    @Default([]) List<dynamic> deviceList,
    Refer? refer,
    Membership? membership,
    Wallet? wallet,
    @Default(0) int totalLeads,
    @Default(0) int outGoingCalls,
    @Default(0) int dealCount,
    @Default(false) bool customOffer,
    @Default('') String sessionId,
  }) = _DriverModel;

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);
}

@freezed
class Kyc with _$Kyc {
  const factory Kyc({
    @Default(false) bool verified,
    @Default(false) bool submitted,
    @Default('') String address,
    @Default('') String vehicleNo,
    dynamic aadhaarPic,
    dynamic licensePic,
  }) = _Kyc;

  factory Kyc.fromJson(Map<String, dynamic> json) => _$KycFromJson(json);
}

@freezed
class Refer with _$Refer {
  const factory Refer({
    @Default(10000) int code,
    @Default(0) int count,
    @Default('') String referBy,
  }) = _Refer;

  factory Refer.fromJson(Map<String, dynamic> json) => _$ReferFromJson(json);
}

@freezed
class Membership with _$Membership {
  const factory Membership({
    @Default(false) bool active, // Default value for 'active'
    @TimestampToDateTimeConverter() DateTime? endDate,
    @Default('daily') String plan, // Default value for 'plan'
    @TimestampToDateTimeConverter() DateTime? startDate,
    @Default(false) bool trial, // Default value for 'trial'
  }) = _Membership;

  factory Membership.fromJson(Map<String, dynamic> json) =>
      _$MembershipFromJson(json);
}

@freezed
class Wallet with _$Wallet {
  const factory Wallet({
    @Default(0.0) num amount, // Default value for 'amount'
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
}
