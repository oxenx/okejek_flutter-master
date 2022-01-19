// To parse this JSON data, do
//
//     final ads = adsFromJson(jsonString);

import 'dart:convert';

import 'package:okejek_flutter/models/auth/food/food_vendor_model.dart';

List<Ads> adsFromJson(String str) => List<Ads>.from(json.decode(str).map((x) => Ads.fromJson(x)));

String adsToJson(List<Ads> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ads {
  Ads({
    required this.id,
    required this.url,
    required this.trackingUrl,
    required this.image,
    required this.imageUrl,
    required this.thumbImageUrl,
    required this.foodVendorId,
    required this.foodVendor,
  });

  String id;
  String url;
  String trackingUrl;
  String image;
  String imageUrl;
  String thumbImageUrl;
  int foodVendorId;
  FoodVendor foodVendor;

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        id: json["id"],
        url: json["url"],
        trackingUrl: json["tracking_url"],
        image: json["image"],
        imageUrl: json["image_url"],
        thumbImageUrl: json["thumb_image_url"],
        foodVendorId: json["food_vendor_id"],
        foodVendor: FoodVendor.fromJson(json["food_vendor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "tracking_url": trackingUrl,
        "image": image,
        "image_url": imageUrl,
        "thumb_image_url": thumbImageUrl,
        "food_vendor_id": foodVendorId,
        "food_vendor": foodVendor,
      };
}
