import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/landing_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class DeeplinkPage extends StatelessWidget {
  final LandingController landingController = Get.find();
  String get id => landingController.deepLinkId.value;
  String get type => landingController.deepLinkType.value;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Map<String, bool>>(
                future: landingController.checkTransactionStatus(id, type),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    Map data = snapshot.data!;
                    bool isTrue = data['order'] || data['outlets'];
                    if (isTrue) {
                      return successWidget(id, type);
                    } else {
                      return failedWidget();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget successWidget(id, type) {
    return Column(
      children: [
        Container(
          height: SizeConfig.safeBlockVertical * 100 / 7.2,
          width: SizeConfig.safeBlockHorizontal * 100 / 3.6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          child: Center(
            child: Icon(
              Icons.done,
              size: SizeConfig.safeBlockHorizontal * 100 / 3.6,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 30 / 7.2,
        ),
        Text(
          'Pembayaran Berhasil!',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 15 / 7.2,
        ),
        Text(
          'Silahkan Lanjutkan untuk memproses pesanan',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
            color: Colors.black54,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 50 / 7.2,
        ),
        Obx(() => landingController.isLoading.value
            ? Container(
                height: 30,
                width: 10,
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockVertical * 20 / 7.2),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    minimumSize: Size(Get.width, SizeConfig.safeBlockVertical * 40 / 7.2),
                  ),
                  onPressed: () {
                    type == 'order' ? landingController.deeplinkOrder(id) : landingController.deeplinkOutlet(id);
                  },
                  child: Text(
                    'Lanjutkan',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ))
      ],
    );
  }

  Widget failedWidget() {
    return Column(
      children: [
        Container(
          height: SizeConfig.safeBlockVertical * 100 / 7.2,
          width: SizeConfig.safeBlockHorizontal * 100 / 3.6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          child: Center(
            child: Icon(
              Icons.close,
              size: SizeConfig.safeBlockHorizontal * 100 / 3.6,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 30 / 7.2,
        ),
        Text(
          'Pembayaran Gagal!',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 15 / 7.2,
        ),
        Text(
          'Pembayaran gagal. Silahkan coba lagi',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
