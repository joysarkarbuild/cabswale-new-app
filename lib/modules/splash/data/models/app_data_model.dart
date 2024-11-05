import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_data_model.freezed.dart';
part 'app_data_model.g.dart';

@freezed
class AppDataModel with _$AppDataModel {
  const factory AppDataModel({
    // ignore: invalid_annotation_target
    @JsonKey(name: '_id') required String id,
    @Default('') String appStoreUrl,
    required String playStoreUrl,
    required String policy,
    @Default(0) int appVersion,
    @Default(0) int iosVersion,
    @Default(false) bool forceUpdate,
  }) = _AppDataModel;

  // Factory constructor to create an instance from JSON
  factory AppDataModel.fromJson(Map<String, dynamic> json) =>
      _$AppDataModelFromJson(json);
}
