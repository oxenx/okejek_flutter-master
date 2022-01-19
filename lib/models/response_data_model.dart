import 'package:okejek_flutter/models/auth/ads_model.dart';
import 'package:okejek_flutter/models/auth/okeride/auto_complete_model.dart';
import 'package:okejek_flutter/models/auth/calculate_request_model.dart';
import 'package:okejek_flutter/models/auth/city_model.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_categories_model.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_model.dart';
import 'package:okejek_flutter/models/auth/news_item.dart';
import 'package:okejek_flutter/models/auth/okeride/geocode_result_model.dart';
import 'package:okejek_flutter/models/auth/order_model.dart';
import 'package:okejek_flutter/models/auth/coupon_model.dart';
import 'package:okejek_flutter/models/init/appconfigs_model.dart';
import 'package:okejek_flutter/models/login/user_model.dart';

class ResponseData {
  Appconfigs? appConfigs;
  List<Ads>? ads;
  User? user;
  City? city;
  Order? orders;
  String? session;
  List<NewsItem>? newsItems;
  List<FoodVendorCategories>? foodVendorCategories;
  List<FoodVendor>? foodVendor;
  FoodVendor? detailVendor;
  Calculate? calculateRequest;
  GeocodeResult? geocodeResult;
  AutoComplete? autoComplete;
  Coupon? coupon;
  dynamic ad;

  ResponseData({
    this.appConfigs,
    this.ads,
    this.user,
    this.city,
    this.orders,
    this.newsItems,
    this.coupon,
    this.foodVendor,
    this.detailVendor,
    this.foodVendorCategories,
    this.calculateRequest,
    this.geocodeResult,
    this.autoComplete,
    this.session,
    this.ad,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        appConfigs: json["app_configs"] == null ? null : Appconfigs.fromJson(json["app_configs"]),
        ads: json["ads"] == null ? null : List<Ads>.from(json["ads"].map((x) => Ads.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        orders: json["order"] == null ? null : Order.fromJson(json["order"]),
        newsItems: json["news_items"] == null
            ? null
            : List<NewsItem>.from(json["news_items"].map((x) => NewsItem.fromJson(x))),
        foodVendorCategories: json["food_vendor_categories"] == null
            ? null
            : List<FoodVendorCategories>.from(
                json["food_vendor_categories"].map((x) => FoodVendorCategories.fromJson(x))),
        foodVendor: json["food_vendors"] == null
            ? null
            : List<FoodVendor>.from(json["food_vendors"].map((x) => FoodVendor.fromJson(x))),
        detailVendor: json["food_vendor"] == null ? null : FoodVendor.fromJson(json["food_vendor"]),
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
        calculateRequest: json["calculated_request"] == null ? null : Calculate.fromJson(json["calculated_request"]),
        geocodeResult: json["geocode_result"] == null ? null : GeocodeResult.fromJson(json["geocode_result"]),
        autoComplete: json["autocomplete_result"] == null ? null : AutoComplete.fromJson(json["autocomplete_result"]),
        session: json["session"],
        ad: json["ad"],
      );

  Map<String, dynamic> toJson() => {
        "app_configs": appConfigs?.toJson(),
        "ads": ads?.toList(),
        "user": user?.toJson(),
        "city": city?.toJson(),
        "orders": orders?.toJson(),
        "coupon": coupon?.toJson(),
        "news_items": newsItems?.toList(),
        "food_vendors": foodVendor?.toList(),
        "calculated_request": calculateRequest?.toJson(),
        "food_vendor_categories": foodVendorCategories?.toList(),
        "geocode_result": geocodeResult?.toJson(),
        "food_vendor": detailVendor?.toJson(),
        "autocomplete_result": autoComplete?.toJson(),
        "session": session,
        "ad": ad,
      };
}
