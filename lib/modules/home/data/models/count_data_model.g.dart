// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CountDataModelImpl _$$CountDataModelImplFromJson(Map<String, dynamic> json) =>
    _$CountDataModelImpl(
      leadsAvailable: (json['leadsAvailable'] as num?)?.toInt() ?? 0,
      leadsDuties: (json['leadsDuties'] as num?)?.toInt() ?? 0,
      leadsExchange: (json['leadsExchange'] as num?)?.toInt() ?? 0,
      totalActiveUsers: (json['totalActiveUsers'] as num?)?.toInt() ?? 0,
      totalAiLeads: (json['totalAiLeads'] as num?)?.toInt() ?? 0,
      totalAppLeads: (json['totalAppLeads'] as num?)?.toInt() ?? 0,
      totalCalls: (json['totalCalls'] as num?)?.toInt() ?? 0,
      totalDrivers: (json['totalDrivers'] as num?)?.toInt() ?? 0,
      totalFraudReports: (json['totalFraudReports'] as num?)?.toInt() ?? 0,
      totalFraudUsers: (json['totalFraudUsers'] as num?)?.toInt() ?? 0,
      totalKycSubmitted: (json['totalKycSubmitted'] as num?)?.toInt() ?? 0,
      totalLeads: (json['totalLeads'] as num?)?.toInt() ?? 0,
      totalNotification: (json['totalNotification'] as num?)?.toInt() ?? 0,
      totalOnboardedUsers: (json['totalOnboardedUsers'] as num?)?.toInt() ?? 0,
      totalSearches: (json['totalSearches'] as num?)?.toInt() ?? 0,
      totalVerifiedDrivers:
          (json['totalVerifiedDrivers'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CountDataModelImplToJson(
        _$CountDataModelImpl instance) =>
    <String, dynamic>{
      'leadsAvailable': instance.leadsAvailable,
      'leadsDuties': instance.leadsDuties,
      'leadsExchange': instance.leadsExchange,
      'totalActiveUsers': instance.totalActiveUsers,
      'totalAiLeads': instance.totalAiLeads,
      'totalAppLeads': instance.totalAppLeads,
      'totalCalls': instance.totalCalls,
      'totalDrivers': instance.totalDrivers,
      'totalFraudReports': instance.totalFraudReports,
      'totalFraudUsers': instance.totalFraudUsers,
      'totalKycSubmitted': instance.totalKycSubmitted,
      'totalLeads': instance.totalLeads,
      'totalNotification': instance.totalNotification,
      'totalOnboardedUsers': instance.totalOnboardedUsers,
      'totalSearches': instance.totalSearches,
      'totalVerifiedDrivers': instance.totalVerifiedDrivers,
    };
