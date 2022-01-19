import 'dart:convert';

Appconfigs appconfigsFromJson(String str) => Appconfigs.fromJson(json.decode(str));

String appconfigsToJson(Appconfigs data) => json.encode(data.toJson());

class Appconfigs {
  Appconfigs({
    required this.enableLinkaja,
    required this.enableAirpay,
    required this.enableOkepay,
    required this.shopeepayPromoUrl,
    required this.enableOkeMerchant,
    required this.merchantInfoUrl,
    required this.forceUpdate,
    required this.adPlacementsFood,
    required this.adPlacementsMart,
    required this.adPlacementsOutletFood,
    required this.adPlacementsOutletMart,
    required this.adPlacementsFrontHero,
    required this.adPlacementsFront,
    required this.shopCouriers,
    required this.chatBubbles,
  });

  bool enableLinkaja;
  bool enableAirpay;
  bool enableOkepay;
  String shopeepayPromoUrl;
  bool enableOkeMerchant;
  String merchantInfoUrl;
  bool forceUpdate;
  dynamic adPlacementsFood;
  dynamic adPlacementsMart;
  dynamic adPlacementsOutletFood;
  dynamic adPlacementsOutletMart;
  dynamic adPlacementsFrontHero;
  dynamic adPlacementsFront;
  ShopCouriers shopCouriers;
  String chatBubbles;

  factory Appconfigs.fromJson(Map<String, dynamic> json) => Appconfigs(
        enableLinkaja: json["enable_linkaja"],
        enableAirpay: json["enable_airpay"],
        enableOkepay: json["enable_okepay"],
        shopeepayPromoUrl: json["shopeepay_promo_url"],
        enableOkeMerchant: json["enable_oke_merchant"],
        merchantInfoUrl: json["merchant_info_url"],
        forceUpdate: json["force_update"],
        adPlacementsFood: json["ad_placements_food"],
        adPlacementsMart: json["ad_placements_mart"],
        adPlacementsOutletFood: json["ad_placements_outlet_food"],
        adPlacementsOutletMart: json["ad_placements_outlet_mart"],
        adPlacementsFrontHero: json["ad_placements_front_hero"],
        adPlacementsFront: json["ad_placements_front"],
        shopCouriers: ShopCouriers.fromJson(json["shop_couriers"]),
        chatBubbles: json["chat_bubbles"],
      );

  Map<String, dynamic> toJson() => {
        "enable_linkaja": enableLinkaja,
        "enable_airpay": enableAirpay,
        "enable_okepay": enableOkepay,
        "shopeepay_promo_url": shopeepayPromoUrl,
        "enable_oke_merchant": enableOkeMerchant,
        "merchant_info_url": merchantInfoUrl,
        "force_update": forceUpdate,
        "ad_placements_food": adPlacementsFood,
        "ad_placements_mart": adPlacementsMart,
        "ad_placements_outlet_food": adPlacementsOutletFood,
        "ad_placements_outlet_mart": adPlacementsOutletMart,
        "ad_placements_front_hero": adPlacementsFrontHero,
        "ad_placements_front": adPlacementsFront,
        "shop_couriers": shopCouriers.toJson(),
        "chat_bubbles": chatBubbles,
      };
}

class ShopCouriers {
  ShopCouriers({
    required this.okejack,
    required this.jne,
    required this.pos,
    required this.tiki,
  });

  String okejack;
  String jne;
  String pos;
  String tiki;

  factory ShopCouriers.fromJson(Map<String, dynamic> json) => ShopCouriers(
        okejack: json["okejack"],
        jne: json["jne"],
        pos: json["pos"],
        tiki: json["tiki"],
      );

  Map<String, dynamic> toJson() => {
        "okejack": okejack,
        "jne": jne,
        "pos": pos,
        "tiki": tiki,
      };
}
