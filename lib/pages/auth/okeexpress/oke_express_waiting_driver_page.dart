import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okeexpress/oke_express_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class OkeExpressWaitingDriver extends StatelessWidget {
  final OkeExpressController okeExpressController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => Container(
            height: Get.height,
            width: Get.width,
            child: okeExpressController.isLoading.value ? waitingAnimation() : confirmAnimation(),
          ),
        ),
      ),
    );
  }

  Widget confirmAnimation() {
    return Entry.all(
      xOffset: 0,
      yOffset: 0,
      duration: Duration(milliseconds: 400),
      opacity: 0,
      scale: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: SizeConfig.safeBlockHorizontal * 100 / 3.6,
            height: SizeConfig.safeBlockVertical * 100 / 7.2,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.done,
              color: Colors.white,
              size: SizeConfig.safeBlockHorizontal * 80 / 3.6,
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 20 / 7.2,
          ),
          Container(
            width: SizeConfig.safeBlockHorizontal * 250 / 3.6,
            height: SizeConfig.safeBlockVertical * 30 / 7.2,
            child: Center(
              child: Text(
                'Pesanan Terkonfirmasi',
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget waitingAnimation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.access_time_filled_sharp,
          color: Colors.orange,
          size: SizeConfig.safeBlockHorizontal * 150 / 3.6,
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 20 / 7.2,
        ),
        Container(
          width: SizeConfig.safeBlockHorizontal * 250 / 3.6,
          height: SizeConfig.safeBlockVertical * 30 / 7.2,
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
            child: Center(
              child: AnimatedTextKit(
                repeatForever: true,
                pause: Duration(milliseconds: 500),
                animatedTexts: [
                  FadeAnimatedText(
                    'Menunggu Driver..',
                    fadeOutBegin: 0.8,
                    fadeInEnd: 0.4,
                    duration: Duration(
                      milliseconds: 2000,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
