import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/news/news_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/news_item.dart';
import 'package:okejek_flutter/pages/auth/news/detail_news_page.dart';
import 'package:okejek_flutter/widgets/loading_animation.dart';

class NewsPage extends StatelessWidget {
  final DateFormat formattedDate = DateFormat('dd-MM-yyyy – kk:mm');
  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.put(NewsController());
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List>(
                future: newsController.fetchNotification(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: Get.height * 0.8,
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          LoadingAnimation(),
                        ],
                      ),
                    );
                  } else {
                    if (!snapshot.hasData) {
                      return Container(
                        height: Get.height,
                        width: Get.width,
                        child: Center(
                          child: Text(
                            'Tidak ada berita terbaru',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              NewsItem newsItem = snapshot.data![index];

                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => DetailNewsPage(newsItem: newsItem), transition: Transition.rightToLeft);
                                },
                                child: Card(
                                  elevation: 1.0,
                                  margin: EdgeInsets.all(10),
                                  child: Container(
                                    height: Get.height * 0.20,
                                    width: Get.width,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Container(
                                              height: SizeConfig.blockSizeHorizontal * 50 / 3.6,
                                              width: SizeConfig.screenWidth,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  newsItem.title,
                                                  style: TextStyle(
                                                    fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.date_range,
                                                  size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                                                  color: Colors.black54,
                                                ),
                                                SizedBox(
                                                  width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                                ),
                                                Text(
                                                  formattedDate.format(newsItem.createdAt),
                                                  style: TextStyle(
                                                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                                    color: Colors.black54,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                          ),
                                          Flexible(
                                            flex: 4,
                                            child: Container(
                                              height: SizeConfig.blockSizeHorizontal * 90 / 3.6,
                                              width: SizeConfig.screenWidth,
                                              child: Text(
                                                newsItem.summary,
                                                style: TextStyle(
                                                  height: 1.5,
                                                  fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                                  color: Colors.black54,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                                textAlign: TextAlign.start,
                                                softWrap: true,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                          ),
                        ],
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
