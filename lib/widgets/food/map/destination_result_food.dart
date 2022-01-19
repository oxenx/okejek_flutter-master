import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okefood/map_okefood_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/okeride/auto_complete_model.dart';
import 'package:shimmer/shimmer.dart';

/// Modal yang dipakai untuk menampilakan hasil dari pencarian
/// alamat pada food / mart
class DestinationResultFood extends StatelessWidget {
  final MapOkefoodController mapOkefoodController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx(
      () => mapOkefoodController.isSubmitDestination.value
          ? FutureBuilder<List<AutoCompletePlace>>(
              future: mapOkefoodController.getDestinationCoordinatesfromPlace(mapOkefoodController.searchPlace.value),
              builder: (context, snapshot) {
                // List<AutoCompletePlace>? listofPlace = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // on fetch loading animation
                  return loadingAnimation();
                } else {
                  return Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: [
                        Text(
                          'Hasil Pencarian :',
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            AutoCompletePlace place = snapshot.data![index];

                            return ListView(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              children: [
                                InkWell(
                                  splashColor: Colors.grey,
                                  onTap: () {
                                    Navigator.pop(context);
                                    mapOkefoodController.destinationLocation.value = place.name;
                                    mapOkefoodController.destinationAddress.value = place.address;
                                    mapOkefoodController.latitude.value = place.location.lat;
                                    mapOkefoodController.longitude.value = place.location.lng;
                                  },
                                  child: Container(
                                    height: Get.height * 0.08,
                                    width: Get.width,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                place.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                                ),
                                              ),
                                              Text(
                                                place.address,
                                                style: TextStyle(
                                                  fontSize: SizeConfig.safeBlockHorizontal * 2.8,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          : Container(),
    );
  }

  Widget loadingAnimation() {
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
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 100, 10),
              height: Get.height * 0.02,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 30, 30),
              height: Get.height * 0.015,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
