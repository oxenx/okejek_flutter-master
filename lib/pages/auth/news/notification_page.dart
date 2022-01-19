import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/news/news_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.put(NewsController());
    SizeConfig().init(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: newsController.dummyNews.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 1.0,
            margin: EdgeInsets.all(10),
            child: Container(
              color: Colors.white,
              height: Get.height * 0.12,
              width: Get.width,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.notifications),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            'Notification Title',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(
                            '11 October 2021',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                              color: Colors.black54,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
