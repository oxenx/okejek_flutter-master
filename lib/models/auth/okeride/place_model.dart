import 'package:okejek_flutter/models/auth/okeride/location_model.dart';

class Place {
  Place({
    required this.name,
    required this.location,
  });

  String name;
  Location location;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        name: json["name"],
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "location": location.toJson(),
      };
}
