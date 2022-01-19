import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPaymentShimmer extends StatelessWidget {
  const LoadingPaymentShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
        physics: ClampingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              height: Get.height * 0.03,
              width: Get.width,
              margin: EdgeInsets.symmetric(
                vertical: SizeConfig.safeBlockVertical * 10 / 7.2,
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
