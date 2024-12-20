class CarModel {
  final bool active;
  final DateTime createdAt;
  final String details;
  final String id;
  final List<String> images;
  final String location;
  final String model;
  final int price;
  final String uid;
  final String year;
  final bool isVerified;
  final String phoneNo;

  CarModel({
    required this.active,
    required this.createdAt,
    required this.details,
    required this.id,
    required this.images,
    required this.location,
    required this.model,
    required this.price,
    required this.uid,
    required this.year,
    required this.isVerified,
    required this.phoneNo,
  });

  // Factory method to create an instance from a map (e.g., Firestore document)
  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
        active: map['active'] ?? false,
        createdAt: map['createdAt'].runtimeType == int
            ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
            : map['createdAt'].toDate(),
        details: map['details'],
        id: map['id'],
        images: List<String>.from(map['images']),
        location: map['location'],
        model: map['model'],
        price: map['price'],
        uid: map['uid'],
        year: map['year'],
        phoneNo: map["phoneNo"] ?? "",
        isVerified: map["isVerified"] ?? false);
  }

  // Method to convert the instance back into a map (e.g., for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'active': active,
      'createdAt': createdAt,
      'details': details,
      'id': id,
      'images': images,
      'location': location,
      'model': model,
      'price': price,
      'uid': uid,
      'year': year,
      'isVerified': isVerified,
      'phoneNo': phoneNo,
    };
  }

  // CopyWith method for creating a modified copy of the instance
  CarModel copyWith({
    bool? active,
    DateTime? createdAt,
    String? details,
    String? id,
    List<String>? images,
    String? location,
    String? model,
    int? price,
    String? uid,
    String? year,
    bool? isVerified,
    String? phoneNo,
  }) {
    return CarModel(
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      details: details ?? this.details,
      id: id ?? this.id,
      images: images ?? this.images,
      location: location ?? this.location,
      model: model ?? this.model,
      price: price ?? this.price,
      uid: uid ?? this.uid,
      year: year ?? this.year,
      isVerified: isVerified ?? this.isVerified,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }
}
