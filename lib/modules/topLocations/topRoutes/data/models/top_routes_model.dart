class TopRouteModel {
  final int count;
  final String from;
  final String to;

  TopRouteModel({
    required this.count,
    required this.from,
    required this.to,
  });

  // Method to convert a Trip object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'form': from,
      'to': to,
    };
  }

  // Factory method to create a Trip object from a JSON map
  factory TopRouteModel.fromJson(Map<String, dynamic> json) {
    return TopRouteModel(
      count: json['count'],
      from: json['form'] ?? "",
      to: json['to'] ?? "",
    );
  }

  // Optionally, you can override the toString method for easier debugging
  @override
  String toString() {
    return 'Trip(count: $count, from: $from, to: $to)';
  }
}
