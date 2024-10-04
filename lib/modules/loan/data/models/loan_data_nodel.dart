class LoanModel {
  bool active;
  String id;
  String coverPic;
  String desc;
  List<Media> media;
  int order;
  String title;

  LoanModel(
      {required this.active,
      required this.coverPic,
      required this.desc,
      required this.media,
      required this.order,
      required this.title,
      required this.id});

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json["id"],
      active: json['active'] as bool? ?? false,
      coverPic: json['coverPic'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      media: (json['media'] as List<dynamic>?)
              ?.map((item) => Media.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      order: (json['order'] as String?) != null
          ? int.tryParse(json['order']) ?? 0
          : 0,
      title: json['title'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'coverPic': coverPic,
      'desc': desc,
      'media': media.map((item) => item.toJson()).toList(),
      'order': order.toString(),
      'title': title,
      "id": id,
    };
  }
}

class Media {
  String type;
  String url;
  String? videoId;

  Media({
    required this.type,
    required this.url,
    this.videoId,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      type: json['type'] as String,
      url: json['url'] as String,
      videoId: json['videoId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'url': url,
      if (videoId != null) 'videoId': videoId,
    };
  }
}

List<LoanModel> loadData = [
  LoanModel(
    active: true,
    id: "loan1",
    coverPic:
        "https://t4.ftcdn.net/jpg/04/95/28/65/360_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg",
    desc: "This is a loan description for loan 1.",
    media: [
      Media(
        type: "image",
        url: "https://example.com/media1.jpg",
      ),
      Media(
        type: "video",
        url: "https://example.com/media1_video.mp4",
        videoId: "videoId1",
      ),
    ],
    order: 1,
    title: "Personal Loan",
  ),
  LoanModel(
    active: true,
    id: "loan2",
    coverPic:
        "https://t4.ftcdn.net/jpg/04/95/28/65/360_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg",
    desc: "This is a loan description for loan 2.",
    media: [
      Media(
        type: "image",
        url: "https://example.com/media2.jpg",
      ),
      Media(
        type: "video",
        url: "https://example.com/media2_video.mp4",
        videoId: "videoId2",
      ),
    ],
    order: 2,
    title: "Home Loan",
  ),
  LoanModel(
    active: false,
    id: "loan3",
    coverPic:
        "https://t4.ftcdn.net/jpg/04/95/28/65/360_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg",
    desc: "This is a loan description for loan 3.",
    media: [
      Media(
        type: "image",
        url: "https://example.com/media3.jpg",
      ),
      Media(
        type: "video",
        url: "https://example.com/media3_video.mp4",
        videoId: "videoId3",
      ),
    ],
    order: 3,
    title: "Car Loan",
  ),
  LoanModel(
    active: true,
    id: "loan4",
    coverPic:
        "https://t4.ftcdn.net/jpg/04/95/28/65/360_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg",
    desc: "This is a loan description for loan 4.",
    media: [
      Media(
        type: "image",
        url: "https://example.com/media4.jpg",
      ),
      Media(
        type: "video",
        url: "https://example.com/media4_video.mp4",
        videoId: "videoId4",
      ),
    ],
    order: 4,
    title: "Education Loan",
  ),
  LoanModel(
    active: true,
    id: "loan5",
    coverPic:
        "https://t4.ftcdn.net/jpg/04/95/28/65/360_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg",
    desc: "This is a loan description for loan 5.",
    media: [
      Media(
        type: "image",
        url: "https://example.com/media5.jpg",
      ),
      Media(
        type: "video",
        url: "https://example.com/media5_video.mp4",
        videoId: "videoId5",
      ),
    ],
    order: 5,
    title: "Business Loan",
  ),
];
