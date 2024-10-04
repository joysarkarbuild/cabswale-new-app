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
      active: json['active'],
      address: Address.fromJson(json['address']),
      addressCoordinates: List<double>.from(json['address.coordinates']),
      cashback: json['cashback'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          json['createdAt']['_seconds'] * 1000 +
              json['createdAt']['_nanoseconds'] ~/ 1000000),
      id: json['id'],
      location: json['location'],
      maxScans: json['maxScans'],
      partnerDetails: PartnerDetails.fromJson(json['partnerDetails']),
      partnerId: json['partnerId'],
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
      address: json['address'],
      coordinates: List<String>.from(json['coordinates']),
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
      active: json['active'],
      coverPic: json['coverPic'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          json['createdAt']['_seconds'] * 1000 +
              json['createdAt']['_nanoseconds'] ~/ 1000000),
      desc: json['desc'],
      media: List<Media>.from(json['media'].map((x) => Media.fromJson(x))),
      title: json['title'],
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
      'desc': desc,
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
      type: json['type'],
      url: json['url'],
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

List<Partner> dummyPartner = [
  Partner(
    active: true,
    address: Address(
      address: '303 Birch Boulevard, Gotham',
      coordinates: ['51.507000', '-0.130000'],
    ),
    addressCoordinates: [51.50699996948242, -0.12999999523162842],
    cashback: 10,
    createdAt: DateTime.now(),
    id: '1',
    location: 'Gotham',
    maxScans: 5,
    partnerDetails: PartnerDetails(
      active: true,
      coverPic:
          'https://t4.ftcdn.net/jpg/04/95/28/65/360_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg',
      createdAt: DateTime.now(),
      desc: 'Partner 1 Description',
      media: [
        Media(type: 'image', url: 'https://example.com/images/media1.jpg'),
        Media(type: 'video', url: 'https://example.com/videos/media1.mp4'),
      ],
      title: 'Partner 1',
    ),
    partnerId: 'partner1',
  ),
  Partner(
    active: false,
    address: Address(
      address: '404 Elm Street, Metropolis',
      coordinates: ['40.712776', '-74.005974'],
    ),
    addressCoordinates: [40.712776, -74.005974],
    cashback: 15,
    createdAt: DateTime.now(),
    id: '2',
    location: 'Metropolis',
    maxScans: 3,
    partnerDetails: PartnerDetails(
      active: false,
      coverPic:
          'https://t4.ftcdn.net/jpg/04/95/28/65/360_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg',
      createdAt: DateTime.now(),
      desc: 'Partner 2 Description',
      media: [
        Media(type: 'image', url: 'https://example.com/images/media2.jpg'),
      ],
      title: 'Partner 2',
    ),
    partnerId: 'partner2',
  ),
  Partner(
    active: true,
    address: Address(
      address: '505 Oak Avenue, Star City',
      coordinates: ['34.052235', '-118.243683'],
    ),
    addressCoordinates: [34.052235, -118.243683],
    cashback: 20,
    createdAt: DateTime.now(),
    id: '3',
    location: 'Star City',
    maxScans: 8,
    partnerDetails: PartnerDetails(
      active: true,
      coverPic:
          'https://t4.ftcdn.net/jpg/04/95/28/65/360_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg',
      createdAt: DateTime.now(),
      desc: 'Partner 3 Description',
      media: [
        Media(type: 'audio', url: 'https://example.com/audio/media3.mp3'),
      ],
      title: 'Partner 3',
    ),
    partnerId: 'partner3',
  ),
];
