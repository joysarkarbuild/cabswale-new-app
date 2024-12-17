// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfileDataModel _$UserProfileDataModelFromJson(Map<String, dynamic> json) {
  return _UserProfileDataModel.fromJson(json);
}

/// @nodoc
mixin _$UserProfileDataModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  int? get experience => throw _privateConstructorUsedError;
  String? get profileUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_image')
  String? get profileImage => throw _privateConstructorUsedError;
  bool? get isAadhaarVerified => throw _privateConstructorUsedError;
  bool? get isDLVerified => throw _privateConstructorUsedError;
  bool? get verified => throw _privateConstructorUsedError;
  int? get callReceivedCount => throw _privateConstructorUsedError;
  int? get callDoneCount => throw _privateConstructorUsedError;
  int? get dutyCount => throw _privateConstructorUsedError;
  int? get exchangeCount => throw _privateConstructorUsedError;
  int? get availableCount => throw _privateConstructorUsedError;
  List<dynamic>? get routes => throw _privateConstructorUsedError;
  List<dynamic>? get vehicles => throw _privateConstructorUsedError;
  bool? get getDutyAlerts => throw _privateConstructorUsedError;
  int? get connectionCount => throw _privateConstructorUsedError;

  /// Serializes this UserProfileDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileDataModelCopyWith<UserProfileDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileDataModelCopyWith<$Res> {
  factory $UserProfileDataModelCopyWith(UserProfileDataModel value,
          $Res Function(UserProfileDataModel) then) =
      _$UserProfileDataModelCopyWithImpl<$Res, UserProfileDataModel>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? city,
      int? experience,
      String? profileUrl,
      @JsonKey(name: 'profile_image') String? profileImage,
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
      bool? getDutyAlerts,
      int? connectionCount});
}

/// @nodoc
class _$UserProfileDataModelCopyWithImpl<$Res,
        $Val extends UserProfileDataModel>
    implements $UserProfileDataModelCopyWith<$Res> {
  _$UserProfileDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? city = freezed,
    Object? experience = freezed,
    Object? profileUrl = freezed,
    Object? profileImage = freezed,
    Object? isAadhaarVerified = freezed,
    Object? isDLVerified = freezed,
    Object? verified = freezed,
    Object? callReceivedCount = freezed,
    Object? callDoneCount = freezed,
    Object? dutyCount = freezed,
    Object? exchangeCount = freezed,
    Object? availableCount = freezed,
    Object? routes = freezed,
    Object? vehicles = freezed,
    Object? getDutyAlerts = freezed,
    Object? connectionCount = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      experience: freezed == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int?,
      profileUrl: freezed == profileUrl
          ? _value.profileUrl
          : profileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      isAadhaarVerified: freezed == isAadhaarVerified
          ? _value.isAadhaarVerified
          : isAadhaarVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDLVerified: freezed == isDLVerified
          ? _value.isDLVerified
          : isDLVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      verified: freezed == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool?,
      callReceivedCount: freezed == callReceivedCount
          ? _value.callReceivedCount
          : callReceivedCount // ignore: cast_nullable_to_non_nullable
              as int?,
      callDoneCount: freezed == callDoneCount
          ? _value.callDoneCount
          : callDoneCount // ignore: cast_nullable_to_non_nullable
              as int?,
      dutyCount: freezed == dutyCount
          ? _value.dutyCount
          : dutyCount // ignore: cast_nullable_to_non_nullable
              as int?,
      exchangeCount: freezed == exchangeCount
          ? _value.exchangeCount
          : exchangeCount // ignore: cast_nullable_to_non_nullable
              as int?,
      availableCount: freezed == availableCount
          ? _value.availableCount
          : availableCount // ignore: cast_nullable_to_non_nullable
              as int?,
      routes: freezed == routes
          ? _value.routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      vehicles: freezed == vehicles
          ? _value.vehicles
          : vehicles // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      getDutyAlerts: freezed == getDutyAlerts
          ? _value.getDutyAlerts
          : getDutyAlerts // ignore: cast_nullable_to_non_nullable
              as bool?,
      connectionCount: freezed == connectionCount
          ? _value.connectionCount
          : connectionCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileDataModelImplCopyWith<$Res>
    implements $UserProfileDataModelCopyWith<$Res> {
  factory _$$UserProfileDataModelImplCopyWith(_$UserProfileDataModelImpl value,
          $Res Function(_$UserProfileDataModelImpl) then) =
      __$$UserProfileDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? city,
      int? experience,
      String? profileUrl,
      @JsonKey(name: 'profile_image') String? profileImage,
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
      bool? getDutyAlerts,
      int? connectionCount});
}

/// @nodoc
class __$$UserProfileDataModelImplCopyWithImpl<$Res>
    extends _$UserProfileDataModelCopyWithImpl<$Res, _$UserProfileDataModelImpl>
    implements _$$UserProfileDataModelImplCopyWith<$Res> {
  __$$UserProfileDataModelImplCopyWithImpl(_$UserProfileDataModelImpl _value,
      $Res Function(_$UserProfileDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? city = freezed,
    Object? experience = freezed,
    Object? profileUrl = freezed,
    Object? profileImage = freezed,
    Object? isAadhaarVerified = freezed,
    Object? isDLVerified = freezed,
    Object? verified = freezed,
    Object? callReceivedCount = freezed,
    Object? callDoneCount = freezed,
    Object? dutyCount = freezed,
    Object? exchangeCount = freezed,
    Object? availableCount = freezed,
    Object? routes = freezed,
    Object? vehicles = freezed,
    Object? getDutyAlerts = freezed,
    Object? connectionCount = freezed,
  }) {
    return _then(_$UserProfileDataModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      experience: freezed == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int?,
      profileUrl: freezed == profileUrl
          ? _value.profileUrl
          : profileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      isAadhaarVerified: freezed == isAadhaarVerified
          ? _value.isAadhaarVerified
          : isAadhaarVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDLVerified: freezed == isDLVerified
          ? _value.isDLVerified
          : isDLVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      verified: freezed == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool?,
      callReceivedCount: freezed == callReceivedCount
          ? _value.callReceivedCount
          : callReceivedCount // ignore: cast_nullable_to_non_nullable
              as int?,
      callDoneCount: freezed == callDoneCount
          ? _value.callDoneCount
          : callDoneCount // ignore: cast_nullable_to_non_nullable
              as int?,
      dutyCount: freezed == dutyCount
          ? _value.dutyCount
          : dutyCount // ignore: cast_nullable_to_non_nullable
              as int?,
      exchangeCount: freezed == exchangeCount
          ? _value.exchangeCount
          : exchangeCount // ignore: cast_nullable_to_non_nullable
              as int?,
      availableCount: freezed == availableCount
          ? _value.availableCount
          : availableCount // ignore: cast_nullable_to_non_nullable
              as int?,
      routes: freezed == routes
          ? _value._routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      vehicles: freezed == vehicles
          ? _value._vehicles
          : vehicles // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      getDutyAlerts: freezed == getDutyAlerts
          ? _value.getDutyAlerts
          : getDutyAlerts // ignore: cast_nullable_to_non_nullable
              as bool?,
      connectionCount: freezed == connectionCount
          ? _value.connectionCount
          : connectionCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileDataModelImpl implements _UserProfileDataModel {
  _$UserProfileDataModelImpl(
      {this.id,
      this.name,
      this.city,
      this.experience,
      this.profileUrl,
      @JsonKey(name: 'profile_image') this.profileImage,
      this.isAadhaarVerified,
      this.isDLVerified,
      this.verified,
      this.callReceivedCount,
      this.callDoneCount,
      this.dutyCount,
      this.exchangeCount,
      this.availableCount,
      final List<dynamic>? routes,
      final List<dynamic>? vehicles,
      this.getDutyAlerts,
      this.connectionCount})
      : _routes = routes,
        _vehicles = vehicles;

  factory _$UserProfileDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileDataModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? city;
  @override
  final int? experience;
  @override
  final String? profileUrl;
  @override
  @JsonKey(name: 'profile_image')
  final String? profileImage;
  @override
  final bool? isAadhaarVerified;
  @override
  final bool? isDLVerified;
  @override
  final bool? verified;
  @override
  final int? callReceivedCount;
  @override
  final int? callDoneCount;
  @override
  final int? dutyCount;
  @override
  final int? exchangeCount;
  @override
  final int? availableCount;
  final List<dynamic>? _routes;
  @override
  List<dynamic>? get routes {
    final value = _routes;
    if (value == null) return null;
    if (_routes is EqualUnmodifiableListView) return _routes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<dynamic>? _vehicles;
  @override
  List<dynamic>? get vehicles {
    final value = _vehicles;
    if (value == null) return null;
    if (_vehicles is EqualUnmodifiableListView) return _vehicles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? getDutyAlerts;
  @override
  final int? connectionCount;

  @override
  String toString() {
    return 'UserProfileDataModel(id: $id, name: $name, city: $city, experience: $experience, profileUrl: $profileUrl, profileImage: $profileImage, isAadhaarVerified: $isAadhaarVerified, isDLVerified: $isDLVerified, verified: $verified, callReceivedCount: $callReceivedCount, callDoneCount: $callDoneCount, dutyCount: $dutyCount, exchangeCount: $exchangeCount, availableCount: $availableCount, routes: $routes, vehicles: $vehicles, getDutyAlerts: $getDutyAlerts, connectionCount: $connectionCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileDataModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.profileUrl, profileUrl) ||
                other.profileUrl == profileUrl) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.isAadhaarVerified, isAadhaarVerified) ||
                other.isAadhaarVerified == isAadhaarVerified) &&
            (identical(other.isDLVerified, isDLVerified) ||
                other.isDLVerified == isDLVerified) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.callReceivedCount, callReceivedCount) ||
                other.callReceivedCount == callReceivedCount) &&
            (identical(other.callDoneCount, callDoneCount) ||
                other.callDoneCount == callDoneCount) &&
            (identical(other.dutyCount, dutyCount) ||
                other.dutyCount == dutyCount) &&
            (identical(other.exchangeCount, exchangeCount) ||
                other.exchangeCount == exchangeCount) &&
            (identical(other.availableCount, availableCount) ||
                other.availableCount == availableCount) &&
            const DeepCollectionEquality().equals(other._routes, _routes) &&
            const DeepCollectionEquality().equals(other._vehicles, _vehicles) &&
            (identical(other.getDutyAlerts, getDutyAlerts) ||
                other.getDutyAlerts == getDutyAlerts) &&
            (identical(other.connectionCount, connectionCount) ||
                other.connectionCount == connectionCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      city,
      experience,
      profileUrl,
      profileImage,
      isAadhaarVerified,
      isDLVerified,
      verified,
      callReceivedCount,
      callDoneCount,
      dutyCount,
      exchangeCount,
      availableCount,
      const DeepCollectionEquality().hash(_routes),
      const DeepCollectionEquality().hash(_vehicles),
      getDutyAlerts,
      connectionCount);

  /// Create a copy of UserProfileDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileDataModelImplCopyWith<_$UserProfileDataModelImpl>
      get copyWith =>
          __$$UserProfileDataModelImplCopyWithImpl<_$UserProfileDataModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileDataModelImplToJson(
      this,
    );
  }
}

abstract class _UserProfileDataModel implements UserProfileDataModel {
  factory _UserProfileDataModel(
      {final String? id,
      final String? name,
      final String? city,
      final int? experience,
      final String? profileUrl,
      @JsonKey(name: 'profile_image') final String? profileImage,
      final bool? isAadhaarVerified,
      final bool? isDLVerified,
      final bool? verified,
      final int? callReceivedCount,
      final int? callDoneCount,
      final int? dutyCount,
      final int? exchangeCount,
      final int? availableCount,
      final List<dynamic>? routes,
      final List<dynamic>? vehicles,
      final bool? getDutyAlerts,
      final int? connectionCount}) = _$UserProfileDataModelImpl;

  factory _UserProfileDataModel.fromJson(Map<String, dynamic> json) =
      _$UserProfileDataModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get city;
  @override
  int? get experience;
  @override
  String? get profileUrl;
  @override
  @JsonKey(name: 'profile_image')
  String? get profileImage;
  @override
  bool? get isAadhaarVerified;
  @override
  bool? get isDLVerified;
  @override
  bool? get verified;
  @override
  int? get callReceivedCount;
  @override
  int? get callDoneCount;
  @override
  int? get dutyCount;
  @override
  int? get exchangeCount;
  @override
  int? get availableCount;
  @override
  List<dynamic>? get routes;
  @override
  List<dynamic>? get vehicles;
  @override
  bool? get getDutyAlerts;
  @override
  int? get connectionCount;

  /// Create a copy of UserProfileDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileDataModelImplCopyWith<_$UserProfileDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationLocation _$NotificationLocationFromJson(Map<String, dynamic> json) {
  return _NotificationLocation.fromJson(json);
}

/// @nodoc
mixin _$NotificationLocation {
  String? get location => throw _privateConstructorUsedError;
  Coordinates? get coordinates => throw _privateConstructorUsedError;

  /// Serializes this NotificationLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationLocationCopyWith<NotificationLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationLocationCopyWith<$Res> {
  factory $NotificationLocationCopyWith(NotificationLocation value,
          $Res Function(NotificationLocation) then) =
      _$NotificationLocationCopyWithImpl<$Res, NotificationLocation>;
  @useResult
  $Res call({String? location, Coordinates? coordinates});

  $CoordinatesCopyWith<$Res>? get coordinates;
}

/// @nodoc
class _$NotificationLocationCopyWithImpl<$Res,
        $Val extends NotificationLocation>
    implements $NotificationLocationCopyWith<$Res> {
  _$NotificationLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = freezed,
    Object? coordinates = freezed,
  }) {
    return _then(_value.copyWith(
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      coordinates: freezed == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as Coordinates?,
    ) as $Val);
  }

  /// Create a copy of NotificationLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CoordinatesCopyWith<$Res>? get coordinates {
    if (_value.coordinates == null) {
      return null;
    }

    return $CoordinatesCopyWith<$Res>(_value.coordinates!, (value) {
      return _then(_value.copyWith(coordinates: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationLocationImplCopyWith<$Res>
    implements $NotificationLocationCopyWith<$Res> {
  factory _$$NotificationLocationImplCopyWith(_$NotificationLocationImpl value,
          $Res Function(_$NotificationLocationImpl) then) =
      __$$NotificationLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? location, Coordinates? coordinates});

  @override
  $CoordinatesCopyWith<$Res>? get coordinates;
}

/// @nodoc
class __$$NotificationLocationImplCopyWithImpl<$Res>
    extends _$NotificationLocationCopyWithImpl<$Res, _$NotificationLocationImpl>
    implements _$$NotificationLocationImplCopyWith<$Res> {
  __$$NotificationLocationImplCopyWithImpl(_$NotificationLocationImpl _value,
      $Res Function(_$NotificationLocationImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = freezed,
    Object? coordinates = freezed,
  }) {
    return _then(_$NotificationLocationImpl(
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      coordinates: freezed == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as Coordinates?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationLocationImpl implements _NotificationLocation {
  _$NotificationLocationImpl({this.location, this.coordinates});

  factory _$NotificationLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationLocationImplFromJson(json);

  @override
  final String? location;
  @override
  final Coordinates? coordinates;

  @override
  String toString() {
    return 'NotificationLocation(location: $location, coordinates: $coordinates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationLocationImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.coordinates, coordinates) ||
                other.coordinates == coordinates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, location, coordinates);

  /// Create a copy of NotificationLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationLocationImplCopyWith<_$NotificationLocationImpl>
      get copyWith =>
          __$$NotificationLocationImplCopyWithImpl<_$NotificationLocationImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationLocationImplToJson(
      this,
    );
  }
}

abstract class _NotificationLocation implements NotificationLocation {
  factory _NotificationLocation(
      {final String? location,
      final Coordinates? coordinates}) = _$NotificationLocationImpl;

  factory _NotificationLocation.fromJson(Map<String, dynamic> json) =
      _$NotificationLocationImpl.fromJson;

  @override
  String? get location;
  @override
  Coordinates? get coordinates;

  /// Create a copy of NotificationLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationLocationImplCopyWith<_$NotificationLocationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) {
  return _Coordinates.fromJson(json);
}

/// @nodoc
mixin _$Coordinates {
  String? get lat => throw _privateConstructorUsedError;
  String? get lng => throw _privateConstructorUsedError;

  /// Serializes this Coordinates to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Coordinates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoordinatesCopyWith<Coordinates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoordinatesCopyWith<$Res> {
  factory $CoordinatesCopyWith(
          Coordinates value, $Res Function(Coordinates) then) =
      _$CoordinatesCopyWithImpl<$Res, Coordinates>;
  @useResult
  $Res call({String? lat, String? lng});
}

/// @nodoc
class _$CoordinatesCopyWithImpl<$Res, $Val extends Coordinates>
    implements $CoordinatesCopyWith<$Res> {
  _$CoordinatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Coordinates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(_value.copyWith(
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String?,
      lng: freezed == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CoordinatesImplCopyWith<$Res>
    implements $CoordinatesCopyWith<$Res> {
  factory _$$CoordinatesImplCopyWith(
          _$CoordinatesImpl value, $Res Function(_$CoordinatesImpl) then) =
      __$$CoordinatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? lat, String? lng});
}

/// @nodoc
class __$$CoordinatesImplCopyWithImpl<$Res>
    extends _$CoordinatesCopyWithImpl<$Res, _$CoordinatesImpl>
    implements _$$CoordinatesImplCopyWith<$Res> {
  __$$CoordinatesImplCopyWithImpl(
      _$CoordinatesImpl _value, $Res Function(_$CoordinatesImpl) _then)
      : super(_value, _then);

  /// Create a copy of Coordinates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(_$CoordinatesImpl(
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String?,
      lng: freezed == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CoordinatesImpl implements _Coordinates {
  _$CoordinatesImpl({this.lat, this.lng});

  factory _$CoordinatesImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoordinatesImplFromJson(json);

  @override
  final String? lat;
  @override
  final String? lng;

  @override
  String toString() {
    return 'Coordinates(lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoordinatesImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng);

  /// Create a copy of Coordinates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoordinatesImplCopyWith<_$CoordinatesImpl> get copyWith =>
      __$$CoordinatesImplCopyWithImpl<_$CoordinatesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoordinatesImplToJson(
      this,
    );
  }
}

abstract class _Coordinates implements Coordinates {
  factory _Coordinates({final String? lat, final String? lng}) =
      _$CoordinatesImpl;

  factory _Coordinates.fromJson(Map<String, dynamic> json) =
      _$CoordinatesImpl.fromJson;

  @override
  String? get lat;
  @override
  String? get lng;

  /// Create a copy of Coordinates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoordinatesImplCopyWith<_$CoordinatesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
