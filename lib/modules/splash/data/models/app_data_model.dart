import 'package:cloud_firestore/cloud_firestore.dart';

class AppDataModel {
  final String appStoreUrl;
  final int appVersion;
  final DateTime createdAt;
  final bool forceUpdate;
  final String playStoreUrl;
  final String policy;

  AppDataModel({
    required this.appStoreUrl,
    required this.appVersion,
    required this.createdAt,
    required this.forceUpdate,
    required this.playStoreUrl,
    required this.policy,
  });

  factory AppDataModel.fromJson(Map<String, dynamic> data) {
    return AppDataModel(
      appStoreUrl: data['appStoreUrl'] as String? ?? '',
      appVersion: data['appVersion'] as int? ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      forceUpdate: data['forceUpdate'] as bool? ?? false,
      playStoreUrl: data['playStoreUrl'] as String? ?? '',
      policy: data['policy'] as String? ?? '',
    );
  }
}
