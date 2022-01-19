import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:okejek_flutter/controller/auth/history/history_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/order_model.dart';
import 'package:okejek_flutter/widgets/history/card_order.dart';
import 'package:okejek_flutter/widgets/loading_animation.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HistoryController historyController = Get.find();

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Riwayat',
          style: TextStyle(
            fontFamily: OkejekTheme.font_family,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig.safeBlockHorizontal * 18 / 3.6,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: PopupMenuButton<String>(
              offset: Offset(0, SizeConfig.safeBlockHorizontal * 50 / 3.6),
              tooltip: 'Pilih Filter Riwayat',
              onSelected: (value) {
                choicesButton(value, historyController);
              },
              child: Padding(
                padding: EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 10 / 3.6),
                child: Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black54,
                      ),
                      Obx(
                        () => Text(
                          historyController.currentSort.value == 'Selesai'
                              ? 'Selesai'
                              : historyController.currentSort.value == 'Dalam Perjalanan'
                                  ? 'Dalam Perjalanan'
                                  : 'Dibatalkan',
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                            color: historyController.currentSort.value == 'Selesai'
                                ? Colors.green
                                : historyController.currentSort.value == 'Dalam Perjalanan'
                                    ? Colors.grey
                                    : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemBuilder: (context) {
                return historyController.sortOrder.map((String choice) {
                  return PopupMenuItem(
                    onTap: () {
                      historyController.changeSorting(choice);
                      historyController.fetchHistory();
                    },
                    value: choice,
                    child: Text(
                      choice,
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      ),
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () {
                historyController.resetController();
                return historyController.fetchHistory();
              },
              child: Obx(
                () => historyController.isLoading.value
                    ? Container(
                        height: Get.height,
                        width: Get.width,
                        child: Center(
                          child: LoadingAnimation(),
                        ),
                      )
                    : historyController.showedList.length == 0
                        ? emptyIllustration()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            controller: historyController.scrollController,
                            itemCount: historyController.showedList.length + 1,
                            itemBuilder: (context, index) {
                              // create a loading in last index
                              if (index == historyController.showedList.length) {
                                return Obx(
                                  () => historyController.isFetching.value
                                      ? Center(
                                          child: Transform.scale(
                                            scale: 0.5,
                                            child: SizedBox(
                                              height: SizeConfig.safeBlockHorizontal * 70 / 3.6,
                                              width: SizeConfig.safeBlockHorizontal * 50 / 3.6,
                                              child: LoadingIndicator(
                                                indicatorType: Indicator.lineSpinFadeLoader,
                                                strokeWidth: 5.0,
                                                colors: [
                                                  Color(0xFFF3DBDB),
                                                ],
                                                backgroundColor: Colors.transparent,
                                                pathBackgroundColor: Colors.black,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                );
                              } else {
                                Order order = Order.fromJson(historyController.showedList[index]);
                                return CardOrder(
                                  order: order,
                                );
                              }
                            },
                          ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void choicesButton(String choice, HistoryController historyController) {
    historyController.changeSorting(choice);
  }

  Widget emptyIllustration() {
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.2,
        ),
        Container(
          height: SizeConfig.safeBlockVertical * 150 / 7.56,
          width: SizeConfig.safeBlockHorizontal * 150 / 3.6,
          child: SvgPicture.asset(
            'assets/images/nature.svg',
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 40 / 7.56,
        ),
        Center(
          child: Text(
            'Riwayat tidak ditemukan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 20 / 7.56,
        ),
        Text(
          'Silahkan lakukan transaksi untuk melihat riwayat',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
