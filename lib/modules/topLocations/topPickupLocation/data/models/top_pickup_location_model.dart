class TopPickupModel {
  final int count;
  final String name;

  TopPickupModel({
    required this.count,
    required this.name,
  });

  // Method to convert a Trip object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'name': name,
    };
  }

  // Factory method to create a Trip object from a JSON map
  factory TopPickupModel.fromJson(Map<String, dynamic> json) {
    return TopPickupModel(
      count: json['count'],
      name: json['name'] ?? "",
    );
  }

  // Optionally, you can override the toString method for easier debugging
  @override
  String toString() {
    return 'Trip(count: $count, name: $name,)';
  }
}
