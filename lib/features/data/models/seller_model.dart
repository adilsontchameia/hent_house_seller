import 'dart:convert';

SellerModel sellerModelFromJson(String str) =>
    SellerModel.fromJson(json.decode(str));

String sellerModelToJson(SellerModel data) => json.encode(data.toJson());

class SellerModel {
  String? id;
  String? firstName;
  String? surnName;
  String? fullName;
  String? email;
  String? phone;
  bool? isVerified;
  bool? isTopSeller;
  bool? isOnline;
  String? address;
  double? latitude;
  double? longitude;
  String? image;

  SellerModel({
    this.id,
    this.firstName,
    this.surnName,
    this.fullName,
    this.email,
    this.phone,
    this.isVerified,
    this.isTopSeller,
    this.isOnline,
    this.address,
    this.latitude,
    this.longitude,
    this.image,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
        id: json["id"] ?? '',
        firstName: json["firstName"] ?? '',
        surnName: json["surnName"] ?? '',
        fullName: json["fullName"] ?? '',
        phone: json["phone"] ?? '',
        email: json["email"] ?? '',
        isVerified: json["isVerified"] ?? true,
        isTopSeller: json["isTopSeller"] ?? false,
        isOnline: json["isOnline"] ?? true,
        address: json["address"] ?? '',
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "surnName": surnName,
        "fullName": fullName,
        "phone": phone,
        "email": email,
        "isVerified": isVerified,
        "isTopSeller": isTopSeller,
        "isOnline": isOnline,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "image": image,
      };
}
