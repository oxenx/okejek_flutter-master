class Payment {
  Payment({
    required this.provider,
    required this.providerName,
    required this.status,
    required this.amount,
  });

  String provider;
  String providerName;
  int status;
  int amount;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        provider: json["provider"],
        providerName: json["provider_name"],
        status: json["status"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "provider": provider,
        "provider_name": providerName,
        "status": status,
        "amount": amount,
      };
}
