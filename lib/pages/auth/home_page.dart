import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/ads_controller.dart';
import 'package:okejek_flutter/controller/api/user_controller.dart';
import 'package:okejek_flutter/controller/auth/okefood/okefood_controller.dart';
import 'package:okejek_flutter/controller/auth/store/store_controller.dart';
import 'package:okejek_flutter/controller/landing_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/ads_model.dart';
import 'package:okejek_flutter/pages/auth/okefood/detail_outlet_page.dart';
import 'package:okejek_flutter/widgets/home/home_page_news_widget.dart';
import 'package:okejek_flutter/widgets/home/main_menu_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomePage extends StatelessWidget {
  final List<int> cardList = [1, 2, 3];
  final UserController userController = Get.find();
  final LandingController landingController = Get.find();
  final OkeFoodController okefoodController = Get.put(OkeFoodController());
  final StoreController storeController = Get.put(StoreController());
  final AdsController adsController = Get.put(AdsController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (landingController.isLoading.value) showAlertDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverLayoutBuilder(builder: (BuildContext context, constraints) {
              final opacity = 1 - (constraints.scrollOffset * 100 / 11600);
              final whiteValue = constraints.scrollOffset / 80;
              double whiteOpacity = whiteValue > 1 ? 1 : whiteValue;
              return SliverAppBar(
                systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
                  statusBarColor: Colors.white.withOpacity(whiteOpacity),
                ),
                backgroundColor: OkejekTheme.primary_color.withOpacity(opacity),
                expandedHeight: SizeConfig.safeBlockVertical * 60 / 7.2,
                floating: false,
                pinned: false,
                bottom: PreferredSize(
                  preferredSize: Size(
                    SizeConfig.safeBlockHorizontal * 30 / 3.6,
                    SizeConfig.safeBlockVertical * 20 / 7.2,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        constraints: BoxConstraints(
                          maxWidth: double.infinity,
                          maxHeight: SizeConfig.safeBlockVertical * 60 / 7.2,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Cari disini..',
                        hintStyle: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3),
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.black54,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 2, horizontal: SizeConfig.blockSizeHorizontal * 2),
                      ),
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.safeBlockHorizontal * 3,
                      ),
                    ),
                  ),
                ),
              );
            })
          ];
        },
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Customer information
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() => RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Halo, '.tr,
                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                  color: Colors.black87, fontSize: SizeConfig.safeBlockHorizontal * 5),
                                            ),
                                            TextSpan(
                                              text: userController.name.value,
                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                                                  ),
                                              recognizer: TapGestureRecognizer()..onTap = () {},
                                            ),
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    height: Get.height * 0.015,
                                  ),
                                  Obx(() => RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: userController.balance.value,
                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: ' Oke Point',
                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                  color: Colors.black45,
                                                  fontSize: SizeConfig.safeBlockHorizontal * 3.3),
                                              recognizer: TapGestureRecognizer()..onTap = () {},
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: SizeConfig.blockSizeVertical * 7,
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(OkejekTheme.rounded_corner),
                                    image: DecorationImage(
                                      image: AssetImage('assets/icons/other/icon profile.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: Get.height * 0.05,
                          ),

                          // layanan menu gridview
                          MainMenu(),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Divider(),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),

                          // Ads Carousel
                          FutureBuilder<List<Ads>>(
                              future: adsController.getAdsBanner('front'),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height * 0.3,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else {
                                  if (snapshot.data!.length == 0) {
                                    return SizedBox();
                                  } else {
                                    return CarouselSlider(
                                      options: CarouselOptions(
                                          autoPlay: true,
                                          autoPlayInterval: Duration(seconds: 5),
                                          autoPlayAnimationDuration: Duration(milliseconds: 1000),
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          pauseAutoPlayOnTouch: true,
                                          enlargeCenterPage: false,
                                          viewportFraction: 1,
                                          onPageChanged: (index, reason) {}),
                                      items: snapshot.data!.map((item) {
                                        return adsCard(context, item);
                                      }).toList(),
                                    );
                                  }
                                }
                              }),

                          SizedBox(
                            height: Get.height * 0.05,
                          ),

                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          //Gridview news
                          HomePageNews(),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () {
                      if (userController.isServiceAvailable.value) {
                        return Container();
                      } else {
                        SchedulerBinding.instance!.addPostFrameCallback(
                          (_) {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.info(
                                backgroundColor: Colors.yellow,
                                icon: Container(),
                                message: 'Maaf, layanan kami belum tersedia di tempat anda berada saat ini',
                                textStyle: TextStyle(fontSize: 12, color: Colors.black),
                              ),
                              displayDuration: Duration(days: 1),
                            );
                          },
                        );
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget adsCard(BuildContext context, Ads item) {
    return CachedNetworkImage(
      imageUrl: item.imageUrl,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, progress) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6,
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
        return GestureDetector(
          onTap: () {
            print('hello there');
            print(item.foodVendor);
            Get.to(
              () => DetailOutletPage(
                foodVendor: item.foodVendor,
                type: item.foodVendor.type == 'food' ? 3 : 100,
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  showAlertDialog(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: 100,
          height: 100,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
