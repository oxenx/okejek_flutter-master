// To parse this JSON data, do
//
//     final coupon = couponFromJson(jsonString);

import 'dart:convert';

Coupon couponFromJson(String str) => Coupon.fromJson(json.decode(str));

String couponToJson(Coupon data) => json.encode(data.toJson());

class Coupon {
  Coupon({
    required this.id,
    required this.code,
    required this.discountFee,
    required this.discountPercentage,
    required this.discountPercentageLimit,
  });

  int? id;
  String? code;
  int? discountFee;
  int? discountPercentage;
  String? discountPercentageLimit;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        discountFee: json["discount_fee"] == null ? null : json["discount_fee"],
        discountPercentage: json["discount_percentage"] == null ? null : json["discount_percentage"],
        discountPercentageLimit: json["discount_percentage_limit"] == null ? null : json["discount_percentage_limit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "discount_fee": discountFee,
        "discount_percentage": discountPercentage,
        "discount_percentage_limit": discountPercentageLimit,
      };
}
