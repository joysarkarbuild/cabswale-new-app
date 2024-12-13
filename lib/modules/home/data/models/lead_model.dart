import 'package:flutter/cupertino.dart';

class LeadsModel {
  String? id;
  DateTime? createdAt;
  bool? active;
  bool? verified;
  CreatedBy? createdBy;
  From? from;
  From? to;
  String? carType;
  String? message;
  String? status;
  // int? capacity;
  dynamic at;
  dynamic metaData;
  String? leadType;
  // DateTime? time;
  String? shareImage;
  int? otp;
  LeadsModel({
    this.createdAt,
    this.shareImage,
    this.active,
    this.createdBy,
    this.from,
    this.to,
    // this.capacity,
    this.at,
    this.carType,
    this.message,
    this.status,
    this.metaData,
    this.leadType,
    // this.time,
    this.otp,
  });

  LeadsModel.fromJson(json, docId) {
    debugPrint('date.. : ${json['at'].runtimeType}');
    id = docId;
    createdAt = json['createdAt'].runtimeType == int
        ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'])
        : json['createdAt'].toDate();
    active = json['active'];
    verified = json['verified'] ?? false;
    createdBy = json['createdBy'] != null
        ? CreatedBy.fromJson(json['createdBy'])
        : null;
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    to = json['to'] != null ? From.fromJson(json['to']) : null;
    metaData = json['metaData'];
    carType = json['carType'] ?? json['cabType'];
    message = json['message'];
    status = json['status'];
    leadType = json['leadType'] ?? '';
    shareImage = json['shareImage'];
    // at = json['at'].runtimeType == String ? json['at'] : json['at'].toDate();
    // capacity = json['capacity'];
    // time = json.toString().contains('time') ? json['time'].toDate() : null;
    otp = json["otp"] ?? 100000;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['createdAt'] = createdAt;
    data['active'] = active;
    data['verified'] = verified;
    if (createdBy != null) {
      data['createdBy'] = createdBy!.toJson();
    }
    data['shareImage'] = shareImage;
    if (from != null) {
      data['from'] = from!.toJson();
    }
    if (to != null) {
      data['to'] = to!.toJson();
    }
    data['metaData'] = metaData;
    data['carType'] = carType;
    data['message'] = message;
    data['status'] = status;
    data['at'] = at;
    data["otp"] = otp;
    data['leadType'] = leadType;
    data['mataData'] = {'source': 'app'};
    // data['capacity'] = capacity;
    // data['time'] = time;
    return data;
  }
}

class CreatedBy {
  String? id;
  String? name;
  String? phoneNo;
  bool? verified;
  String? city;
  int? connections;
  bool? fraud;
  String? profileImage;

  CreatedBy({
    this.id,
    this.name,
    this.phoneNo,
    this.verified,
    this.city,
    this.connections,
    this.fraud,
    this.profileImage,
  });

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNo = json['phoneNo'];
    verified = json['verified'];
    city = json['city'];
    connections = json['connections'];
    fraud = json['fraud'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['phoneNo'] = phoneNo;
    data['verified'] = verified;
    data['city'] = city;
    data['connections'] = connections;
    data['fraud'] = fraud;
    data['profile_image'] = profileImage;
    return data;
  }
}

class From {
  String? city;

  From({this.city});

  From.fromJson(Map<String, dynamic> json) {
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['city'] = city;
    return data;
  }
}
