// To parse this JSON data, do
//
//     final calculate = calculateFromJson(jsonString);

import 'dart:convert';

Calculate calculateFromJson(String str) => Calculate.fromJson(json.decode(str));

String calculateToJson(Calculate data) => json.encode(data.toJson());

class Calculate {
  Calculate({
    required this.distance,
    required this.distanceValue,
    required this.duration,
    required this.fee,
    required this.commission,
    this.encodedRoutePath,
  });

  int distance;
  int distanceValue;
  int duration;
  int fee;
  int commission;
  String? encodedRoutePath;

  factory Calculate.fromJson(Map<String, dynamic> json) => Calculate(
        distance: json["distance"],
        distanceValue: json["distance_value"],
        duration: json["duration"],
        fee: json["fee"],
        commission: json["commission"],
        encodedRoutePath: json["encoded_route_path"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "distance_value": distanceValue,
        "duration": duration,
        "fee": fee,
        "commission": commission,
        "encoded_route_path": encodedRoutePath,
      };
}
