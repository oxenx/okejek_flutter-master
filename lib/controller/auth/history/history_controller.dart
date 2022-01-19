import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryController extends GetxController {
  Dio dio = Dio();
  ScrollController scrollController = ScrollController();
  int currentItem = 0;
  var maxItemPerFetch = 10.obs;

  var isFetching = false.obs;
  var isLoading = false.obs;
  var allFetchData = [].obs;
  var showedList = [].obs;

  var isDataFound = false.obs;
  var isChanged = false.obs;

  var sortOrder = [
    'Dalam Perjalanan',
    'Selesai',
    'Dibatalkan',
  ];

  var currentSort = 'Dalam Perjalanan'.obs;

  void onInit() {
    super.onInit();
    fetchHistory();
    scrollConfigure();
  }

  void delete() {
    super.onDelete();
    resetController();
  }

  void scrollConfigure() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        fetchMore();
        isFetching.value = true;
      }
    });
  }

  fetchMore() {
    int fetchMore = showedList.length + 5;
    Future.delayed(Duration(seconds: 2)).then((value) {
      if (allFetchData.length > showedList.length) {
        for (var i = showedList.length; i < fetchMore; i++) {
          showedList.insert(i, allFetchData[i]);
        }
      } else {
        isFetching.value = false;
      }
    });
  }

  Future<List> fetchHistory() async {
    isLoading.value = true;
    List listOfOrder = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    String status = currentSort.value == 'Dalam Perjalanan'
        ? 'progress'
        : currentSort.value == 'Selesai'
            ? 'finished'
            : 'cancel';

    // String url = OkejekBaseURL.historyUrl(status);
    String url = OkejekBaseURL.apiUrl('orders');

    try {
      var queryParams = {
        'status': '$status',
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
      print(url);
      print(session);

      // STATUS *SELESAI = 3 *DALAM PERJALANAN = 2  *DIBATALKAN = -1
      var responseBody = response.data;
      // print(responseBody);
      print(responseBody);
      for (var i = 0; i < responseBody['data']['orders'].length; i++) {
        responseBody['data']['orders'][i]['user']['activated'] == 1
            ? responseBody['data']['orders'][i]['user']['activated'] = true
            : responseBody['data']['orders'][i]['user']['activated'] = false;
      }

      // set a max item for looping
      int maxItem = responseBody['data']['orders'].length < maxItemPerFetch.value
          ? responseBody['data']['orders'].length
          : maxItemPerFetch.value;

      // create a list for show 10 items
      for (var i = currentItem; i < maxItem; i++) {
        showedList.add(responseBody['data']['orders'][i]);
      }

      // stored all order to a list
      allFetchData.addAll(responseBody['data']['orders']);
      isLoading.value = false;
      return listOfOrder;
    } on DioError catch (e) {
      // showing failure text
      print(e.message);
      return listOfOrder;
    }
  }

  void resetController() {
    showedList.clear();
    allFetchData.clear();
    isFetching.value = false;
  }

  void resetFilter() {
    currentSort.value = 'Dalam Perjalanan';
  }

  void changeSorting(String value) {
    currentSort.value = value;
    resetController();
  }
}
