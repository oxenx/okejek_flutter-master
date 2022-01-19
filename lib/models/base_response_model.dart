import 'package:okejek_flutter/models/response_data_model.dart';

class BaseResponse {
  bool success;
  ResponseData data;

  BaseResponse({
    required this.success,
    required this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        success: json["success"],
        data: ResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}
