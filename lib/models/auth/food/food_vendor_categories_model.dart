// To parse this JSON data, do
//
//     final foodVendorCategories = foodVendorCategoriesFromJson(jsonString);

import 'dart:convert';

List<FoodVendorCategories> foodVendorCategoriesFromJson(String str) =>
    List<FoodVendorCategories>.from(json.decode(str).map((x) => FoodVendorCategories.fromJson(x)));

String foodVendorCategoriesToJson(List<FoodVendorCategories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodVendorCategories {
  FoodVendorCategories({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  int id;
  String name;
  String? imageUrl;

  factory FoodVendorCategories.fromJson(Map<String, dynamic> json) => FoodVendorCategories(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
      };
}
