import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/initial_controller.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    InitController initController = Get.put(InitController());
    print(Get.height * 0.5);
    print(Get.width * 0.5);
    return Scaffold(
      body: FutureBuilder(
        future: initController.getInitRequest(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(
                height: Get.height * 0.5,
                width: Get.width * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Logo Okejek-02.png'),
                  ),
                ),
              ),
            );
          } else {
            SchedulerBinding.instance!.addPostFrameCallback((_) {
              initController.isLogin();
            });
            return Center(
              child: Container(
                height: Get.height * 0.5,
                width: Get.width * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Logo Okejek-02.png'),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
