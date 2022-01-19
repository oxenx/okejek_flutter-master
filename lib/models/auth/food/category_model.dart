class Category {
  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.imageUrl,
  });

  int id;
  String name;
  String image;
  String imageUrl;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "image_url": imageUrl,
      };
}
