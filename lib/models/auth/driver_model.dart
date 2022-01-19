class Driver {
  Driver({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.imageUrl,
    required this.vehicleType,
    required this.vehicleBrand,
    required this.vehiclePlate,
    required this.vehicleColor,
    required this.gender,
    required this.cityId,
    required this.recruiterId,
    required this.skills,
  });

  int id;
  String name;
  String email;
  String phone;
  String image;
  String imageUrl;
  String vehicleType;
  String vehicleBrand;
  String vehiclePlate;
  String vehicleColor;
  int gender;
  int cityId;
  String recruiterId;
  List<dynamic> skills;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        imageUrl: json["image_url"],
        vehicleType: json["vehicle_type"],
        vehicleBrand: json["vehicle_brand"],
        vehiclePlate: json["vehicle_plate"],
        vehicleColor: json["vehicle_color"],
        gender: json["gender"],
        cityId: json["city_id"],
        recruiterId: json["recruiter_id"],
        skills: List<dynamic>.from(json["skills"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "image_url": imageUrl,
        "vehicle_type": vehicleType,
        "vehicle_brand": vehicleBrand,
        "vehicle_plate": vehiclePlate,
        "vehicle_color": vehicleColor,
        "gender": gender,
        "city_id": cityId,
        "recruiter_id": recruiterId,
        "skills": List<dynamic>.from(skills.map((x) => x)),
      };
}
