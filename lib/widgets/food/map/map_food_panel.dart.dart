import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okefood/map_okefood_controller.dart';
import 'package:okejek_flutter/controller/auth/okefood/okefood_payment_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/widgets/food/map/destination_header_food.dart';
import 'package:okejek_flutter/widgets/food/map/destination_result_food.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/// Bottom panel yang diapakai untuk pick location
class MapFoodPanel extends StatelessWidget {
  final MapOkefoodController mapOkefoodController = Get.find();
  final OkefoodPaymentController foodPaymentController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController destTextController = TextEditingController();
  final PanelController panelController;

  MapFoodPanel({
    required this.panelController,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5.56),
      child: GestureDetector(
        onTap: () {
          showModalLokasi(context, mapOkefoodController);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Container(
                  height: Get.height * 0.06,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 4.167),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                          width: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: OkejekTheme.primary_color,
                          ),
                          child: Icon(
                            Icons.pin_drop_outlined,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                        ),
                        Flexible(
                          child: Container(
                            height: Get.height * 0.08,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                                    right: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                                  ),
                                  child: Obx(
                                    () => Text(
                                      mapOkefoodController.destinationLocation.value.isEmpty
                                          ? 'Cari lokasi pasar..'
                                          : mapOkefoodController.destinationLocation.value,
                                      style: TextStyle(
                                        fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                        color: Colors.black45,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2.64,
            ),
            confirmButton(foodPaymentController, mapOkefoodController),
          ],
        ),
      ),
    );
  }

  Widget confirmButton(OkefoodPaymentController okefoodPaymentController, MapOkefoodController mapOkefoodController) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          mapOkefoodController.destinationLocation.value.isEmpty
              ? print('do nothing')
              : confirm(okefoodPaymentController, mapOkefoodController);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
            color: mapOkefoodController.destinationLocation.value.isEmpty ? Colors.grey : OkejekTheme.primary_color,
            borderRadius: BorderRadius.circular(10),
          ),
          width: Get.width,
          height: Get.height * 0.06,
          child: Center(
            child: Text(
              'Konfirmasi',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.safeBlockHorizontal * 3.3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void confirm(OkefoodPaymentController okefoodPaymentController, MapOkefoodController mapOkefoodController) {
    okefoodPaymentController.destLocation.value = mapOkefoodController.destinationLocation.value;
    okefoodPaymentController.destinationAddress.value = mapOkefoodController.destinationAddress.value;
    okefoodPaymentController.setDestCoordinates(
        mapOkefoodController.latitude.value, mapOkefoodController.longitude.value);
    okefoodPaymentController.fetchSucess.value = false;
    Get.back();
  }

  showModalLokasi(context, MapOkefoodController mapOkefoodController) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      isDismissible: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5.56),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DestinationHeaderFood(
                      formKey: _formKey,
                      panelController: panelController,
                    ),
                    DestinationResultFood(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
