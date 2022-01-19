import 'dart:convert';

import 'package:okejek_flutter/models/auth/driver_model.dart';
import 'package:okejek_flutter/models/auth/payment_model.dart';
import 'package:okejek_flutter/models/login/user_model.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    required this.id,
    required this.originAddress,
    required this.originLatlng,
    required this.destinationAddress,
    required this.destinationLatlng,
    required this.originAddressDetail,
    required this.destinationAddressDetail,
    required this.status,
    required this.type,
    required this.route,
    required this.distance,
    required this.userId,
    required this.driverId,
    required this.info,
    required this.createdAt,
    required this.couponId,
    required this.discount,
    required this.driverInfo,
    required this.useUserBalance,
    required this.foodVendorId,
    required this.coupon,
    required this.driver,
    required this.score,
    required this.user,
    required this.items,
    required this.payments,
    required this.courier,
    required this.payment,
    required this.androidVersion,
    required this.originalFee,
    required this.totalDiscount,
    required this.totalShopping,
    required this.fee,
    required this.paidBalance,
    required this.paidCash,
    required this.isVerified,
  });

  int id;
  String originAddress;
  String originLatlng;
  String destinationAddress;
  String destinationLatlng;
  String originAddressDetail;
  String destinationAddressDetail;
  int status;
  int type;
  String route;
  int distance;
  int userId;
  int driverId;
  String info;
  DateTime createdAt;
  int couponId;
  int discount;
  String driverInfo;
  bool useUserBalance;
  int? foodVendorId;
  dynamic coupon;
  Driver? driver;
  dynamic score;
  User user;
  List<dynamic> items;
  List<dynamic> payments;
  dynamic courier;
  Payment? payment;
  int androidVersion;
  double originalFee;
  int totalDiscount;
  String totalShopping;
  String fee;
  String paidBalance;
  String paidCash;
  bool isVerified;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        originAddress: json["origin_address"],
        originLatlng: json["origin_latlng"],
        destinationAddress: json["destination_address"],
        destinationLatlng: json["destination_latlng"],
        originAddressDetail: json["origin_address_detail"],
        destinationAddressDetail: json["destination_address_detail"],
        status: json["status"],
        type: json["type"],
        route: json["route"],
        distance: json["distance"],
        userId: json["user_id"],
        driverId: json["driver_id"],
        info: json["info"],
        createdAt: DateTime.parse(json["created_at"]),
        couponId: json["coupon_id"],
        discount: json["discount"],
        driverInfo: json["driver_info"],
        useUserBalance: json["use_user_balance"],
        foodVendorId: json["food_vendor_id"] ?? null,
        coupon: json["coupon"],
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
        score: json["score"],
        user: User.fromJson(json["user"]),
        items: List<dynamic>.from(json["items"].map((x) => x)),
        payments: List<dynamic>.from(json["payments"].map((x) => x)),
        courier: json["courier"],
        payment: json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        androidVersion: json["android_version"],
        originalFee: json["original_fee"] is int ? json["original_fee"].toDouble() : double.parse(json["original_fee"]),
        totalDiscount: json["total_discount"],
        totalShopping: json["total_shopping"],
        fee: json["fee"],
        paidBalance: json["paid_balance"],
        paidCash: json["paid_cash"],
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "origin_address": originAddress,
        "origin_latlng": originLatlng,
        "destination_address": destinationAddress,
        "destination_latlng": destinationLatlng,
        "origin_address_detail": originAddressDetail,
        "destination_address_detail": destinationAddressDetail,
        "status": status,
        "type": type,
        "route": route,
        "distance": distance,
        "user_id": userId,
        "driver_id": driverId,
        "info": info,
        "created_at": createdAt.toIso8601String(),
        "coupon_id": couponId,
        "discount": discount,
        "driver_info": driverInfo,
        "use_user_balance": useUserBalance,
        "food_vendor_id": foodVendorId,
        "coupon": coupon,
        "driver": driver?.toJson(),
        "score": score,
        "user": user.toJson(),
        "items": List<dynamic>.from(items.map((x) => x)),
        "payments": List<dynamic>.from(payments.map((x) => x)),
        "courier": courier,
        "payment": payment?.toJson(),
        "android_version": androidVersion,
        "original_fee": originalFee,
        "total_discount": totalDiscount,
        "total_shopping": totalShopping,
        "fee": fee,
        "paid_balance": paidBalance,
        "paid_cash": paidCash,
        "is_verified": isVerified,
      };
}
