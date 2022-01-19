import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/news_item.dart';

class DetailNewsPage extends StatelessWidget {
  final NewsItem newsItem;
  final DateFormat formattedDate = DateFormat('dd-MM-yyyy – kk:mm');

  DetailNewsPage({
    required this.newsItem,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Berita',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        elevation: 1.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: OkejekTheme.primary_color,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newsItem.title,
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                ),
                Text(
                  formattedDate.format(newsItem.createdAt),
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                ),
                newsItem.image.isEmpty
                    ? Container()
                    : Container(
                        height: Get.height * 0.2,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(newsItem.image),
                          ),
                        ),
                      ),
                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                ),
                Text(
                  newsItem.content,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
