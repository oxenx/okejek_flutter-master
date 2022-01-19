import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okeexpress/oke_express_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/pages/auth/okeexpress/information/oke_express_send_from.dart';
import 'package:okejek_flutter/pages/auth/okeexpress/result_resi/oke_express_data_found.dart';

class OkeExpressPage extends StatelessWidget {
  final OkeExpressController okeExpressController = Get.put(OkeExpressController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: OkejekTheme.primary_color,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: Get.height * 0.75,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: OkejekTheme.primary_color,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: Get.height * 0.15,
                          width: Get.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/oke express v2-02.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 30 / 7.6,
                        ),
                        Container(
                          height: Get.height * 0.28,
                          width: Get.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/oke express v2-01.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 10 / 7.6,
                        ),
                        Text(
                          'Kirim paket dimana saja, kapan saja..',
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 10 / 7.6,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: SizedBox(
                            height: SizeConfig.safeBlockVertical * 50 / 7.6,
                            width: Get.width,
                            child: TextField(
                              controller: okeExpressController.resiNumber,
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                                  right: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                                ),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                hintText: 'Masukkan nomor resi..',
                                hintStyle: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                  color: Colors.white,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 10 / 7.6,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 20 / 3.6),
                          child: Obx(
                            () => okeExpressController.isLoading.value
                                ? Container(
                                    height: SizeConfig.safeBlockHorizontal * 80 / 7.2,
                                    width: SizeConfig.safeBlockVertical * 50 / 7.2,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      String resiNumber = okeExpressController.resiNumber.text;
                                      if (resiNumber.isEmpty) {
                                        errorSnackbar();
                                      } else {
                                        resiNumber == 'testing'
                                            ? Get.to(() => OkeExpressDataFound(), transition: Transition.rightToLeft)
                                            : okeExpressController.lacakPaket();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 20 / 3.6),
                                      ),
                                      minimumSize: Size(
                                        Get.width,
                                        SizeConfig.safeBlockVertical * 40 / 7.6,
                                      ),
                                      primary: Colors.white,
                                    ),
                                    child: Text(
                                      'Lacak',
                                      style: TextStyle(
                                        fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                        color: OkejekTheme.primary_color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 20 / 3.6),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => OkeExpressSendFrom(), transition: Transition.rightToLeft);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[300],
                        fixedSize: Size(Get.width, SizeConfig.blockSizeVertical * 50 / 7.2),
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 20 / 3.6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kirim Barang',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Icon(
                            Icons.cases_rounded,
                            color: OkejekTheme.primary_color,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: SizeConfig.safeBlockVertical * 10 / 7.2,
              left: SizeConfig.safeBlockHorizontal * 10 / 3.6,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void errorSnackbar() {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        'Masukan Resi number dulu',
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
          color: Colors.white,
        ),
      ),
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }
}
