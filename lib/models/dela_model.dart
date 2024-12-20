import 'package:cloud_firestore/cloud_firestore.dart';

class DealModel {
  final String id;
  final String name;
  final String phoneNo;
  final Timestamp createdAt;
  final Map<String, dynamic>? acceptedBy;
  final Map<String, dynamic>? createdBy;
  final String city;
  final int connections;
  final bool fraud;
  final String profileImage;
  final bool verified;
  final Map<String, dynamic> from;
  final Map<String, dynamic> to;
  final String leadId;
  String? dealDocument;

  DealModel({
    required this.id,
    required this.name,
    required this.phoneNo,
    required this.createdAt,
    this.acceptedBy,
    this.createdBy,
    required this.city,
    required this.connections,
    required this.fraud,
    required this.profileImage,
    required this.verified,
    required this.from,
    required this.to,
    required this.leadId,
    this.dealDocument,
  });

  // Factory method to create a DealModel from JSON with null handling
  factory DealModel.fromJson(Map<String, dynamic>? json) {
    return DealModel(
      id: json?['id'] as String? ?? '',
      name: json?['name'] as String? ?? '',
      phoneNo: json?['phoneNo'] as String? ?? '',
      createdAt: json?['createdAt'] as Timestamp? ?? Timestamp.now(),
      acceptedBy: json?['acceptedBy'] as Map<String, dynamic>?,
      createdBy: json?['createdBy'] as Map<String, dynamic>?,
      city: json?['city'] as String? ?? '',
      connections: json?['connections'] as int? ?? 0,
      fraud: json?['fraud'] as bool? ?? false,
      profileImage: json?['profile_image'] as String? ?? '',
      verified: json?['verified'] as bool? ?? false,
      from: json?['from'] as Map<String, dynamic>? ?? {},
      to: json?['to'] as Map<String, dynamic>? ?? {},
      leadId: json?['leadId'] as String? ?? '',
      dealDocument: json?["dealDocument"] ?? "",
    );
  }

  // Method to convert a DealModel instance to JSON with null handling
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNo': phoneNo,
      'createdAt': createdAt,
      'acceptedBy': acceptedBy ?? {},
      'createdBy': createdBy ?? {},
      'city': city,
      'connections': connections,
      'fraud': fraud,
      'profile_image': profileImage,
      'verified': verified,
      'from': from,
      'to': to,
      'leadId': leadId,
      "dealDocument": dealDocument,
    };
  }
}
