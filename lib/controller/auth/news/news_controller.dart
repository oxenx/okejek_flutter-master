import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/auth/news_item.dart';
import 'package:okejek_flutter/models/base_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsController extends GetxController {
  Dio dio = Dio();

  var dummyNews = [
    {
      "title": "Lorem ipsum dolor Aliquam rhoncus cursus ante ac fermentum.",
      "summary":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam rhoncus cursus ante ac fermentum. Donec sagittis erat ut nisi consequat interdum. Suspendisse dictum nec tortor in porttitor. Cras ac tortor est. Praesent feugiat magna eget justo ornare fringilla. Etiam eleifend nisi nisi, ut dapibus risus aliquet et. Vivamus commodo pretium diam. Phasellus feugiat magna at ipsum sollicitudin tempus. Etiam feugiat bibendum urna at pharetra. Vivamus quis urna porta, tempor est eget, gravida nulla. Pellentesque aliquet fermentum quam, imperdiet consectetur purus tincidunt eu. Morbi sollicitudin, odio eget semper dictum, augue erat placerat nulla, sit amet aliquam nulla lorem eu arcu. Quisque ante metus, imperdiet sed diam non, rhoncus ornare augue. Integer facilisis est finibus viverra convallis. Morbi a turpis nec nisi semper ultrices. Fusce non luctus elitis",
      "created": "11 October 2021",
    },
    {
      "title": "Lorem ipsum dolor sit amet, consectetur fermentum.",
      "summary":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam rhoncus cursus ante ac fermentum. Donec sagittis erat ut nisi consequat interdum. Suspendisse dictum nec tortor in porttitor. Cras ac tortor est. Praesent feugiat magna eget justo ornare fringilla. Etiam eleifend nisi nisi, ut dapibus risus aliquet et. Vivamus commodo pretium diam. Phasellus feugiat magna at ipsum sollicitudin tempus. Etiam feugiat bibendum urna at pharetra. Vivamus quis urna porta, tempor est eget, gravida nulla. Pellentesque aliquet fermentum quam, imperdiet consectetur purus tincidunt eu. Morbi sollicitudin, odio eget semper dictum, augue erat placerat nulla, sit amet aliquam nulla lorem eu arcu. Quisque ante metus, imperdiet sed diam non, rhoncus ornare augue. Integer facilisis est finibus viverra convallis. Morbi a turpis nec nisi semper ultrices. Fusce non luctus elit.",
      "created": "11 October 2021",
    },
    {
      "title": "Lorem ipsum dolor",
      "summary":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam rhoncus cursus ante ac fermentum. Donec sagittis erat ut nisi consequat interdum. Suspendisse dictum nec tortor in porttitor. Cras ac tortor est. Praesent feugiat magna eget justo ornare fringilla. Etiam eleifend nisi nisi, ut dapibus risus aliquet et. Vivamus commodo pretium diam. Phasellus feugiat magna at ipsum sollicitudin tempus. Etiam feugiat bibendum urna at pharetra. Vivamus quis urna porta, tempor est eget, gravida nulla. Pellentesque aliquet fermentum quam, imperdiet consectetur purus tincidunt eu. Morbi sollicitudin, odio eget semper dictum, augue erat placerat nulla, sit amet aliquam nulla lorem eu arcu. Quisque ante metus, imperdiet sed diam non, rhoncus ornare augue. Integer facilisis est finibus viverra convallis. Morbi a turpis nec nisi semper ultrices. Fusce non luctus elit.",
      "created": "11 October 2021",
    },
    {
      "title": "Lorem ipsum dolor sit.",
      "summary":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam rhoncus cursus ante ac fermentum. Donec sagittis erat ut nisi consequat interdum. Suspendisse dictum nec tortor in porttitor. Cras ac tortor est. Praesent feugiat magna eget justo ornare fringilla. Etiam eleifend nisi nisi, ut dapibus risus aliquet et. Vivamus commodo pretium diam. Phasellus feugiat magna at ipsum sollicitudin tempus. Etiam feugiat bibendum urna at pharetra. Vivamus quis urna porta, tempor est eget, gravida nulla. Pellentesque aliquet fermentum quam, imperdiet consectetur purus tincidunt eu. Morbi sollicitudin, odio eget semper dictum, augue erat placerat nulla, sit amet aliquam nulla lorem eu arcu. Quisque ante metus, imperdiet sed diam non, rhoncus ornare augue. Integer facilisis est finibus viverra convallis. Morbi a turpis nec nisi semper ultrices. Fusce non luctus elit.",
      "created": "11 October 2021",
    },
    {
      "title": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam rhoncus cursus ante",
      "summary":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam rhoncus cursus ante ac fermentum. Donec sagittis erat ut nisi consequat interdum. Suspendisse dictum nec tortor in porttitor. Cras ac tortor est. Praesent feugiat magna eget justo ornare fringilla. Etiam eleifend nisi nisi, ut dapibus risus aliquet et. Vivamus commodo pretium diam. Phasellus feugiat magna at ipsum sollicitudin tempus. Etiam feugiat bibendum urna at pharetra. Vivamus quis urna porta, tempor est eget, gravida nulla. Pellentesque aliquet fermentum quam, imperdiet consectetur purus tincidunt eu. Morbi sollicitudin, odio eget semper dictum, augue erat placerat nulla, sit amet aliquam nulla lorem eu arcu. Quisque ante metus, imperdiet sed diam non, rhoncus ornare augue. Integer facilisis est finibus viverra convallis. Morbi a turpis nec nisi semper ultrices. Fusce non luctus elit.",
      "created": "11 October 2021",
    },
  ];

  var notificationList = [].obs;

  Future<List> fetchNotification() async {
    List listNews = [];
    // String url = OkejekBaseURL.listNotificationAPI;
    String url = OkejekBaseURL.apiUrl('news/all');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    try {
      var queryParams = {
        'api_token': session,
      };

      var response = await dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Accepts': 'application/json',
          },
        ),
      );

      var responseBody = response.data;
      BaseResponse baseResponse = BaseResponse.fromJson(responseBody);

      List<NewsItem>? listNewsItem = baseResponse.data.newsItems;

      listNewsItem!.forEach((news) {
        listNews.add(news);
      });

      return listNews;
    } on DioError catch (e) {
      print(e.message);
      return [];
    }
  }
}
