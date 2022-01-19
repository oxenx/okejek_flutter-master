import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okemart/okemart_controller.dart';
import 'package:okejek_flutter/controller/auth/store/store_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_model.dart';
import 'package:okejek_flutter/pages/auth/okefood/detail_outlet_page.dart';

/// Menampilkan rekomendasi outlet mart
class RecommendationMart extends StatelessWidget {
  final OkeMartController okeMartController = Get.find();
  final StoreController storeController = Get.put(StoreController());
  final DateTime currentTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder<List<FoodVendor>>(
      future: okeMartController.getFoodVendor(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: Get.height * 0.3,
            width: Get.width,
            child: SpinKitDoubleBounce(
              color: Color(0xFFE0675C),
              size: SizeConfig.blockSizeHorizontal * 50 / 3.6,
            ),
          );
        } else {
          List<FoodVendor> listFoodVendor = snapshot.data!;

          return Container(
            height: Get.height * 0.3,
            width: Get.width,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: listFoodVendor.length,
                itemBuilder: (context, index) {
                  FoodVendor foodVendor = listFoodVendor[index];
                  // TODO : image url vendor ERROR
                  foodVendor.imageUrl =
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg/330px-Good_Food_Display_-_NCI_Visuals_Online.jpg';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(
                          () => DetailOutletPage(
                            foodVendor: foodVendor,
                            type: 100,
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, SizeConfig.safeBlockHorizontal * 3.5,
                              SizeConfig.safeBlockHorizontal * 7, SizeConfig.safeBlockHorizontal * 3.5),
                          height: Get.height * 0.15,
                          width: Get.width * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: OkejekTheme.bg_color,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(foodVendor.imageUrl),
                              fit: BoxFit.cover,
                              colorFilter: storeController.isStoreOpen(foodVendor)
                                  ? ColorFilter.mode(Colors.transparent, BlendMode.color)
                                  : ColorFilter.mode(Colors.grey, BlendMode.color),
                              onError: (exception, stackTrace) => Icon(Icons.broken_image_outlined),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          width: Get.width * 0.5,
                          child: Text(
                            foodVendor.name,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: Colors.black87,
                                  fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
