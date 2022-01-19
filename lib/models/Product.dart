import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.id,
    required this.namaMakanan,
    required this.deskripsi,
    required this.harga,
    required this.jarak,
    required this.imageUrl,
  });

  String id;
  String namaMakanan;
  String deskripsi;
  int harga;
  String jarak;
  String imageUrl;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        namaMakanan: json["nama_makanan"],
        deskripsi: json["deskripsi"],
        harga: json["harga"],
        jarak: json["jarak"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_makanan": namaMakanan,
        "deskripsi": deskripsi,
        "harga": harga,
        "jarak": jarak,
        "imageUrl": imageUrl,
      };
}
