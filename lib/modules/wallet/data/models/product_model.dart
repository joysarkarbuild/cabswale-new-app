class ProductModel {
  bool active;
  String id;
  List<String> categories;
  String coverPic;
  String desc;
  double discountedPrice;
  double maxRedeemableWalletAmount;
  List<Media> media;
  int order;
  double price;
  String title;

  ProductModel({
    required this.active,
    required this.categories,
    required this.coverPic,
    required this.desc,
    required this.discountedPrice,
    required this.maxRedeemableWalletAmount,
    required this.media,
    required this.order,
    required this.price,
    required this.title,
    required this.id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      active: json['active'] as bool,
      categories: List<String>.from(json['categories']),
      coverPic: json['coverPic'] as String,
      desc: json['desc'] as String,
      discountedPrice: json['discountedPrice'].toDouble(),
      maxRedeemableWalletAmount: json['maxRedeemableWalletAmount'].toDouble(),
      media: (json['media'] as List<dynamic>)
          .map((item) => Media.fromJson(item as Map<String, dynamic>))
          .toList(),
      order: json['order'] as int,
      price: json['price'].toDouble(),
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'active': active,
      'categories': categories,
      'coverPic': coverPic,
      'desc': desc,
      'discountedPrice': discountedPrice,
      'maxRedeemableWalletAmount': maxRedeemableWalletAmount,
      'media': media.map((item) => item.toJson()).toList(),
      'order': order,
      'price': price,
      'title': title,
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

List<ProductModel> dummyProducts = [
  ProductModel(
    id: "1",
    active: true,
    categories: ["Electronics", "Smartphone"],
    coverPic: "https://via.placeholder.com/150/0000FF/808080?text=Smartphone",
    desc: "Latest smartphone with cutting-edge technology.",
    discountedPrice: 699.99,
    maxRedeemableWalletAmount: 50.0,
    media: [
      Media(
        type: "image",
        url: "https://via.placeholder.com/400",
      ),
      Media(
        type: "video",
        url: "https://example.com/video.mp4",
        videoId: "12345",
      ),
    ],
    order: 1,
    price: 799.99,
    title: "Smartphone 2024",
  ),
  ProductModel(
    id: "2",
    active: true,
    categories: ["Appliances", "Kitchen"],
    coverPic: "https://via.placeholder.com/150/FF0000/FFFFFF?text=Blender",
    desc: "High-power kitchen blender for smoothies and more.",
    discountedPrice: 49.99,
    maxRedeemableWalletAmount: 10.0,
    media: [
      Media(
        type: "image",
        url: "https://via.placeholder.com/400",
      ),
    ],
    order: 2,
    price: 59.99,
    title: "Kitchen Blender",
  ),
  ProductModel(
    id: "3",
    active: true,
    categories: ["Fashion", "Men's Wear"],
    coverPic: "https://via.placeholder.com/150/FFFF00/000000?text=T-shirt",
    desc: "Comfortable and stylish t-shirt for casual wear.",
    discountedPrice: 19.99,
    maxRedeemableWalletAmount: 5.0,
    media: [
      Media(
        type: "image",
        url: "https://via.placeholder.com/400",
      ),
    ],
    order: 3,
    price: 24.99,
    title: "Men's T-shirt",
  ),
];
