// To parse required this JSON data, do
//
//     final autoComplete = autoCompleteFromJson(jsonString);

import 'dart:convert';

import 'package:okejek_flutter/models/auth/okeride/location_model.dart';

AutoComplete autoCompleteFromJson(String str) => AutoComplete.fromJson(json.decode(str));

String autoCompleteToJson(AutoComplete data) => json.encode(data.toJson());

class AutoComplete {
  AutoComplete({
    required this.searchtext,
    required this.places,
  });

  dynamic searchtext;
  List<AutoCompletePlace> places;

  factory AutoComplete.fromJson(Map<String, dynamic> json) => AutoComplete(
        searchtext: json["searchtext"],
        places: List<AutoCompletePlace>.from(json["places"].map((x) => AutoCompletePlace.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "searchtext": searchtext,
        "places": List<dynamic>.from(places.map((x) => x.toJson())),
      };
}

class AutoCompletePlace {
  AutoCompletePlace({
    required this.name,
    required this.address,
    required this.distance,
    required this.categories,
    required this.distanceKm,
    required this.location,
  });

  String name;
  String address;
  int distance;
  String categories;
  double distanceKm;
  Location location;

  factory AutoCompletePlace.fromJson(Map<String, dynamic> json) => AutoCompletePlace(
        name: json["name"],
        address: json["address"],
        distance: json["distance"],
        categories: json["categories"],
        distanceKm: json["distance_km"].toDouble(),
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "distance": distance,
        "categories": categories,
        "distance_km": distanceKm,
        "location": location.toJson(),
      };
}
