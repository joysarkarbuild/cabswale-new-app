class AppDataModel {
  final String id;
  final String appStoreUrl;
  final String playStoreUrl;
  final String policy;
  final int appVersion;
  final int iosVersion;
  final bool forceUpdate;

  AppDataModel({
    required this.id,
    required this.appStoreUrl,
    required this.playStoreUrl,
    required this.policy,
    required this.appVersion,
    required this.iosVersion,
    required this.forceUpdate,
  });

  // Factory constructor to create an instance from JSON
  factory AppDataModel.fromJson(Map<String, dynamic> json) {
    return AppDataModel(
      id: json['_id'] ?? '',
      appStoreUrl: json['appStoreUrl'] ?? '',
      playStoreUrl: json['playStoreUrl'] ?? '',
      policy: json['policy'] ?? '',
      appVersion: json['appVersion'] ?? 0,
      iosVersion: json['iosVersion'] ?? 0,
      forceUpdate: json['forceUpdate'] ?? false,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'appStoreUrl': appStoreUrl,
      'playStoreUrl': playStoreUrl,
      'policy': policy,
      'appVersion': appVersion,
      'iosVersion': iosVersion,
      'forceUpdate': forceUpdate,
    };
  }
}
