import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okecourier/okecourier_contact_controller.dart';
import 'package:okejek_flutter/controller/auth/okecourier/okecourier_contact_detail.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class OkeCourierContactList extends StatelessWidget {
  final OkeCourierContactController okeCourierContactList = Get.put(OkeCourierContactController());
  final TextEditingController namaPengirimController;
  final TextEditingController noHPPengirimController;
  final TextEditingController namaPenerimaController;
  final TextEditingController noHPPenerimaController;

  OkeCourierContactList({
    required this.namaPenerimaController,
    required this.namaPengirimController,
    required this.noHPPenerimaController,
    required this.noHPPengirimController,
  });

  final List<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pilih Kontak',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => okeCourierContactList.isLoading.value
                  ? loading()
                  : Container(
                      padding: EdgeInsets.all(10),
                      width: Get.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: okeCourierContactList.contactList.length,
                        itemBuilder: (context, index) {
                          for (var i = 0; i < okeCourierContactList.contactList.length; i++) {
                            contacts.add(okeCourierContactList.contactList[i]);
                          }

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  print(contacts[index].phones!.length);
                                  if (contacts[index].phones!.length > 1) {
                                    Get.to(
                                      () => OkeCourierContactDetail(
                                        contact: contacts[index],
                                        namaPenerimaController: namaPenerimaController,
                                        namaPengirimController: namaPengirimController,
                                        noHPPenerimaController: noHPPenerimaController,
                                        noHPPengirimController: noHPPengirimController,
                                      ),
                                      transition: Transition.cupertino,
                                    );
                                  } else if (contacts[index].phones!.length == 1) {
                                    selectContact(index);
                                  } else if (contacts[index].phones!.length == 0) {
                                    snackbar();
                                  } else {
                                    print('do nothing');
                                  }
                                },
                                child: ListTile(
                                  title: Text(
                                    contacts[index].displayName!,
                                    style: TextStyle(
                                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                    ),
                                  ),
                                  leading: Container(
                                    height: SizeConfig.safeBlockVertical * 30 / 7.2,
                                    width: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loading() {
    return Container(
      height: Get.height * 0.9,
      width: Get.width,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void snackbar() {
    final snackBar = SnackBar(
      content: Text(
        'No.HP kontak tidak ditemukan',
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
        ),
      ),
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  void selectContact(int index) {
    okeCourierContactList.selectedName.value = contacts[index].displayName!;
    okeCourierContactList.selectedNumber.value = contacts[index].phones![0].value!;
    okeCourierContactList.selectContact(
      namaPengirimController,
      noHPPengirimController,
      namaPenerimaController,
      noHPPenerimaController,
    );
    Get.back();
  }
}
