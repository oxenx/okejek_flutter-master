import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/auth/home_news.dart';

class NewsApiController extends GetxController {
  var newsList = [].obs;
  var isLoading = false.obs;

  Dio dio = Dio();

  void onInit() {
    super.onInit();
    getNews();
  }

  void delete() {
    super.onDelete();
  }

  void getNews() async {
    isLoading.value = true;
    String url = OkejekBaseURL.apiUrl('news/cached-news-items');

    try {
      var response = await dio.get(
        url,
        options: Options(
          headers: {
            'Accepts': 'application/json',
          },
        ),
      );

      // handling news type is changing sometimes
      if (response.data is List) {
        List responseBody = response.data;
        responseBody.forEach((news) {
          newsList.add(HomeNews.fromJson(news));
        });
      } else {
        Map responseBody = response.data;
        for (var news in responseBody.keys) {
          newsList.add(HomeNews.fromJson(news));
        }
      }

      isLoading.value = false;
    } on DioError catch (e) {
      // showing failure text
      print(e.message);
    }
  }
}
