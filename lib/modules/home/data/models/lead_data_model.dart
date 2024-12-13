import 'package:freezed_annotation/freezed_annotation.dart';

part 'lead_data_model.freezed.dart';
part 'lead_data_model.g.dart';

@freezed
class LeadModel with _$LeadModel {
  const factory LeadModel({
    String? id,
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
    @Default(100000) int otp,
  }) = _LeadModel;

  factory LeadModel.fromJson(Map<String, dynamic> json) =>
      _$LeadModelFromJson(json);
}

// Custom converter for Firebase Timestamp
class TimestampToDateTimeConverter
    implements JsonConverter<DateTime?, dynamic> {
  const TimestampToDateTimeConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) {
      return DateTime.now();
    } else if (json.runtimeType == int) {
      return DateTime.fromMillisecondsSinceEpoch(json);
    } else {
      return json.toDate(); // Assumes json is a Firebase Timestamp
    }
  }

  @override
  dynamic toJson(DateTime? date) => date;
}

@freezed
class CreatedBy with _$CreatedBy {
  const factory CreatedBy({
    String? id,
    String? name,
    String? phoneNo,
    bool? verified,
    String? city,
    int? connections,
    bool? fraud,
    String? profileImage,
  }) = _CreatedBy;

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      _$CreatedByFromJson(json);
}

@freezed
class From with _$From {
  const factory From({
    String? city,
  }) = _From;

  factory From.fromJson(Map<String, dynamic> json) => _$FromFromJson(json);
}
