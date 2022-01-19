import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:okejek_flutter/controller/auth/okecourier/okecourier_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/pages/auth/okecourier/okecourier_origin_pick.dart';
import 'package:okejek_flutter/widgets/okecourier/okecourier_contact_list.dart';
import 'package:okejek_flutter/widgets/okecourier/panel/okecourier_location_search.dart';
import 'package:okejek_flutter/widgets/okecourier/panel/okecourier_panel_detail_address.dart';
import 'package:okejek_flutter/widgets/okeride/origin_search_result_modal.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OkeCourierPanelDetail extends StatelessWidget {
  final PanelController pc;
  final GlobalKey<FormState> formKey;
  final TextEditingController namaPengirimController;
  final TextEditingController namaPenerimaController;
  final TextEditingController noHPPengirimController;
  final TextEditingController noHPPenerimaController;
  final TextEditingController detailBarangController;
  final Completer<GoogleMapController> mapcontroller;

  OkeCourierPanelDetail({
    required this.pc,
    required this.formKey,
    required this.mapcontroller,
    required this.detailBarangController,
    required this.namaPenerimaController,
    required this.namaPengirimController,
    required this.noHPPengirimController,
    required this.noHPPenerimaController,
  });

  final OkeCourierController okeCourierController = Get.find();
  bool get isOriginSection => okeCourierController.isOriginSection.value;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.safeBlockVertical * 400 / 7.2,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          isOriginSection ? 'Informasi Barang' : 'Tujuan Pengiriman',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 5 / 7.2,
                      ),
                      Obx(
                        () => Text(
                          isOriginSection ? 'Isi detail informasi barang dulu ya' : 'Isi alamat tujuan barang',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: IconButton(
                    onPressed: () {
                      okeCourierController.isLoading.value ? print('wait a minute') : validate();
                    },
                    icon: Obx(
                      () => Container(
                        width: SizeConfig.safeBlockHorizontal * 50 / 3.6,
                        height: SizeConfig.safeBlockVertical * 50 / 7.2,
                        decoration: BoxDecoration(
                          color: okeCourierController.isLoading.value
                              ? Colors.white
                              : isOriginSection
                                  ? Colors.orange
                                  : OkejekTheme.primary_color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Obx(
                            () => okeCourierController.isLoading.value
                                ? CircularProgressIndicator(
                                    color: Colors.orange,
                                  )
                                : Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 30 / 7.2,
            ),
            GestureDetector(
              onTap: () {
                Get.to(
                  () => OkeCourierPick(
                    mapcontroller: mapcontroller,
                    pc: pc,
                  ),
                  transition: Transition.downToUp,
                );
              },
              child: OkeCourierPanelDetailAddress(
                isOriginSection: isOriginSection,
                okeCourierController: okeCourierController,
              ),
            ),
            textField('Nama Pengirim', namaPengirimController, true),
            textFieldDestination('Nama Penerima', namaPenerimaController, true),
            Obx(
              () => isOriginSection
                  ? numberTextField('No.HP Pengirim', noHPPengirimController)
                  : numberTextField('No.HP Penerima', noHPPenerimaController),
            ),
            textField('Detail Barang', detailBarangController, false),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 20 / 7.2,
            ),
          ],
        ),
      ),
    );
  }

  Widget textFieldDestination(String label, TextEditingController controller, bool enableContact) {
    return Obx(
      () => !isOriginSection
          ? Column(
              children: [
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 20 / 7.2,
                ),
                Container(
                  height: SizeConfig.safeBlockVertical * 50 / 7.2,
                  width: double.infinity,
                  child: TextFormField(
                    validator: RequiredValidator(errorText: 'form tidak boleh kosong'),
                    controller: controller,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: enableContact
                          ? IconButton(
                              onPressed: () {
                                Get.to(
                                  () => OkeCourierContactList(
                                    namaPenerimaController: namaPenerimaController,
                                    namaPengirimController: namaPengirimController,
                                    noHPPenerimaController: noHPPenerimaController,
                                    noHPPengirimController: noHPPengirimController,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.contact_phone,
                                color: Colors.grey,
                              ),
                            )
                          : SizedBox(),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: label,
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                      ),
                      contentPadding: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[100]!, width: 0.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[100]!, width: 0.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorStyle: TextStyle(fontSize: 0),
                    ),
                  ),
                ),
              ],
            )
          : SizedBox(),
    );
  }

  Widget textField(String label, TextEditingController controller, bool enableContact) {
    return Obx(
      () => isOriginSection
          ? Column(
              children: [
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 20 / 7.2,
                ),
                Container(
                  height: SizeConfig.safeBlockVertical * 50 / 7.2,
                  width: double.infinity,
                  child: TextFormField(
                    validator: RequiredValidator(errorText: 'form tidak boleh kosong'),
                    controller: controller,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: enableContact
                          ? IconButton(
                              onPressed: () {
                                Get.to(
                                  () => OkeCourierContactList(
                                    namaPenerimaController: namaPenerimaController,
                                    namaPengirimController: namaPengirimController,
                                    noHPPenerimaController: noHPPenerimaController,
                                    noHPPengirimController: noHPPengirimController,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.contact_phone,
                                color: Colors.grey,
                              ),
                            )
                          : SizedBox(),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: label,
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                      ),
                      contentPadding: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[100]!, width: 0.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[100]!, width: 0.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[100]!, width: 0.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorStyle: TextStyle(fontSize: 0),
                    ),
                  ),
                ),
              ],
            )
          : SizedBox(),
    );
  }

  Widget numberTextField(String label, TextEditingController controller) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.safeBlockVertical * 20 / 7.2,
        ),
        Container(
          height: SizeConfig.safeBlockVertical * 50 / 7.2,
          width: double.infinity,
          child: TextFormField(
            validator: RequiredValidator(errorText: 'form tidak boleh kosong'),
            controller: controller,
            style: TextStyle(
              color: Colors.black45,
              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
              hintText: label,
              hintStyle: TextStyle(
                color: Colors.black45,
                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[100]!),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[100]!, width: 0.0),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[100]!, width: 0.0),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
              errorStyle: TextStyle(fontSize: 0),
            ),
          ),
        ),
      ],
    );
  }

  void validate() async {
    if (formKey.currentState!.validate()) {
      pc.close();
      if (isOriginSection) {
        await Future.delayed(Duration(seconds: 2), () {
          okeCourierController.isOriginSection.value = false;
        });
      } else {
        await Future.delayed(Duration(seconds: 2), () {
          okeCourierController.showSummary.value = true;
        });
      }
      pc.open();
    }
  }

  Future<dynamic> showOriginModal() {
    return showMaterialModalBottomSheet(
      context: Get.context!,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Container(
            padding: EdgeInsets.all(20),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: Column(
                children: [
                  OkeCourierLocationSearch(
                    isOriginSection: isOriginSection,
                    formKey: formKey,
                    pc: pc,
                  ),
                  OriginSearchResultModal(completerController: mapcontroller),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
