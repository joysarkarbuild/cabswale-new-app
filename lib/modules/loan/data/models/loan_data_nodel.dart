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
