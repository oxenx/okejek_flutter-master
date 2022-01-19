import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okefood/map_okefood_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/// Modal yang dipakai untuk mengisi alamat pada food / mart
// ignore: must_be_immutable
class DestinationHeaderFood extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MapOkefoodController mapOkefoodController = Get.find();
  PanelController panelController;

  DestinationHeaderFood({
    required this.formKey,
    required this.panelController,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
              width: SizeConfig.safeBlockHorizontal * 30 / 3.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: OkejekTheme.primary_color,
              ),
              margin: EdgeInsets.only(
                right: SizeConfig.safeBlockHorizontal * 10 / 3.6,
              ),
              child: Icon(
                Icons.pin_drop_outlined,
                color: Colors.white,
              ),
            ),
            Flexible(
              child: Obx(
                () {
                  return TextFormField(
                    validator: RequiredValidator(
                      errorText: 'Pencarian tidak boleh kosong',
                    ),
                    initialValue: mapOkefoodController.destinationAddress.value,
                    onFieldSubmitted: (value) {
                      validate(value);
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Tentukan lokasi tujuan',
                      hintStyle: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        Material(
          child: InkWell(
            onTap: () {
              Get.back();
              panelController.close();
              mapOkefoodController.isPickfromMap.value = true;
            },
            child: Container(
              height: Get.height * 0.05,
              width: Get.width,
              child: Row(
                children: [
                  Icon(
                    Icons.location_searching,
                  ),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                  ),
                  Text(
                    'Pilih lokasi dari map',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
      ],
    );
  }

  validate(String value) {
    if (formKey.currentState!.validate()) {
      mapOkefoodController.searchPlace.value = value;
      mapOkefoodController.isSubmitDestination.value = true;
      mapOkefoodController.getDestinationCoordinatesfromPlace(value);
    }
  }
}
