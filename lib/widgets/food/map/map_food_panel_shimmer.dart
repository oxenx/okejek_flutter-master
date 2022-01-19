import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:shimmer/shimmer.dart';

/// animasi loading pada pencarian
class MapFoodPanelShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Shimmer(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                  width: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                  color: Colors.grey[100],
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                ),
                Container(
                  height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                  width: Get.width * 0.77,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Container(
              height: SizeConfig.safeBlockHorizontal * 40 / 3.6,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
