// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  Item({
    required this.id,
    required this.orderId,
    required this.qty,
    required this.price,
    required this.name,
    required this.detail,
    required this.createdAt,
    required this.updatedAt,
    required this.itemId,
    required this.type,
    required this.itemType,
  });

  int id;
  int orderId;
  int qty;
  String price;
  String name;
  String detail;
  DateTime createdAt;
  DateTime updatedAt;
  int itemId;
  int type;
  String itemType;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        orderId: json["order_id"],
        qty: json["qty"],
        price: json["price"],
        name: json["name"],
        detail: json["detail"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        itemId: json["item_id"],
        type: json["type"],
        itemType: json["item_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "qty": qty,
        "price": price,
        "name": name,
        "detail": detail,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "item_id": itemId,
        "type": type,
        "item_type": itemType,
      };
}
