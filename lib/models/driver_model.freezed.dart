// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DriverModel _$DriverModelFromJson(Map<String, dynamic> json) {
  return _DriverModel.fromJson(json);
}

/// @nodoc
mixin _$DriverModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phoneNo => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  List<dynamic> get deviceTokens => throw _privateConstructorUsedError;
  bool get conditionAccepted => throw _privateConstructorUsedError;
  Kyc? get kyc => throw _privateConstructorUsedError;
  String get notificationPlace => throw _privateConstructorUsedError;
  bool get notificationAlert => throw _privateConstructorUsedError;
  List<dynamic> get notificationLocations => throw _privateConstructorUsedError;
  bool get autoApproveLeads => throw _privateConstructorUsedError;
  @TimestampToDateTimeConverter()
  DateTime? get lastAccess => throw _privateConstructorUsedError;
  bool get verified => throw _privateConstructorUsedError;
  int get stage => throw _privateConstructorUsedError;
  int get appVersion => throw _privateConstructorUsedError;
  List<dynamic> get deviceList => throw _privateConstructorUsedError;
  Refer? get refer => throw _privateConstructorUsedError;
  Membership? get membership => throw _privateConstructorUsedError;
  Wallet? get wallet => throw _privateConstructorUsedError;
  int get totalLeads => throw _privateConstructorUsedError;
  int get outGoingCalls => throw _privateConstructorUsedError;
  int get dealCount => throw _privateConstructorUsedError;
  bool get customOffer => throw _privateConstructorUsedError;
  String get sessionId => throw _privateConstructorUsedError;

  /// Serializes this DriverModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DriverModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverModelCopyWith<DriverModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverModelCopyWith<$Res> {
  factory $DriverModelCopyWith(
          DriverModel value, $Res Function(DriverModel) then) =
      _$DriverModelCopyWithImpl<$Res, DriverModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String phoneNo,
      dynamic createdAt,
      List<dynamic> deviceTokens,
      bool conditionAccepted,
      Kyc? kyc,
      String notificationPlace,
      bool notificationAlert,
      List<dynamic> notificationLocations,
      bool autoApproveLeads,
      @TimestampToDateTimeConverter() DateTime? lastAccess,
      bool verified,
      int stage,
      int appVersion,
      List<dynamic> deviceList,
      Refer? refer,
      Membership? membership,
      Wallet? wallet,
      int totalLeads,
      int outGoingCalls,
      int dealCount,
      bool customOffer,
      String sessionId});

  $KycCopyWith<$Res>? get kyc;
  $ReferCopyWith<$Res>? get refer;
  $MembershipCopyWith<$Res>? get membership;
  $WalletCopyWith<$Res>? get wallet;
}

/// @nodoc
class _$DriverModelCopyWithImpl<$Res, $Val extends DriverModel>
    implements $DriverModelCopyWith<$Res> {
  _$DriverModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DriverModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNo = null,
    Object? createdAt = freezed,
    Object? deviceTokens = null,
    Object? conditionAccepted = null,
    Object? kyc = freezed,
    Object? notificationPlace = null,
    Object? notificationAlert = null,
    Object? notificationLocations = null,
    Object? autoApproveLeads = null,
    Object? lastAccess = freezed,
    Object? verified = null,
    Object? stage = null,
    Object? appVersion = null,
    Object? deviceList = null,
    Object? refer = freezed,
    Object? membership = freezed,
    Object? wallet = freezed,
    Object? totalLeads = null,
    Object? outGoingCalls = null,
    Object? dealCount = null,
    Object? customOffer = null,
    Object? sessionId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNo: null == phoneNo
          ? _value.phoneNo
          : phoneNo // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      deviceTokens: null == deviceTokens
          ? _value.deviceTokens
          : deviceTokens // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      conditionAccepted: null == conditionAccepted
          ? _value.conditionAccepted
          : conditionAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
      kyc: freezed == kyc
          ? _value.kyc
          : kyc // ignore: cast_nullable_to_non_nullable
              as Kyc?,
      notificationPlace: null == notificationPlace
          ? _value.notificationPlace
          : notificationPlace // ignore: cast_nullable_to_non_nullable
              as String,
      notificationAlert: null == notificationAlert
          ? _value.notificationAlert
          : notificationAlert // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationLocations: null == notificationLocations
          ? _value.notificationLocations
          : notificationLocations // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      autoApproveLeads: null == autoApproveLeads
          ? _value.autoApproveLeads
          : autoApproveLeads // ignore: cast_nullable_to_non_nullable
              as bool,
      lastAccess: freezed == lastAccess
          ? _value.lastAccess
          : lastAccess // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      verified: null == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as int,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as int,
      deviceList: null == deviceList
          ? _value.deviceList
          : deviceList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      refer: freezed == refer
          ? _value.refer
          : refer // ignore: cast_nullable_to_non_nullable
              as Refer?,
      membership: freezed == membership
          ? _value.membership
          : membership // ignore: cast_nullable_to_non_nullable
              as Membership?,
      wallet: freezed == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as Wallet?,
      totalLeads: null == totalLeads
          ? _value.totalLeads
          : totalLeads // ignore: cast_nullable_to_non_nullable
              as int,
      outGoingCalls: null == outGoingCalls
          ? _value.outGoingCalls
          : outGoingCalls // ignore: cast_nullable_to_non_nullable
              as int,
      dealCount: null == dealCount
          ? _value.dealCount
          : dealCount // ignore: cast_nullable_to_non_nullable
              as int,
      customOffer: null == customOffer
          ? _value.customOffer
          : customOffer // ignore: cast_nullable_to_non_nullable
              as bool,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of DriverModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KycCopyWith<$Res>? get kyc {
    if (_value.kyc == null) {
      return null;
    }

    return $KycCopyWith<$Res>(_value.kyc!, (value) {
      return _then(_value.copyWith(kyc: value) as $Val);
    });
  }

  /// Create a copy of DriverModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferCopyWith<$Res>? get refer {
    if (_value.refer == null) {
      return null;
    }

    return $ReferCopyWith<$Res>(_value.refer!, (value) {
      return _then(_value.copyWith(refer: value) as $Val);
    });
  }

  /// Create a copy of DriverModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MembershipCopyWith<$Res>? get membership {
    if (_value.membership == null) {
      return null;
    }

    return $MembershipCopyWith<$Res>(_value.membership!, (value) {
      return _then(_value.copyWith(membership: value) as $Val);
    });
  }

  /// Create a copy of DriverModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletCopyWith<$Res>? get wallet {
    if (_value.wallet == null) {
      return null;
    }

    return $WalletCopyWith<$Res>(_value.wallet!, (value) {
      return _then(_value.copyWith(wallet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DriverModelImplCopyWith<$Res>
    implements $DriverModelCopyWith<$Res> {
  factory _$$DriverModelImplCopyWith(
          _$DriverModelImpl value, $Res Function(_$DriverModelImpl) then) =
      __$$DriverModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String phoneNo,
      dynamic createdAt,
      List<dynamic> deviceTokens,
      bool conditionAccepted,
      Kyc? kyc,
      String notificationPlace,
      bool notificationAlert,
      List<dynamic> notificationLocations,
      bool autoApproveLeads,
      @TimestampToDateTimeConverter() DateTime? lastAccess,
      bool verified,
      int stage,
      int appVersion,
      List<dynamic> deviceList,
      Refer? refer,
      Membership? membership,
      Wallet? wallet,
      int totalLeads,
      int outGoingCalls,
      int dealCount,
      bool customOffer,
      String sessionId});

  @override
  $KycCopyWith<$Res>? get kyc;
  @override
  $ReferCopyWith<$Res>? get refer;
  @override
  $MembershipCopyWith<$Res>? get membership;
  @override
  $WalletCopyWith<$Res>? get wallet;
}

/// @nodoc
class __$$DriverModelImplCopyWithImpl<$Res>
    extends _$DriverModelCopyWithImpl<$Res, _$DriverModelImpl>
    implements _$$DriverModelImplCopyWith<$Res> {
  __$$DriverModelImplCopyWithImpl(
      _$DriverModelImpl _value, $Res Function(_$DriverModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DriverModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNo = null,
    Object? createdAt = freezed,
    Object? deviceTokens = null,
    Object? conditionAccepted = null,
    Object? kyc = freezed,
    Object? notificationPlace = null,
    Object? notificationAlert = null,
    Object? notificationLocations = null,
    Object? autoApproveLeads = null,
    Object? lastAccess = freezed,
    Object? verified = null,
    Object? stage = null,
    Object? appVersion = null,
    Object? deviceList = null,
    Object? refer = freezed,
    Object? membership = freezed,
    Object? wallet = freezed,
    Object? totalLeads = null,
    Object? outGoingCalls = null,
    Object? dealCount = null,
    Object? customOffer = null,
    Object? sessionId = null,
  }) {
    return _then(_$DriverModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNo: null == phoneNo
          ? _value.phoneNo
          : phoneNo // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      deviceTokens: null == deviceTokens
          ? _value._deviceTokens
          : deviceTokens // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      conditionAccepted: null == conditionAccepted
          ? _value.conditionAccepted
          : conditionAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
      kyc: freezed == kyc
          ? _value.kyc
          : kyc // ignore: cast_nullable_to_non_nullable
              as Kyc?,
      notificationPlace: null == notificationPlace
          ? _value.notificationPlace
          : notificationPlace // ignore: cast_nullable_to_non_nullable
              as String,
      notificationAlert: null == notificationAlert
          ? _value.notificationAlert
          : notificationAlert // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationLocations: null == notificationLocations
          ? _value._notificationLocations
          : notificationLocations // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      autoApproveLeads: null == autoApproveLeads
          ? _value.autoApproveLeads
          : autoApproveLeads // ignore: cast_nullable_to_non_nullable
              as bool,
      lastAccess: freezed == lastAccess
          ? _value.lastAccess
          : lastAccess // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      verified: null == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as int,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as int,
      deviceList: null == deviceList
          ? _value._deviceList
          : deviceList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      refer: freezed == refer
          ? _value.refer
          : refer // ignore: cast_nullable_to_non_nullable
              as Refer?,
      membership: freezed == membership
          ? _value.membership
          : membership // ignore: cast_nullable_to_non_nullable
              as Membership?,
      wallet: freezed == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as Wallet?,
      totalLeads: null == totalLeads
          ? _value.totalLeads
          : totalLeads // ignore: cast_nullable_to_non_nullable
              as int,
      outGoingCalls: null == outGoingCalls
          ? _value.outGoingCalls
          : outGoingCalls // ignore: cast_nullable_to_non_nullable
              as int,
      dealCount: null == dealCount
          ? _value.dealCount
          : dealCount // ignore: cast_nullable_to_non_nullable
              as int,
      customOffer: null == customOffer
          ? _value.customOffer
          : customOffer // ignore: cast_nullable_to_non_nullable
              as bool,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverModelImpl implements _DriverModel {
  const _$DriverModelImpl(
      {this.id = '',
      this.name = '',
      this.phoneNo = '',
      this.createdAt,
      final List<dynamic> deviceTokens = const [],
      this.conditionAccepted = false,
      this.kyc,
      this.notificationPlace = '',
      this.notificationAlert = false,
      final List<dynamic> notificationLocations = const [],
      this.autoApproveLeads = false,
      @TimestampToDateTimeConverter() this.lastAccess,
      this.verified = false,
      this.stage = 0,
      this.appVersion = 0,
      final List<dynamic> deviceList = const [],
      this.refer,
      this.membership,
      this.wallet,
      this.totalLeads = 0,
      this.outGoingCalls = 0,
      this.dealCount = 0,
      this.customOffer = false,
      this.sessionId = ''})
      : _deviceTokens = deviceTokens,
        _notificationLocations = notificationLocations,
        _deviceList = deviceList;

  factory _$DriverModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverModelImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String phoneNo;
  @override
  final dynamic createdAt;
  final List<dynamic> _deviceTokens;
  @override
  @JsonKey()
  List<dynamic> get deviceTokens {
    if (_deviceTokens is EqualUnmodifiableListView) return _deviceTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deviceTokens);
  }

  @override
  @JsonKey()
  final bool conditionAccepted;
  @override
  final Kyc? kyc;
  @override
  @JsonKey()
  final String notificationPlace;
  @override
  @JsonKey()
  final bool notificationAlert;
  final List<dynamic> _notificationLocations;
  @override
  @JsonKey()
  List<dynamic> get notificationLocations {
    if (_notificationLocations is EqualUnmodifiableListView)
      return _notificationLocations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notificationLocations);
  }

  @override
  @JsonKey()
  final bool autoApproveLeads;
  @override
  @TimestampToDateTimeConverter()
  final DateTime? lastAccess;
  @override
  @JsonKey()
  final bool verified;
  @override
  @JsonKey()
  final int stage;
  @override
  @JsonKey()
  final int appVersion;
  final List<dynamic> _deviceList;
  @override
  @JsonKey()
  List<dynamic> get deviceList {
    if (_deviceList is EqualUnmodifiableListView) return _deviceList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deviceList);
  }

  @override
  final Refer? refer;
  @override
  final Membership? membership;
  @override
  final Wallet? wallet;
  @override
  @JsonKey()
  final int totalLeads;
  @override
  @JsonKey()
  final int outGoingCalls;
  @override
  @JsonKey()
  final int dealCount;
  @override
  @JsonKey()
  final bool customOffer;
  @override
  @JsonKey()
  final String sessionId;

  @override
  String toString() {
    return 'DriverModel(id: $id, name: $name, phoneNo: $phoneNo, createdAt: $createdAt, deviceTokens: $deviceTokens, conditionAccepted: $conditionAccepted, kyc: $kyc, notificationPlace: $notificationPlace, notificationAlert: $notificationAlert, notificationLocations: $notificationLocations, autoApproveLeads: $autoApproveLeads, lastAccess: $lastAccess, verified: $verified, stage: $stage, appVersion: $appVersion, deviceList: $deviceList, refer: $refer, membership: $membership, wallet: $wallet, totalLeads: $totalLeads, outGoingCalls: $outGoingCalls, dealCount: $dealCount, customOffer: $customOffer, sessionId: $sessionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality()
                .equals(other._deviceTokens, _deviceTokens) &&
            (identical(other.conditionAccepted, conditionAccepted) ||
                other.conditionAccepted == conditionAccepted) &&
            (identical(other.kyc, kyc) || other.kyc == kyc) &&
            (identical(other.notificationPlace, notificationPlace) ||
                other.notificationPlace == notificationPlace) &&
            (identical(other.notificationAlert, notificationAlert) ||
                other.notificationAlert == notificationAlert) &&
            const DeepCollectionEquality()
                .equals(other._notificationLocations, _notificationLocations) &&
            (identical(other.autoApproveLeads, autoApproveLeads) ||
                other.autoApproveLeads == autoApproveLeads) &&
            (identical(other.lastAccess, lastAccess) ||
                other.lastAccess == lastAccess) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            const DeepCollectionEquality()
                .equals(other._deviceList, _deviceList) &&
            (identical(other.refer, refer) || other.refer == refer) &&
            (identical(other.membership, membership) ||
                other.membership == membership) &&
            (identical(other.wallet, wallet) || other.wallet == wallet) &&
            (identical(other.totalLeads, totalLeads) ||
                other.totalLeads == totalLeads) &&
            (identical(other.outGoingCalls, outGoingCalls) ||
                other.outGoingCalls == outGoingCalls) &&
            (identical(other.dealCount, dealCount) ||
                other.dealCount == dealCount) &&
            (identical(other.customOffer, customOffer) ||
                other.customOffer == customOffer) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        phoneNo,
        const DeepCollectionEquality().hash(createdAt),
        const DeepCollectionEquality().hash(_deviceTokens),
        conditionAccepted,
        kyc,
        notificationPlace,
        notificationAlert,
        const DeepCollectionEquality().hash(_notificationLocations),
        autoApproveLeads,
        lastAccess,
        verified,
        stage,
        appVersion,
        const DeepCollectionEquality().hash(_deviceList),
        refer,
        membership,
        wallet,
        totalLeads,
        outGoingCalls,
        dealCount,
        customOffer,
        sessionId
      ]);

  /// Create a copy of DriverModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverModelImplCopyWith<_$DriverModelImpl> get copyWith =>
      __$$DriverModelImplCopyWithImpl<_$DriverModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverModelImplToJson(
      this,
    );
  }
}

abstract class _DriverModel implements DriverModel {
  const factory _DriverModel(
      {final String id,
      final String name,
      final String phoneNo,
      final dynamic createdAt,
      final List<dynamic> deviceTokens,
      final bool conditionAccepted,
      final Kyc? kyc,
      final String notificationPlace,
      final bool notificationAlert,
      final List<dynamic> notificationLocations,
      final bool autoApproveLeads,
      @TimestampToDateTimeConverter() final DateTime? lastAccess,
      final bool verified,
      final int stage,
      final int appVersion,
      final List<dynamic> deviceList,
      final Refer? refer,
      final Membership? membership,
      final Wallet? wallet,
      final int totalLeads,
      final int outGoingCalls,
      final int dealCount,
      final bool customOffer,
      final String sessionId}) = _$DriverModelImpl;

  factory _DriverModel.fromJson(Map<String, dynamic> json) =
      _$DriverModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get phoneNo;
  @override
  dynamic get createdAt;
  @override
  List<dynamic> get deviceTokens;
  @override
  bool get conditionAccepted;
  @override
  Kyc? get kyc;
  @override
  String get notificationPlace;
  @override
  bool get notificationAlert;
  @override
  List<dynamic> get notificationLocations;
  @override
  bool get autoApproveLeads;
  @override
  @TimestampToDateTimeConverter()
  DateTime? get lastAccess;
  @override
  bool get verified;
  @override
  int get stage;
  @override
  int get appVersion;
  @override
  List<dynamic> get deviceList;
  @override
  Refer? get refer;
  @override
  Membership? get membership;
  @override
  Wallet? get wallet;
  @override
  int get totalLeads;
  @override
  int get outGoingCalls;
  @override
  int get dealCount;
  @override
  bool get customOffer;
  @override
  String get sessionId;

  /// Create a copy of DriverModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverModelImplCopyWith<_$DriverModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Kyc _$KycFromJson(Map<String, dynamic> json) {
  return _Kyc.fromJson(json);
}

/// @nodoc
mixin _$Kyc {
  bool get verified => throw _privateConstructorUsedError;
  bool get submitted => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get vehicleNo => throw _privateConstructorUsedError;
  dynamic get aadhaarPic => throw _privateConstructorUsedError;
  dynamic get licensePic => throw _privateConstructorUsedError;

  /// Serializes this Kyc to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Kyc
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KycCopyWith<Kyc> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KycCopyWith<$Res> {
  factory $KycCopyWith(Kyc value, $Res Function(Kyc) then) =
      _$KycCopyWithImpl<$Res, Kyc>;
  @useResult
  $Res call(
      {bool verified,
      bool submitted,
      String address,
      String vehicleNo,
      dynamic aadhaarPic,
      dynamic licensePic});
}

/// @nodoc
class _$KycCopyWithImpl<$Res, $Val extends Kyc> implements $KycCopyWith<$Res> {
  _$KycCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Kyc
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verified = null,
    Object? submitted = null,
    Object? address = null,
    Object? vehicleNo = null,
    Object? aadhaarPic = freezed,
    Object? licensePic = freezed,
  }) {
    return _then(_value.copyWith(
      verified: null == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      submitted: null == submitted
          ? _value.submitted
          : submitted // ignore: cast_nullable_to_non_nullable
              as bool,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleNo: null == vehicleNo
          ? _value.vehicleNo
          : vehicleNo // ignore: cast_nullable_to_non_nullable
              as String,
      aadhaarPic: freezed == aadhaarPic
          ? _value.aadhaarPic
          : aadhaarPic // ignore: cast_nullable_to_non_nullable
              as dynamic,
      licensePic: freezed == licensePic
          ? _value.licensePic
          : licensePic // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KycImplCopyWith<$Res> implements $KycCopyWith<$Res> {
  factory _$$KycImplCopyWith(_$KycImpl value, $Res Function(_$KycImpl) then) =
      __$$KycImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool verified,
      bool submitted,
      String address,
      String vehicleNo,
      dynamic aadhaarPic,
      dynamic licensePic});
}

/// @nodoc
class __$$KycImplCopyWithImpl<$Res> extends _$KycCopyWithImpl<$Res, _$KycImpl>
    implements _$$KycImplCopyWith<$Res> {
  __$$KycImplCopyWithImpl(_$KycImpl _value, $Res Function(_$KycImpl) _then)
      : super(_value, _then);

  /// Create a copy of Kyc
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verified = null,
    Object? submitted = null,
    Object? address = null,
    Object? vehicleNo = null,
    Object? aadhaarPic = freezed,
    Object? licensePic = freezed,
  }) {
    return _then(_$KycImpl(
      verified: null == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      submitted: null == submitted
          ? _value.submitted
          : submitted // ignore: cast_nullable_to_non_nullable
              as bool,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleNo: null == vehicleNo
          ? _value.vehicleNo
          : vehicleNo // ignore: cast_nullable_to_non_nullable
              as String,
      aadhaarPic: freezed == aadhaarPic
          ? _value.aadhaarPic
          : aadhaarPic // ignore: cast_nullable_to_non_nullable
              as dynamic,
      licensePic: freezed == licensePic
          ? _value.licensePic
          : licensePic // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KycImpl implements _Kyc {
  const _$KycImpl(
      {this.verified = false,
      this.submitted = false,
      this.address = '',
      this.vehicleNo = '',
      this.aadhaarPic,
      this.licensePic});

  factory _$KycImpl.fromJson(Map<String, dynamic> json) =>
      _$$KycImplFromJson(json);

  @override
  @JsonKey()
  final bool verified;
  @override
  @JsonKey()
  final bool submitted;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String vehicleNo;
  @override
  final dynamic aadhaarPic;
  @override
  final dynamic licensePic;

  @override
  String toString() {
    return 'Kyc(verified: $verified, submitted: $submitted, address: $address, vehicleNo: $vehicleNo, aadhaarPic: $aadhaarPic, licensePic: $licensePic)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KycImpl &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.submitted, submitted) ||
                other.submitted == submitted) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.vehicleNo, vehicleNo) ||
                other.vehicleNo == vehicleNo) &&
            const DeepCollectionEquality()
                .equals(other.aadhaarPic, aadhaarPic) &&
            const DeepCollectionEquality()
                .equals(other.licensePic, licensePic));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      verified,
      submitted,
      address,
      vehicleNo,
      const DeepCollectionEquality().hash(aadhaarPic),
      const DeepCollectionEquality().hash(licensePic));

  /// Create a copy of Kyc
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KycImplCopyWith<_$KycImpl> get copyWith =>
      __$$KycImplCopyWithImpl<_$KycImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KycImplToJson(
      this,
    );
  }
}

abstract class _Kyc implements Kyc {
  const factory _Kyc(
      {final bool verified,
      final bool submitted,
      final String address,
      final String vehicleNo,
      final dynamic aadhaarPic,
      final dynamic licensePic}) = _$KycImpl;

  factory _Kyc.fromJson(Map<String, dynamic> json) = _$KycImpl.fromJson;

  @override
  bool get verified;
  @override
  bool get submitted;
  @override
  String get address;
  @override
  String get vehicleNo;
  @override
  dynamic get aadhaarPic;
  @override
  dynamic get licensePic;

  /// Create a copy of Kyc
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KycImplCopyWith<_$KycImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Refer _$ReferFromJson(Map<String, dynamic> json) {
  return _Refer.fromJson(json);
}

/// @nodoc
mixin _$Refer {
  int get code => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  String get referBy => throw _privateConstructorUsedError;

  /// Serializes this Refer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Refer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReferCopyWith<Refer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferCopyWith<$Res> {
  factory $ReferCopyWith(Refer value, $Res Function(Refer) then) =
      _$ReferCopyWithImpl<$Res, Refer>;
  @useResult
  $Res call({int code, int count, String referBy});
}

/// @nodoc
class _$ReferCopyWithImpl<$Res, $Val extends Refer>
    implements $ReferCopyWith<$Res> {
  _$ReferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Refer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? count = null,
    Object? referBy = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      referBy: null == referBy
          ? _value.referBy
          : referBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReferImplCopyWith<$Res> implements $ReferCopyWith<$Res> {
  factory _$$ReferImplCopyWith(
          _$ReferImpl value, $Res Function(_$ReferImpl) then) =
      __$$ReferImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, int count, String referBy});
}

/// @nodoc
class __$$ReferImplCopyWithImpl<$Res>
    extends _$ReferCopyWithImpl<$Res, _$ReferImpl>
    implements _$$ReferImplCopyWith<$Res> {
  __$$ReferImplCopyWithImpl(
      _$ReferImpl _value, $Res Function(_$ReferImpl) _then)
      : super(_value, _then);

  /// Create a copy of Refer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? count = null,
    Object? referBy = null,
  }) {
    return _then(_$ReferImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      referBy: null == referBy
          ? _value.referBy
          : referBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReferImpl implements _Refer {
  const _$ReferImpl({this.code = 10000, this.count = 0, this.referBy = ''});

  factory _$ReferImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReferImplFromJson(json);

  @override
  @JsonKey()
  final int code;
  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey()
  final String referBy;

  @override
  String toString() {
    return 'Refer(code: $code, count: $count, referBy: $referBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReferImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.referBy, referBy) || other.referBy == referBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, count, referBy);

  /// Create a copy of Refer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReferImplCopyWith<_$ReferImpl> get copyWith =>
      __$$ReferImplCopyWithImpl<_$ReferImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReferImplToJson(
      this,
    );
  }
}

abstract class _Refer implements Refer {
  const factory _Refer(
      {final int code, final int count, final String referBy}) = _$ReferImpl;

  factory _Refer.fromJson(Map<String, dynamic> json) = _$ReferImpl.fromJson;

  @override
  int get code;
  @override
  int get count;
  @override
  String get referBy;

  /// Create a copy of Refer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReferImplCopyWith<_$ReferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Membership _$MembershipFromJson(Map<String, dynamic> json) {
  return _Membership.fromJson(json);
}

/// @nodoc
mixin _$Membership {
  bool get active =>
      throw _privateConstructorUsedError; // Default value for 'active'
  @TimestampToDateTimeConverter()
  DateTime? get endDate => throw _privateConstructorUsedError;
  String get plan =>
      throw _privateConstructorUsedError; // Default value for 'plan'
  @TimestampToDateTimeConverter()
  DateTime? get startDate => throw _privateConstructorUsedError;
  bool get trial => throw _privateConstructorUsedError;

  /// Serializes this Membership to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Membership
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MembershipCopyWith<Membership> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MembershipCopyWith<$Res> {
  factory $MembershipCopyWith(
          Membership value, $Res Function(Membership) then) =
      _$MembershipCopyWithImpl<$Res, Membership>;
  @useResult
  $Res call(
      {bool active,
      @TimestampToDateTimeConverter() DateTime? endDate,
      String plan,
      @TimestampToDateTimeConverter() DateTime? startDate,
      bool trial});
}

/// @nodoc
class _$MembershipCopyWithImpl<$Res, $Val extends Membership>
    implements $MembershipCopyWith<$Res> {
  _$MembershipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Membership
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? active = null,
    Object? endDate = freezed,
    Object? plan = null,
    Object? startDate = freezed,
    Object? trial = null,
  }) {
    return _then(_value.copyWith(
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trial: null == trial
          ? _value.trial
          : trial // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MembershipImplCopyWith<$Res>
    implements $MembershipCopyWith<$Res> {
  factory _$$MembershipImplCopyWith(
          _$MembershipImpl value, $Res Function(_$MembershipImpl) then) =
      __$$MembershipImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool active,
      @TimestampToDateTimeConverter() DateTime? endDate,
      String plan,
      @TimestampToDateTimeConverter() DateTime? startDate,
      bool trial});
}

/// @nodoc
class __$$MembershipImplCopyWithImpl<$Res>
    extends _$MembershipCopyWithImpl<$Res, _$MembershipImpl>
    implements _$$MembershipImplCopyWith<$Res> {
  __$$MembershipImplCopyWithImpl(
      _$MembershipImpl _value, $Res Function(_$MembershipImpl) _then)
      : super(_value, _then);

  /// Create a copy of Membership
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? active = null,
    Object? endDate = freezed,
    Object? plan = null,
    Object? startDate = freezed,
    Object? trial = null,
  }) {
    return _then(_$MembershipImpl(
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trial: null == trial
          ? _value.trial
          : trial // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MembershipImpl implements _Membership {
  const _$MembershipImpl(
      {this.active = false,
      @TimestampToDateTimeConverter() this.endDate,
      this.plan = 'daily',
      @TimestampToDateTimeConverter() this.startDate,
      this.trial = false});

  factory _$MembershipImpl.fromJson(Map<String, dynamic> json) =>
      _$$MembershipImplFromJson(json);

  @override
  @JsonKey()
  final bool active;
// Default value for 'active'
  @override
  @TimestampToDateTimeConverter()
  final DateTime? endDate;
  @override
  @JsonKey()
  final String plan;
// Default value for 'plan'
  @override
  @TimestampToDateTimeConverter()
  final DateTime? startDate;
  @override
  @JsonKey()
  final bool trial;

  @override
  String toString() {
    return 'Membership(active: $active, endDate: $endDate, plan: $plan, startDate: $startDate, trial: $trial)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MembershipImpl &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.plan, plan) || other.plan == plan) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.trial, trial) || other.trial == trial));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, active, endDate, plan, startDate, trial);

  /// Create a copy of Membership
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MembershipImplCopyWith<_$MembershipImpl> get copyWith =>
      __$$MembershipImplCopyWithImpl<_$MembershipImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MembershipImplToJson(
      this,
    );
  }
}

abstract class _Membership implements Membership {
  const factory _Membership(
      {final bool active,
      @TimestampToDateTimeConverter() final DateTime? endDate,
      final String plan,
      @TimestampToDateTimeConverter() final DateTime? startDate,
      final bool trial}) = _$MembershipImpl;

  factory _Membership.fromJson(Map<String, dynamic> json) =
      _$MembershipImpl.fromJson;

  @override
  bool get active; // Default value for 'active'
  @override
  @TimestampToDateTimeConverter()
  DateTime? get endDate;
  @override
  String get plan; // Default value for 'plan'
  @override
  @TimestampToDateTimeConverter()
  DateTime? get startDate;
  @override
  bool get trial;

  /// Create a copy of Membership
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MembershipImplCopyWith<_$MembershipImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Wallet _$WalletFromJson(Map<String, dynamic> json) {
  return _Wallet.fromJson(json);
}

/// @nodoc
mixin _$Wallet {
  num get amount => throw _privateConstructorUsedError;

  /// Serializes this Wallet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletCopyWith<Wallet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletCopyWith<$Res> {
  factory $WalletCopyWith(Wallet value, $Res Function(Wallet) then) =
      _$WalletCopyWithImpl<$Res, Wallet>;
  @useResult
  $Res call({num amount});
}

/// @nodoc
class _$WalletCopyWithImpl<$Res, $Val extends Wallet>
    implements $WalletCopyWith<$Res> {
  _$WalletCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletImplCopyWith<$Res> implements $WalletCopyWith<$Res> {
  factory _$$WalletImplCopyWith(
          _$WalletImpl value, $Res Function(_$WalletImpl) then) =
      __$$WalletImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({num amount});
}

/// @nodoc
class __$$WalletImplCopyWithImpl<$Res>
    extends _$WalletCopyWithImpl<$Res, _$WalletImpl>
    implements _$$WalletImplCopyWith<$Res> {
  __$$WalletImplCopyWithImpl(
      _$WalletImpl _value, $Res Function(_$WalletImpl) _then)
      : super(_value, _then);

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
  }) {
    return _then(_$WalletImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletImpl implements _Wallet {
  const _$WalletImpl({this.amount = 0.0});

  factory _$WalletImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletImplFromJson(json);

  @override
  @JsonKey()
  final num amount;

  @override
  String toString() {
    return 'Wallet(amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletImpl &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount);

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletImplCopyWith<_$WalletImpl> get copyWith =>
      __$$WalletImplCopyWithImpl<_$WalletImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletImplToJson(
      this,
    );
  }
}

abstract class _Wallet implements Wallet {
  const factory _Wallet({final num amount}) = _$WalletImpl;

  factory _Wallet.fromJson(Map<String, dynamic> json) = _$WalletImpl.fromJson;

  @override
  num get amount;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletImplCopyWith<_$WalletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
