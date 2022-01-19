import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.apiToken,
    this.address,
    this.contactPhone,
    this.contactMobile,
    this.activated,
    this.createdAt,
    this.updatedAt,
    this.business,
    this.balance,
    this.cityId,
    this.refId,
    this.isValidated,
  });

  int? id;
  String? name;
  String? email;
  String? apiToken;
  String? address;
  String? contactPhone;
  String? contactMobile;
  bool? activated;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? business;
  String? balance;
  int? cityId;
  int? refId;
  bool? isValidated;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        apiToken: json["api_token"],
        address: json["address"],
        contactPhone: json["contact_phone"],
        contactMobile: json["contact_mobile"],
        activated: json["activated"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        business: json["business"],
        balance: json["balance"],
        cityId: json["city_id"],
        refId: json["ref_id"],
        isValidated: json["is_validated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "api_token": apiToken,
        "address": address,
        "contact_phone": contactPhone,
        "contact_mobile": contactMobile,
        "activated": activated,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "business": business,
        "balance": balance,
        "city_id": cityId,
        "ref_id": refId,
        "is_validated": isValidated,
      };
}
