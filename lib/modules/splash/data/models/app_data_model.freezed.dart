// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppDataModel _$AppDataModelFromJson(Map<String, dynamic> json) {
  return _AppDataModel.fromJson(json);
}

/// @nodoc
mixin _$AppDataModel {
  String get appStoreUrl => throw _privateConstructorUsedError;
  String get playStoreUrl => throw _privateConstructorUsedError;
  String get policy => throw _privateConstructorUsedError;
  int get appVersion => throw _privateConstructorUsedError;
  bool get useOtpless => throw _privateConstructorUsedError;
  int get iosVersion => throw _privateConstructorUsedError;
  bool get forceUpdate => throw _privateConstructorUsedError;

  /// Serializes this AppDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppDataModelCopyWith<AppDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppDataModelCopyWith<$Res> {
  factory $AppDataModelCopyWith(
          AppDataModel value, $Res Function(AppDataModel) then) =
      _$AppDataModelCopyWithImpl<$Res, AppDataModel>;
  @useResult
  $Res call(
      {String appStoreUrl,
      String playStoreUrl,
      String policy,
      int appVersion,
      bool useOtpless,
      int iosVersion,
      bool forceUpdate});
}

/// @nodoc
class _$AppDataModelCopyWithImpl<$Res, $Val extends AppDataModel>
    implements $AppDataModelCopyWith<$Res> {
  _$AppDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appStoreUrl = null,
    Object? playStoreUrl = null,
    Object? policy = null,
    Object? appVersion = null,
    Object? useOtpless = null,
    Object? iosVersion = null,
    Object? forceUpdate = null,
  }) {
    return _then(_value.copyWith(
      appStoreUrl: null == appStoreUrl
          ? _value.appStoreUrl
          : appStoreUrl // ignore: cast_nullable_to_non_nullable
              as String,
      playStoreUrl: null == playStoreUrl
          ? _value.playStoreUrl
          : playStoreUrl // ignore: cast_nullable_to_non_nullable
              as String,
      policy: null == policy
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as int,
      useOtpless: null == useOtpless
          ? _value.useOtpless
          : useOtpless // ignore: cast_nullable_to_non_nullable
              as bool,
      iosVersion: null == iosVersion
          ? _value.iosVersion
          : iosVersion // ignore: cast_nullable_to_non_nullable
              as int,
      forceUpdate: null == forceUpdate
          ? _value.forceUpdate
          : forceUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppDataModelImplCopyWith<$Res>
    implements $AppDataModelCopyWith<$Res> {
  factory _$$AppDataModelImplCopyWith(
          _$AppDataModelImpl value, $Res Function(_$AppDataModelImpl) then) =
      __$$AppDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String appStoreUrl,
      String playStoreUrl,
      String policy,
      int appVersion,
      bool useOtpless,
      int iosVersion,
      bool forceUpdate});
}

/// @nodoc
class __$$AppDataModelImplCopyWithImpl<$Res>
    extends _$AppDataModelCopyWithImpl<$Res, _$AppDataModelImpl>
    implements _$$AppDataModelImplCopyWith<$Res> {
  __$$AppDataModelImplCopyWithImpl(
      _$AppDataModelImpl _value, $Res Function(_$AppDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appStoreUrl = null,
    Object? playStoreUrl = null,
    Object? policy = null,
    Object? appVersion = null,
    Object? useOtpless = null,
    Object? iosVersion = null,
    Object? forceUpdate = null,
  }) {
    return _then(_$AppDataModelImpl(
      appStoreUrl: null == appStoreUrl
          ? _value.appStoreUrl
          : appStoreUrl // ignore: cast_nullable_to_non_nullable
              as String,
      playStoreUrl: null == playStoreUrl
          ? _value.playStoreUrl
          : playStoreUrl // ignore: cast_nullable_to_non_nullable
              as String,
      policy: null == policy
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as int,
      useOtpless: null == useOtpless
          ? _value.useOtpless
          : useOtpless // ignore: cast_nullable_to_non_nullable
              as bool,
      iosVersion: null == iosVersion
          ? _value.iosVersion
          : iosVersion // ignore: cast_nullable_to_non_nullable
              as int,
      forceUpdate: null == forceUpdate
          ? _value.forceUpdate
          : forceUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppDataModelImpl implements _AppDataModel {
  const _$AppDataModelImpl(
      {this.appStoreUrl = '',
      required this.playStoreUrl,
      required this.policy,
      this.appVersion = 0,
      this.useOtpless = false,
      this.iosVersion = 0,
      this.forceUpdate = false});

  factory _$AppDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppDataModelImplFromJson(json);

  @override
  @JsonKey()
  final String appStoreUrl;
  @override
  final String playStoreUrl;
  @override
  final String policy;
  @override
  @JsonKey()
  final int appVersion;
  @override
  @JsonKey()
  final bool useOtpless;
  @override
  @JsonKey()
  final int iosVersion;
  @override
  @JsonKey()
  final bool forceUpdate;

  @override
  String toString() {
    return 'AppDataModel(appStoreUrl: $appStoreUrl, playStoreUrl: $playStoreUrl, policy: $policy, appVersion: $appVersion, useOtpless: $useOtpless, iosVersion: $iosVersion, forceUpdate: $forceUpdate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppDataModelImpl &&
            (identical(other.appStoreUrl, appStoreUrl) ||
                other.appStoreUrl == appStoreUrl) &&
            (identical(other.playStoreUrl, playStoreUrl) ||
                other.playStoreUrl == playStoreUrl) &&
            (identical(other.policy, policy) || other.policy == policy) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.useOtpless, useOtpless) ||
                other.useOtpless == useOtpless) &&
            (identical(other.iosVersion, iosVersion) ||
                other.iosVersion == iosVersion) &&
            (identical(other.forceUpdate, forceUpdate) ||
                other.forceUpdate == forceUpdate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, appStoreUrl, playStoreUrl,
      policy, appVersion, useOtpless, iosVersion, forceUpdate);

  /// Create a copy of AppDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppDataModelImplCopyWith<_$AppDataModelImpl> get copyWith =>
      __$$AppDataModelImplCopyWithImpl<_$AppDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppDataModelImplToJson(
      this,
    );
  }
}

abstract class _AppDataModel implements AppDataModel {
  const factory _AppDataModel(
      {final String appStoreUrl,
      required final String playStoreUrl,
      required final String policy,
      final int appVersion,
      final bool useOtpless,
      final int iosVersion,
      final bool forceUpdate}) = _$AppDataModelImpl;

  factory _AppDataModel.fromJson(Map<String, dynamic> json) =
      _$AppDataModelImpl.fromJson;

  @override
  String get appStoreUrl;
  @override
  String get playStoreUrl;
  @override
  String get policy;
  @override
  int get appVersion;
  @override
  bool get useOtpless;
  @override
  int get iosVersion;
  @override
  bool get forceUpdate;

  /// Create a copy of AppDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppDataModelImplCopyWith<_$AppDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
