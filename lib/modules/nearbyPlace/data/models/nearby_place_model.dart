class NearbyPlace {
  String address;
  List<double> location;
  String name;
  String phone;
  int geoDistanceMeters;

  NearbyPlace({
    required this.address,
    required this.location,
    required this.name,
    required this.phone,
    required this.geoDistanceMeters,
  });

  factory NearbyPlace.fromJson(Map<String, dynamic> json) {
    return NearbyPlace(
      address: json['document']['address'] ?? '',
      location: json['document']['location'] != null
          ? List<double>.from(json['document']['location'])
          : [],
      name: json['document']['name'] ?? '',
      phone: json['document']['phone'] ?? '',
      geoDistanceMeters: json['geo_distance_meters'] != null
          ? json['geo_distance_meters']['location'] ?? 0
          : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'document': {
        'address': address,
        'location': location,
        'name': name,
        'phone': phone,
      },
    };
  }
}

List<NearbyPlace> dummyNearbyPlaces = [
  NearbyPlace(
    address: "123 Main St, Springfield",
    location: [37.7749, -122.4194],
    name: "The Coffee House",
    phone: "+1234567890",
    geoDistanceMeters: 500,
  ),
  NearbyPlace(
    address: "456 Elm St, Gotham",
    location: [40.7128, -74.0060],
    name: "Burgers and More",
    phone: "+0987654321",
    geoDistanceMeters: 1500,
  ),
  NearbyPlace(
    address: "789 Oak St, Metropolis",
    location: [34.0522, -118.2437],
    name: "Pizza World",
    phone: "+1122334455",
    geoDistanceMeters: 300,
  ),
  NearbyPlace(
    address: "101 Maple Ave, Star City",
    location: [51.5074, -0.1278],
    name: "Taco Fiesta",
    phone: "+2233445566",
    geoDistanceMeters: 1200,
  ),
  NearbyPlace(
    address: "202 Pine St, Central City",
    location: [48.8566, 2.3522],
    name: "Sushi Delight",
    phone: "+3344556677",
    geoDistanceMeters: 800,
  ),
];
