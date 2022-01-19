// To parse this JSON data, do
//
//     final geocodeResult = geocodeResultFromJson(jsonString);

import 'dart:convert';
import 'package:okejek_flutter/models/auth/okeride/place_model.dart';

GeocodeResult geocodeResultFromJson(String str) => GeocodeResult.fromJson(json.decode(str));

String geocodeResultToJson(GeocodeResult data) => json.encode(data.toJson());

class GeocodeResult {
  GeocodeResult({
    required this.subject,
    required this.reverse,
    required this.places,
    required this.provider,
    required this.debug,
  });

  String subject;
  bool reverse;
  List<Place> places;
  String provider;
  Debug? debug;

  factory GeocodeResult.fromJson(Map<String, dynamic> json) => GeocodeResult(
        subject: json["subject"],
        reverse: json["reverse"],
        places: List<Place>.from(json["places"].map((x) => Place.fromJson(x))),
        provider: json["provider"],
        debug: json["debug"] == null ? null : Debug.fromJson(json["debug"]),
      );

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "reverse": reverse,
        "places": List<dynamic>.from(places.map((x) => x.toJson())),
        "provider": provider,
        "debug": debug?.toJson(),
      };
}

class Debug {
  Debug({
    required this.url,
    required this.query,
  });

  String url;
  Query query;

  factory Debug.fromJson(Map<String, dynamic> json) => Debug(
        url: json["url"],
        query: Query.fromJson(json["query"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "query": query.toJson(),
      };
}

class Query {
  Query({
    required this.apiKey,
    required this.country,
    required this.lang,
    required this.limit,
    required this.at,
  });

  String apiKey;
  String country;
  String lang;
  String limit;
  String at;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        apiKey: json["apiKey"],
        country: json["country"],
        lang: json["lang"],
        limit: json["limit"],
        at: json["at"],
      );

  Map<String, dynamic> toJson() => {
        "apiKey": apiKey,
        "country": country,
        "lang": lang,
        "limit": limit,
        "at": at,
      };
}
