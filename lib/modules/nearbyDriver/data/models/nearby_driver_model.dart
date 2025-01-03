import 'package:cabswalle/services/location_service.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as math;

class NearbyDriverModel {
  final String name;
  final String phoneNo;
  final String id;
  final int? connections;
  final String? displayPic;
  final String city;
  final int experience;
  final bool fraud;
  final bool verified;
  final List<dynamic>? currentLocation;
  final double? distance;
  final String? locationUpdatedAt;

  const NearbyDriverModel({
    required this.name,
    required this.phoneNo,
    required this.id,
    this.displayPic,
    required this.city,
    this.fraud = false,
    this.verified = false,
    this.connections,
    this.currentLocation,
    this.experience = 0,
    this.locationUpdatedAt,
    this.distance,
  });

  factory NearbyDriverModel.fromJson(Map<String, dynamic> json) {
    return NearbyDriverModel(
      name: json['name'] ?? 'Not Available',
      phoneNo: json['phoneNo'] ?? "",
      id: json['id'] ?? "",
      displayPic: json['profile_image'] ?? "",
      city: json['city'] ?? "",
      experience: json['experience'] ?? 0,
      connections: json['connections'] ?? 0,
      fraud: json["fraud"] ?? false,
      verified: json["verified"] ?? false,
      locationUpdatedAt: json["locationUpdatedAt"] != null
          ? timeAgo(json["locationUpdatedAt"])
          : "Location not available",
      currentLocation: json["currentLocation"],
      distance: json["locationUpdatedAt"] != null
          ? calculateDistanceInMeters(
              json["currentLocation"][0], json["currentLocation"][1])
          : null,
    );
  }
}

class Vehicle {
  final String brand;
  final String? modelYear;
  final List<String> images;

  const Vehicle({
    required this.brand,
    required this.images,
    this.modelYear,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      brand: json['brand'],
      modelYear: json['modelYear'],
      images: List<String>.from(json['images']),
    );
  }

  @override
  String toString() {
    return 'Vehicle(brand: $brand, modelYear: $modelYear, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vehicle &&
        other.brand == brand &&
        other.modelYear == modelYear &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return brand.hashCode ^ modelYear.hashCode ^ images.hashCode;
  }
}

class Route {
  final String from;
  final String to;

  const Route({
    required this.from,
    required this.to,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      from: json['from'],
      to: json['to'],
    );
  }
}

double calculateDistanceInMeters(double lat2, double lon2) {
  const double earthRadiusKm = 6371.0;
  double lat1 = LocationService().currentPosition!.latitude;
  double lon1 = LocationService().currentPosition!.longitude;
  double lat1Rad = lat1 * (math.pi / 180.0);
  double lon1Rad = lon1 * (math.pi / 180.0);
  double lat2Rad = lat2 * (math.pi / 180.0);
  double lon2Rad = lon2 * (math.pi / 180.0);

  double dlat = lat2Rad - lat1Rad;
  double dlon = lon2Rad - lon1Rad;

  double a = math.sin(dlat / 2) * math.sin(dlat / 2) +
      math.cos(lat1Rad) *
          math.cos(lat2Rad) *
          math.sin(dlon / 2) *
          math.sin(dlon / 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  double distanceKm = earthRadiusKm * c;
  double distanceMeters = distanceKm * 1000;

  return distanceMeters;
}

String timeAgo(int unixTimestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp);
  DateTime adjustedDateTime = dateTime.subtract(const Duration(hours: 1));
  DateTime now = DateTime.now();
  Duration difference = now.difference(adjustedDateTime);
  int hoursAgo = difference.inMinutes;
  if (hoursAgo < 4) {
    return "Location updated just now";
  }
  return "Location updated $hoursAgo mins ago";
}
