import 'dart:convert';

import 'package:okejek_flutter/models/auth/food/bussiness_hour_model.dart';
import 'package:okejek_flutter/models/auth/food/category_model.dart';
import 'package:okejek_flutter/models/auth/food/menu_model.dart';
import 'package:okejek_flutter/models/auth/food/vendor_city_model.dart';

List<FoodVendor> foodVendorFromJson(String str) =>
    List<FoodVendor>.from(json.decode(str).map((x) => FoodVendor.fromJson(x)));

String foodVendorToJson(List<FoodVendor> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodVendor {
  FoodVendor({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
    required this.isOpen24Hours,
    required this.image,
    required this.imageUrl,
    required this.closed,
    required this.menus,
    required this.categories,
    required this.city,
    required this.businessHours,
    required this.latlng,
    required this.foodVendorGroupId,
    required this.isPartner,
    required this.menuGroups,
    required this.test,
  });

  int id;
  String type;
  String name;
  String description;
  String address;
  String phone;
  bool isOpen24Hours;
  String image;
  String imageUrl;
  bool closed;
  List<Menu> menus;
  List<Category> categories;
  VendorCity city;
  List<BusinessHour> businessHours;
  String latlng;
  int foodVendorGroupId;
  bool isPartner;
  List<VendorCity> menuGroups;
  bool test;

  factory FoodVendor.fromJson(Map<String, dynamic> json) => FoodVendor(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        description: json["description"],
        address: json["address"],
        phone: json["phone"],
        isOpen24Hours: json["is_open_24_hours"],
        image: json["image"],
        imageUrl: json["image_url"],
        closed: json["closed"],
        menus: List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        city: VendorCity.fromJson(json["city"]),
        businessHours: List<BusinessHour>.from(json["business_hours"].map((x) => BusinessHour.fromJson(x))),
        latlng: json["latlng"],
        foodVendorGroupId: json["food_vendor_group_id"],
        isPartner: json["is_partner"],
        menuGroups: List<VendorCity>.from(json["menu_groups"].map((x) => VendorCity.fromJson(x))),
        test: json["test"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "description": description,
        "address": address,
        "phone": phone,
        "is_open_24_hours": isOpen24Hours,
        "image": image,
        "image_url": imageUrl,
        "closed": closed,
        "menus": List<dynamic>.from(menus.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "city": city.toJson(),
        "business_hours": List<dynamic>.from(businessHours.map((x) => x.toJson())),
        "latlng": latlng,
        "food_vendor_group_id": foodVendorGroupId,
        "is_partner": isPartner,
        "menu_groups": List<dynamic>.from(menuGroups.map((x) => x.toJson())),
        "test": test,
      };
}
