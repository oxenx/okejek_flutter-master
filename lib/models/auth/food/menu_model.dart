class Menu {
  Menu({
    required this.id,
    required this.name,
    required this.foodVendorId,
    required this.image,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.discount,
    required this.available,
    required this.featured,
    required this.menuGroupId,
    required this.group,
  });

  int id;
  String name;
  int foodVendorId;
  String image;
  String imageUrl;
  String description;
  int price;
  int discount;
  bool available;
  bool featured;
  int menuGroupId;
  dynamic group;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        name: json["name"],
        foodVendorId: json["food_vendor_id"],
        image: json["image"],
        imageUrl: json["image_url"],
        description: json["description"],
        price: json["price"],
        discount: json["discount"],
        available: json["available"],
        featured: json["featured"],
        menuGroupId: json["menu_group_id"],
        group: json["group"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "food_vendor_id": foodVendorId,
        "image": image,
        "image_url": imageUrl,
        "description": description,
        "price": price,
        "discount": discount,
        "available": available,
        "featured": featured,
        "menu_group_id": menuGroupId,
        "group": group,
      };
}
