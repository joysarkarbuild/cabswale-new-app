// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lead_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeadModel _$LeadModelFromJson(Map<String, dynamic> json) {
  return _LeadModel.fromJson(json);
}

/// @nodoc
mixin _$LeadModel {
  String? get id => throw _privateConstructorUsedError;
  @TimestampToDateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  bool? get active => throw _privateConstructorUsedError;
  bool? get verified => throw _privateConstructorUsedError;
  CreatedBy? get createdBy => throw _privateConstructorUsedError;
  From? get from => throw _privateConstructorUsedError;
  From? get to => throw _privateConstructorUsedError;
  String? get carType => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  dynamic get at => throw _privateConstructorUsedError;
  dynamic get metaData => throw _privateConstructorUsedError;
  String? get leadType => throw _privateConstructorUsedError;
  String? get shareImage => throw _privateConstructorUsedError;
  int get otp => throw _privateConstructorUsedError;

  /// Serializes this LeadModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeadModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeadModelCopyWith<LeadModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeadModelCopyWith<$Res> {
  factory $LeadModelCopyWith(LeadModel value, $Res Function(LeadModel) then) =
      _$LeadModelCopyWithImpl<$Res, LeadModel>;
  @useResult
  $Res call(
      {String? id,
      @TimestampToDateTimeConverter() DateTime? createdAt,
      bool? active,
      bool? verified,
      CreatedBy? createdBy,
      From? from,
      From? to,
      String? carType,
      String? message,
      String? status,
      dynamic at,
      dynamic metaData,
      String? leadType,
      String? shareImage,
      int otp});

  $CreatedByCopyWith<$Res>? get createdBy;
  $FromCopyWith<$Res>? get from;
  $FromCopyWith<$Res>? get to;
}

/// @nodoc
class _$LeadModelCopyWithImpl<$Res, $Val extends LeadModel>
    implements $LeadModelCopyWith<$Res> {
  _$LeadModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeadModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? active = freezed,
    Object? verified = freezed,
    Object? createdBy = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? carType = freezed,
    Object? message = freezed,
    Object? status = freezed,
    Object? at = freezed,
    Object? metaData = freezed,
    Object? leadType = freezed,
    Object? shareImage = freezed,
    Object? otp = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      verified: freezed == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as CreatedBy?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as From?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as From?,
      carType: freezed == carType
          ? _value.carType
          : carType // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      at: freezed == at
          ? _value.at
          : at // ignore: cast_nullable_to_non_nullable
              as dynamic,
      metaData: freezed == metaData
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as dynamic,
      leadType: freezed == leadType
          ? _value.leadType
          : leadType // ignore: cast_nullable_to_non_nullable
              as String?,
      shareImage: freezed == shareImage
          ? _value.shareImage
          : shareImage // ignore: cast_nullable_to_non_nullable
              as String?,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of LeadModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CreatedByCopyWith<$Res>? get createdBy {
    if (_value.createdBy == null) {
      return null;
    }

    return $CreatedByCopyWith<$Res>(_value.createdBy!, (value) {
      return _then(_value.copyWith(createdBy: value) as $Val);
    });
  }

  /// Create a copy of LeadModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FromCopyWith<$Res>? get from {
    if (_value.from == null) {
      return null;
    }

    return $FromCopyWith<$Res>(_value.from!, (value) {
      return _then(_value.copyWith(from: value) as $Val);
    });
  }

  /// Create a copy of LeadModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FromCopyWith<$Res>? get to {
    if (_value.to == null) {
      return null;
    }

    return $FromCopyWith<$Res>(_value.to!, (value) {
      return _then(_value.copyWith(to: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LeadModelImplCopyWith<$Res>
    implements $LeadModelCopyWith<$Res> {
  factory _$$LeadModelImplCopyWith(
          _$LeadModelImpl value, $Res Function(_$LeadModelImpl) then) =
      __$$LeadModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @TimestampToDateTimeConverter() DateTime? createdAt,
      bool? active,
      bool? verified,
      CreatedBy? createdBy,
      From? from,
      From? to,
      String? carType,
      String? message,
      String? status,
      dynamic at,
      dynamic metaData,
      String? leadType,
      String? shareImage,
      int otp});

  @override
  $CreatedByCopyWith<$Res>? get createdBy;
  @override
  $FromCopyWith<$Res>? get from;
  @override
  $FromCopyWith<$Res>? get to;
}

/// @nodoc
class __$$LeadModelImplCopyWithImpl<$Res>
    extends _$LeadModelCopyWithImpl<$Res, _$LeadModelImpl>
    implements _$$LeadModelImplCopyWith<$Res> {
  __$$LeadModelImplCopyWithImpl(
      _$LeadModelImpl _value, $Res Function(_$LeadModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeadModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? active = freezed,
    Object? verified = freezed,
    Object? createdBy = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? carType = freezed,
    Object? message = freezed,
    Object? status = freezed,
    Object? at = freezed,
    Object? metaData = freezed,
    Object? leadType = freezed,
    Object? shareImage = freezed,
    Object? otp = null,
  }) {
    return _then(_$LeadModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      verified: freezed == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as CreatedBy?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as From?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as From?,
      carType: freezed == carType
          ? _value.carType
          : carType // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      at: freezed == at
          ? _value.at
          : at // ignore: cast_nullable_to_non_nullable
              as dynamic,
      metaData: freezed == metaData
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as dynamic,
      leadType: freezed == leadType
          ? _value.leadType
          : leadType // ignore: cast_nullable_to_non_nullable
              as String?,
      shareImage: freezed == shareImage
          ? _value.shareImage
          : shareImage // ignore: cast_nullable_to_non_nullable
              as String?,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeadModelImpl implements _LeadModel {
  const _$LeadModelImpl(
      {this.id,
      @TimestampToDateTimeConverter() this.createdAt,
      this.active,
      this.verified,
      this.createdBy,
      this.from,
      this.to,
      this.carType,
      this.message,
      this.status,
      this.at,
      this.metaData,
      this.leadType,
      this.shareImage,
      this.otp = 100000});

  factory _$LeadModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeadModelImplFromJson(json);

  @override
  final String? id;
  @override
  @TimestampToDateTimeConverter()
  final DateTime? createdAt;
  @override
  final bool? active;
  @override
  final bool? verified;
  @override
  final CreatedBy? createdBy;
  @override
  final From? from;
  @override
  final From? to;
  @override
  final String? carType;
  @override
  final String? message;
  @override
  final String? status;
  @override
  final dynamic at;
  @override
  final dynamic metaData;
  @override
  final String? leadType;
  @override
  final String? shareImage;
  @override
  @JsonKey()
  final int otp;

  @override
  String toString() {
    return 'LeadModel(id: $id, createdAt: $createdAt, active: $active, verified: $verified, createdBy: $createdBy, from: $from, to: $to, carType: $carType, message: $message, status: $status, at: $at, metaData: $metaData, leadType: $leadType, shareImage: $shareImage, otp: $otp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeadModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.carType, carType) || other.carType == carType) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.at, at) &&
            const DeepCollectionEquality().equals(other.metaData, metaData) &&
            (identical(other.leadType, leadType) ||
                other.leadType == leadType) &&
            (identical(other.shareImage, shareImage) ||
                other.shareImage == shareImage) &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      active,
      verified,
      createdBy,
      from,
      to,
      carType,
      message,
      status,
      const DeepCollectionEquality().hash(at),
      const DeepCollectionEquality().hash(metaData),
      leadType,
      shareImage,
      otp);

  /// Create a copy of LeadModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeadModelImplCopyWith<_$LeadModelImpl> get copyWith =>
      __$$LeadModelImplCopyWithImpl<_$LeadModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeadModelImplToJson(
      this,
    );
  }
}

abstract class _LeadModel implements LeadModel {
  const factory _LeadModel(
      {final String? id,
      @TimestampToDateTimeConverter() final DateTime? createdAt,
      final bool? active,
      final bool? verified,
      final CreatedBy? createdBy,
      final From? from,
      final From? to,
      final String? carType,
      final String? message,
      final String? status,
      final dynamic at,
      final dynamic metaData,
      final String? leadType,
      final String? shareImage,
      final int otp}) = _$LeadModelImpl;

  factory _LeadModel.fromJson(Map<String, dynamic> json) =
      _$LeadModelImpl.fromJson;

  @override
  String? get id;
  @override
  @TimestampToDateTimeConverter()
  DateTime? get createdAt;
  @override
  bool? get active;
  @override
  bool? get verified;
  @override
  CreatedBy? get createdBy;
  @override
  From? get from;
  @override
  From? get to;
  @override
  String? get carType;
  @override
  String? get message;
  @override
  String? get status;
  @override
  dynamic get at;
  @override
  dynamic get metaData;
  @override
  String? get leadType;
  @override
  String? get shareImage;
  @override
  int get otp;

  /// Create a copy of LeadModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeadModelImplCopyWith<_$LeadModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) {
  return _CreatedBy.fromJson(json);
}

/// @nodoc
mixin _$CreatedBy {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phoneNo => throw _privateConstructorUsedError;
  bool? get verified => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  int? get connections => throw _privateConstructorUsedError;
  bool? get fraud => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;

  /// Serializes this CreatedBy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreatedBy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatedByCopyWith<CreatedBy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatedByCopyWith<$Res> {
  factory $CreatedByCopyWith(CreatedBy value, $Res Function(CreatedBy) then) =
      _$CreatedByCopyWithImpl<$Res, CreatedBy>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? phoneNo,
      bool? verified,
      String? city,
      int? connections,
      bool? fraud,
      String? profileImage});
}

/// @nodoc
class _$CreatedByCopyWithImpl<$Res, $Val extends CreatedBy>
    implements $CreatedByCopyWith<$Res> {
  _$CreatedByCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatedBy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phoneNo = freezed,
    Object? verified = freezed,
    Object? city = freezed,
    Object? connections = freezed,
    Object? fraud = freezed,
    Object? profileImage = freezed,
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
      phoneNo: freezed == phoneNo
          ? _value.phoneNo
          : phoneNo // ignore: cast_nullable_to_non_nullable
              as String?,
      verified: freezed == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      connections: freezed == connections
          ? _value.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as int?,
      fraud: freezed == fraud
          ? _value.fraud
          : fraud // ignore: cast_nullable_to_non_nullable
              as bool?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatedByImplCopyWith<$Res>
    implements $CreatedByCopyWith<$Res> {
  factory _$$CreatedByImplCopyWith(
          _$CreatedByImpl value, $Res Function(_$CreatedByImpl) then) =
      __$$CreatedByImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? phoneNo,
      bool? verified,
      String? city,
      int? connections,
      bool? fraud,
      String? profileImage});
}

/// @nodoc
class __$$CreatedByImplCopyWithImpl<$Res>
    extends _$CreatedByCopyWithImpl<$Res, _$CreatedByImpl>
    implements _$$CreatedByImplCopyWith<$Res> {
  __$$CreatedByImplCopyWithImpl(
      _$CreatedByImpl _value, $Res Function(_$CreatedByImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatedBy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phoneNo = freezed,
    Object? verified = freezed,
    Object? city = freezed,
    Object? connections = freezed,
    Object? fraud = freezed,
    Object? profileImage = freezed,
  }) {
    return _then(_$CreatedByImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNo: freezed == phoneNo
          ? _value.phoneNo
          : phoneNo // ignore: cast_nullable_to_non_nullable
              as String?,
      verified: freezed == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      connections: freezed == connections
          ? _value.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as int?,
      fraud: freezed == fraud
          ? _value.fraud
          : fraud // ignore: cast_nullable_to_non_nullable
              as bool?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatedByImpl implements _CreatedBy {
  const _$CreatedByImpl(
      {this.id,
      this.name,
      this.phoneNo,
      this.verified,
      this.city,
      this.connections,
      this.fraud,
      this.profileImage});

  factory _$CreatedByImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatedByImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? phoneNo;
  @override
  final bool? verified;
  @override
  final String? city;
  @override
  final int? connections;
  @override
  final bool? fraud;
  @override
  final String? profileImage;

  @override
  String toString() {
    return 'CreatedBy(id: $id, name: $name, phoneNo: $phoneNo, verified: $verified, city: $city, connections: $connections, fraud: $fraud, profileImage: $profileImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatedByImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.connections, connections) ||
                other.connections == connections) &&
            (identical(other.fraud, fraud) || other.fraud == fraud) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phoneNo, verified,
      city, connections, fraud, profileImage);

  /// Create a copy of CreatedBy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatedByImplCopyWith<_$CreatedByImpl> get copyWith =>
      __$$CreatedByImplCopyWithImpl<_$CreatedByImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatedByImplToJson(
      this,
    );
  }
}

abstract class _CreatedBy implements CreatedBy {
  const factory _CreatedBy(
      {final String? id,
      final String? name,
      final String? phoneNo,
      final bool? verified,
      final String? city,
      final int? connections,
      final bool? fraud,
      final String? profileImage}) = _$CreatedByImpl;

  factory _CreatedBy.fromJson(Map<String, dynamic> json) =
      _$CreatedByImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get phoneNo;
  @override
  bool? get verified;
  @override
  String? get city;
  @override
  int? get connections;
  @override
  bool? get fraud;
  @override
  String? get profileImage;

  /// Create a copy of CreatedBy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatedByImplCopyWith<_$CreatedByImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

From _$FromFromJson(Map<String, dynamic> json) {
  return _From.fromJson(json);
}

/// @nodoc
mixin _$From {
  String? get city => throw _privateConstructorUsedError;

  /// Serializes this From to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of From
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FromCopyWith<From> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FromCopyWith<$Res> {
  factory $FromCopyWith(From value, $Res Function(From) then) =
      _$FromCopyWithImpl<$Res, From>;
  @useResult
  $Res call({String? city});
}

/// @nodoc
class _$FromCopyWithImpl<$Res, $Val extends From>
    implements $FromCopyWith<$Res> {
  _$FromCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of From
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = freezed,
  }) {
    return _then(_value.copyWith(
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FromImplCopyWith<$Res> implements $FromCopyWith<$Res> {
  factory _$$FromImplCopyWith(
          _$FromImpl value, $Res Function(_$FromImpl) then) =
      __$$FromImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? city});
}

/// @nodoc
class __$$FromImplCopyWithImpl<$Res>
    extends _$FromCopyWithImpl<$Res, _$FromImpl>
    implements _$$FromImplCopyWith<$Res> {
  __$$FromImplCopyWithImpl(_$FromImpl _value, $Res Function(_$FromImpl) _then)
      : super(_value, _then);

  /// Create a copy of From
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = freezed,
  }) {
    return _then(_$FromImpl(
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FromImpl implements _From {
  const _$FromImpl({this.city});

  factory _$FromImpl.fromJson(Map<String, dynamic> json) =>
      _$$FromImplFromJson(json);

  @override
  final String? city;

  @override
  String toString() {
    return 'From(city: $city)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FromImpl &&
            (identical(other.city, city) || other.city == city));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, city);

  /// Create a copy of From
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FromImplCopyWith<_$FromImpl> get copyWith =>
      __$$FromImplCopyWithImpl<_$FromImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FromImplToJson(
      this,
    );
  }
}

abstract class _From implements From {
  const factory _From({final String? city}) = _$FromImpl;

  factory _From.fromJson(Map<String, dynamic> json) = _$FromImpl.fromJson;

  @override
  String? get city;

  /// Create a copy of From
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FromImplCopyWith<_$FromImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
