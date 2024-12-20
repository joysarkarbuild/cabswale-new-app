class JobModel {
  final bool active;
  final DateTime createdAt;
  final String details;
  final String location;
  final String phoneNo;
  final String uid;
  final String id;
  final bool isVerified;

  JobModel({
    required this.active,
    required this.createdAt,
    required this.details,
    required this.location,
    required this.phoneNo,
    required this.uid,
    required this.id,
    required this.isVerified,
  });

  // Factory constructor for creating a new instance from a map (e.g., JSON).
  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json["id"] as String? ?? "",
      active: json['active'] as bool? ?? false, // Default to false if null
      createdAt: json['createdAt'].runtimeType == int
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'])
          : json['createdAt'].toDate(), // Convert timestamp to DateTime
      details: json['details'] as String? ?? '', // Default to empty string
      location: json['location'] as String? ?? '', // Default to empty string
      phoneNo: json['phoneNo'] as String? ?? '', // Default to empty string
      uid: json["uid"] ?? "",
      isVerified: json["isVerified"] ?? false,
    );
  }

  // CopyWith method to create a new instance with optional changes
  JobModel copyWith({
    bool? active,
    DateTime? createdAt,
    String? details,
    String? location,
    String? phoneNo,
    String? uid,
    String? id,
    bool? isVerified,
  }) {
    return JobModel(
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      details: details ?? this.details,
      location: location ?? this.location,
      phoneNo: phoneNo ?? this.phoneNo,
      uid: uid ?? this.uid,
      id: id ?? this.id,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  // Method to convert this object into a map (e.g., for JSON).
  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'createdAt': createdAt,
      'details': details,
      'location': location,
      'phoneNo': phoneNo,
      "uid": uid,
      "id": id,
      'isVerified': isVerified,
    };
  }

  @override
  String toString() {
    return 'DataModel(active: $active, createdAt: $createdAt, details: $details, location: $location, phoneNo: $phoneNo , uid: $uid)';
  }
}
