import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okecourier/okecourier_contact_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class OkeCourierContactDetail extends StatelessWidget {
  final Contact contact;
  final TextEditingController namaPengirimController;
  final TextEditingController noHPPengirimController;
  final TextEditingController namaPenerimaController;
  final TextEditingController noHPPenerimaController;

  OkeCourierContactDetail({
    required this.contact,
    required this.namaPenerimaController,
    required this.namaPengirimController,
    required this.noHPPenerimaController,
    required this.noHPPengirimController,
  });

  final OkeCourierContactController okeCourierContactList = Get.put(OkeCourierContactController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          contact.displayName!,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
            resetValue();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pilih nomor:',
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: contact.phones!.length,
                        itemBuilder: (context, index) {
                          String phoneNumber = contact.phones![index].value!;
                          String contactName = contact.displayName!;
                          return GestureDetector(
                            onTap: () {
                              selectContact(index, phoneNumber, contactName);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.safeBlockVertical * 10 / 7.2,
                                horizontal: SizeConfig.safeBlockHorizontal * 5 / 3.6,
                              ),
                              width: Get.width,
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                              ),
                              height: SizeConfig.safeBlockVertical * 60 / 7.2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 7,
                                        child: Text(
                                          contact.phones![index].value.toString(),
                                          style: TextStyle(
                                            fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => Flexible(
                                          flex: 3,
                                          child: okeCourierContactList.selectedNumber.value == phoneNumber
                                              ? Container(
                                                  width: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                                                  height: SizeConfig.safeBlockVertical * 20 / 7.2,
                                                  decoration: BoxDecoration(
                                                    color: OkejekTheme.primary_color,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                      size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                                                  height: SizeConfig.safeBlockVertical * 20 / 7.2,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.grey[400]!,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => AnimatedPositioned(
                curve: Curves.easeInOut,
                bottom: okeCourierContactList.selectedNumber.value.isNotEmpty
                    ? SizeConfig.safeBlockVertical * 10 / 7.2
                    : -SizeConfig.safeBlockVertical * 100 / 7.2,
                right: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                left: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                duration: Duration(milliseconds: 500),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: OkejekTheme.primary_color,
                    minimumSize: Size(Get.width * 0.9, SizeConfig.blockSizeVertical * 50 / 7.2),
                  ),
                  onPressed: () {
                    print('pilih nomor');
                    okeCourierContactList.selectContact(
                      namaPengirimController,
                      noHPPengirimController,
                      namaPenerimaController,
                      noHPPenerimaController,
                    );
                    Get.back();
                    Get.back();
                  },
                  child: Text(
                    'Pilih nomor',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectContact(int index, String phoneNumber, String contactName) {
    bool isNumberEmpty = okeCourierContactList.selectedNumber.value == '';
    bool isOtherNumberSelected = okeCourierContactList.selectedNumber.value != phoneNumber;

    if (isNumberEmpty || isOtherNumberSelected) {
      okeCourierContactList.selectedNumber.value = phoneNumber;
      okeCourierContactList.selectedName.value = contactName;
    } else {
      resetValue();
    }
  }

  void resetValue() {
    okeCourierContactList.selectedNumber.value = '';
    okeCourierContactList.selectedName.value = '';
  }
}
