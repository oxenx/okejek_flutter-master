class BusinessHour {
  BusinessHour({
    required this.foodVendorId,
    required this.day,
    required this.openHour,
    required this.openMinute,
    required this.closeHour,
    required this.closeMinute,
    required this.isOpen,
  });

  int foodVendorId;
  int day;
  int openHour;
  int openMinute;
  int closeHour;
  int closeMinute;
  bool isOpen;

  factory BusinessHour.fromJson(Map<String, dynamic> json) => BusinessHour(
        foodVendorId: json["food_vendor_id"],
        day: json["day"],
        openHour: json["open_hour"],
        openMinute: json["open_minute"],
        closeHour: json["close_hour"],
        closeMinute: json["close_minute"],
        isOpen: json["is_open"],
      );

  Map<String, dynamic> toJson() => {
        "food_vendor_id": foodVendorId,
        "day": day,
        "open_hour": openHour,
        "open_minute": openMinute,
        "close_hour": closeHour,
        "close_minute": closeMinute,
        "is_open": isOpen,
      };
}
