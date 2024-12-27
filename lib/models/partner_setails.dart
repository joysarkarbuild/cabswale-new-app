class Partner {
  final bool active;
  final Address address;
  final List<double> addressCoordinates;
  final int cashback;
  final DateTime createdAt;
  final String id;
  final String location;
  final int maxScans;
  final PartnerDetails partnerDetails;
  final String partnerId;

  Partner({
    required this.active,
    required this.address,
    required this.addressCoordinates,
    required this.cashback,
    required this.createdAt,
    required this.id,
    required this.location,
    required this.maxScans,
    required this.partnerDetails,
    required this.partnerId,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      active: json['active'] ?? false,
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : Address(address: '', coordinates: []),
      addressCoordinates: json['address.coordinates'] != null
          ? List<double>.from(json['address.coordinates'] ?? [])
          : [],
      cashback: json['cashback'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (json['createdAt']['_seconds'] ?? 0) * 1000 +
                  (json['createdAt']['_nanoseconds'] ?? 0) ~/ 1000000)
          : DateTime.fromMillisecondsSinceEpoch(0),
      id: json['id'] ?? '',
      location: json['location'] ?? '',
      maxScans: json['maxScans'] ?? 0,
      partnerDetails: json['partnerDetails'] != null
          ? PartnerDetails.fromJson(json['partnerDetails'])
          : PartnerDetails(
              active: false,
              coverPic: '',
              createdAt: DateTime.fromMillisecondsSinceEpoch(0),
              desc: '',
              media: [],
              title: ''),
      partnerId: json['partnerId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'address': address.toJson(),
      'address.coordinates': addressCoordinates,
      'cashback': cashback,
      'createdAt': {
        '_seconds': createdAt.millisecondsSinceEpoch ~/ 1000,
        '_nanoseconds': (createdAt.millisecondsSinceEpoch % 1000) * 1000000,
      },
      'id': id,
      'location': location,
      'maxScans': maxScans,
      'partnerDetails': partnerDetails.toJson(),
      'partnerId': partnerId,
    };
  }
}

class Address {
  final String address;
  final List<String> coordinates;

  Address({
    required this.address,
    required this.coordinates,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'] ?? '',
      coordinates: json['coordinates'] != null
          ? List<String>.from(json['coordinates'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'coordinates': coordinates,
    };
  }
}

class PartnerDetails {
  final bool active;
  final String coverPic;
  final DateTime createdAt;
  final String desc;
  final List<Media> media;
  final String title;

  PartnerDetails({
    required this.active,
    required this.coverPic,
    required this.createdAt,
    required this.desc,
    required this.media,
    required this.title,
  });

  factory PartnerDetails.fromJson(Map<String, dynamic> json) {
    return PartnerDetails(
      active: json['active'] ?? false,
      coverPic: json['coverPic'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (json['createdAt']['_seconds'] ?? 0) * 1000 +
                  (json['createdAt']['_nanoseconds'] ?? 0) ~/ 1000000)
          : DateTime.fromMillisecondsSinceEpoch(0),
      desc: json['description'] ?? '',
      media: json['media'] != null
          ? List<Media>.from(json['media'].map((x) => Media.fromJson(x)))
          : [],
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'coverPic': coverPic,
      'createdAt': {
        '_seconds': createdAt.millisecondsSinceEpoch ~/ 1000,
        '_nanoseconds': (createdAt.millisecondsSinceEpoch % 1000) * 1000000,
      },
      'description': desc,
      'media': media.map((x) => x.toJson()).toList(),
      'title': title,
    };
  }
}

class Media {
  final String type;
  final String url;
  final String? videoId;

  Media({
    required this.type,
    required this.url,
    this.videoId,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      type: json['type'] ?? '',
      url: json['url'] ?? '',
      videoId: json['videoId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'url': url,
      'videoId': videoId,
    };
  }
}
