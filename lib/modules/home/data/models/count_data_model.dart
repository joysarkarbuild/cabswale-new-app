import 'package:freezed_annotation/freezed_annotation.dart';

part 'count_data_model.freezed.dart';
part 'count_data_model.g.dart';

@freezed
class CountDataModel with _$CountDataModel {
  const factory CountDataModel({
    @Default(0) int leadsAvailable,
    @Default(0) int leadsDuties,
    @Default(0) int leadsExchange,
    @Default(0) int totalActiveUsers,
    @Default(0) int totalAiLeads,
    @Default(0) int totalAppLeads,
    @Default(0) int totalCalls,
    @Default(0) int totalDrivers,
    @Default(0) int totalFraudReports,
    @Default(0) int totalFraudUsers,
    @Default(0) int totalKycSubmitted,
    @Default(0) int totalLeads,
    @Default(0) int totalNotification,
    @Default(0) int totalOnboardedUsers,
    @Default(0) int totalSearches,
    @Default(0) int totalVerifiedDrivers,
  }) = _CountDataModel;

  factory CountDataModel.fromJson(Map<String, dynamic> json) =>
      _$CountDataModelFromJson(json);
}
