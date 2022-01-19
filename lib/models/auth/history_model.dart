// To parse this JSON data, do
//
//     final history = historyFromMap(jsonString);

import 'dart:convert';

History historyFromMap(String str) => History.fromMap(json.decode(str));

String historyToMap(History data) => json.encode(data.toMap());

class History {
  History({
    required this.service,
    required this.status,
    required this.dateCreated,
    required this.hourCreated,
    required this.ongkir,
    required this.destinationAddress,
  });

  String service;
  String status;
  String dateCreated;
  String hourCreated;
  int ongkir;
  String destinationAddress;

  factory History.fromMap(Map<String, dynamic> json) => History(
        service: json["service"],
        status: json["status"],
        dateCreated: json["date_created"],
        hourCreated: json["hour_created"],
        ongkir: json["ongkir"],
        destinationAddress: json["destination_address"],
      );

  Map<String, dynamic> toMap() => {
        "service": service,
        "status": status,
        "date_created": dateCreated,
        "hour_created": hourCreated,
        "ongkir": ongkir,
        "destination_address": destinationAddress,
      };
}
