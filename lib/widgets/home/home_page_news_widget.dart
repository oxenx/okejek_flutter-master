import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/api/news_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/home_news.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

/// Tampilan Grid News pada halaman home
class HomePageNews extends StatelessWidget {
  final NewsApiController newsApiController = Get.put(NewsApiController());
  int get newsLength => newsApiController.newsList.length;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Obx(() => newsLength == 0 ? Container() : newsGrid());
  }

  Widget loadingNews() {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          Color(0xFFE7E7E7),
          Color(0xFFF4F4F4),
          Color(0xFFE7E7E7),
        ],
        stops: [
          0.4,
          0.5,
          0.6,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.8),
        tileMode: TileMode.clamp,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: 6,
        itemBuilder: (_, index) {
          return Container(
            margin: EdgeInsets.all(10),
            height: Get.height * 0.2,
            width: Get.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * 0.2,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Expanded(
                  child: Text(
                    'Judul Berita',
                    style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3.3),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget newsGrid() {
    return newsApiController.isLoading.value
        ? loadingNews()
        : Column(
            children: [
              Text(
                'Berita Hari ini',
                style: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                    ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: newsApiController.newsList.length,
                itemBuilder: (_, index) {
                  HomeNews homeNews = newsApiController.newsList[index];
                  String formattedDate = DateFormat('dd-MM-yyyy').format(homeNews.date);

                  return GestureDetector(
                    onTap: () {
                      launchURL(homeNews.link);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: Get.height * 0.2,
                      width: Get.width * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: homeNews.jetpackFeaturedMediaUrl,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, progress) {
                              return Container(
                                height: Get.height * 0.2,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                height: Get.height * 0.2,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Expanded(
                            child: Text(
                              homeNews.title.rendered,
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 2.7,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
  }

  void launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
