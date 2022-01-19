class VendorCity {
  VendorCity({
    required this.name,
    required this.id,
  });

  String name;
  int id;

  factory VendorCity.fromJson(Map<String, dynamic> json) => VendorCity(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
