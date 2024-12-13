import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_data_model.freezed.dart';
part 'user_profile_data_model.g.dart';

@freezed
class UserProfileDataModel with _$UserProfileDataModel {
  factory UserProfileDataModel({
    String? id,
    String? name,
    String? city,
    int? experience,
    String? profileUrl,
    String? profileImage,
    bool? isAadhaarVerified,
    bool? isDLVerified,
    bool? verified,
    int? callReceivedCount,
    int? callDoneCount,
    int? dutyCount,
    int? exchangeCount,
    int? availableCount,
    List<dynamic>? routes,
    List<dynamic>? vehicles,
    List<NotificationLocation>? notificationLocations,
    bool? getDutyAlerts,
    int? connectionCount,
  }) = _UserProfileDataModel;

  factory UserProfileDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDataModelFromJson(json);
}

@freezed
class NotificationLocation with _$NotificationLocation {
  factory NotificationLocation({
    String? location,
    Coordinates? coordinates,
  }) = _NotificationLocation;

  factory NotificationLocation.fromJson(Map<String, dynamic> json) =>
      _$NotificationLocationFromJson(json);
}

@freezed
class Coordinates with _$Coordinates {
  factory Coordinates({
    String? lat,
    String? lng,
  }) = _Coordinates;

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);
}
