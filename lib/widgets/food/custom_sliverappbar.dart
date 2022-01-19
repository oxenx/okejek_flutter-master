import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okefood/okefood_controller.dart';
import 'package:okejek_flutter/controller/auth/store/store_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_model.dart';

/// Custom header untuk melihat informasi yang berkaitan dengan resto / mart
class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final FoodVendor foodVendor;
  final bool hideTitleWhenExpanded;

  OkeFoodController okeFoodController = Get.find();
  StoreController storeController = Get.find();

  CustomSliverDelegate({
    required this.foodVendor,
    required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;

    SizeConfig().init(context);
    return Container(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          Container(
            height: appBarSize < SizeConfig.safeBlockHorizontal * 60 / 3.6
                ? SizeConfig.safeBlockHorizontal * 60 / 3.6
                : appBarSize,
            child: AppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                )
              ],
              flexibleSpace: Opacity(
                opacity: percent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg/330px-Good_Food_Display_-_NCI_Visuals_Online.jpg'),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) => Container(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              elevation: 0.0,
              title: Opacity(
                opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                child: Text(
                  foodVendor.name,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                  vertical: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                ),
                child: Container(
                  height: SizeConfig.safeBlockHorizontal * 100 / 3.6,
                  child: Card(
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              foodVendor.name,
                              style: TextStyle(
                                fontSize: foodVendor.name.length > 25
                                    ? SizeConfig.safeBlockHorizontal * 13 / 3.6
                                    : SizeConfig.safeBlockHorizontal * 16 / 3.6,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                            ),
                            Text(
                              foodVendor.address,
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                color: Colors.black54,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                            ),
                            Divider(),
                            SizedBox(
                              height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                            ),
                            storeController.isStoreOpen(foodVendor) ? openHours() : closed(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget closed() {
    return Row(
      children: [
        Container(
          height: SizeConfig.blockSizeVertical * 3,
          width: SizeConfig.blockSizeVertical * 7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.red,
          ),
          child: Center(
            child: Text(
              'Closed',
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.safeBlockHorizontal * 2.7,
              ),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
        ),
        foodVendor.closed
            ? Container()
            : Text(
                'Buka lagi jam ' +
                    storeController.storeOpenHour.toString().padLeft(2, '0') +
                    ':' +
                    storeController.storeOpenMinutes.toString().padLeft(2, '0'),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: SizeConfig.safeBlockHorizontal * 2.7,
                ),
              ),
      ],
    );
  }

  Widget openHours() {
    return Row(
      children: [
        Container(
          height: SizeConfig.blockSizeVertical * 3,
          width: SizeConfig.blockSizeVertical * 7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.green,
          ),
          child: Center(
            child: Text(
              'Open',
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.safeBlockHorizontal * 2.7,
              ),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.safeBlockHorizontal * 2.8,
        ),
        Icon(
          Icons.access_time_outlined,
          size: SizeConfig.safeBlockHorizontal * 5,
          color: Colors.black54,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          storeController.store24Hours.value ? 'Buka 24 Jam' : getSchedule(),
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 2.7,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  String getSchedule() {
    String openHour = storeController.storeOpenHour.value.toString().padLeft(2, '0');
    String openMinutes = storeController.storeOpenMinutes.value.toString().padLeft(2, '0');

    String closeHour = storeController.storeCloseHour.value.toString().padLeft(2, '0');
    String closeMinutes = storeController.storeCloseMinutes.value.toString().padLeft(2, '0');
    String schedule = openHour + ':' + openMinutes + ' - ' + closeHour + ':' + closeMinutes;
    print('current schedule : ' + schedule);
    return schedule;
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => SizeConfig.safeBlockHorizontal * 60 / 3.6;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
