import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okecourier/okecourier_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:permission_handler/permission_handler.dart';

class OkeCourierContactController extends GetxController {
  final OkeCourierController okeCourierController = Get.find();
  bool get isOriginSection => okeCourierController.isOriginSection.value;
  var contactList = [].obs;
  var isLoading = false.obs;
  var isSelectedNumber = false.obs;
  var selectedNumber = ''.obs;
  var selectedName = ''.obs;

  void onInit() {
    super.onInit();
    checkPermission();
  }

  void delete() {
    super.onDelete();
  }

  void selectContact(
    TextEditingController namaPengirimController,
    TextEditingController noHPPengirimController,
    TextEditingController namaPenerimaController,
    TextEditingController noHPPenerimaController,
  ) {
    selectedNumber.value = selectedNumber.value.replaceAll('-', '');
    selectedNumber.value = selectedNumber.value.replaceAll(' ', '');
    if (isOriginSection) {
      namaPengirimController.text = selectedName.value;
      noHPPengirimController.text = selectedNumber.value;
    } else {
      namaPenerimaController.text = selectedName.value;
      noHPPenerimaController.text = selectedNumber.value;
    }
    print(selectedNumber.value);
    print(selectedName.value);
  }

  void checkPermission() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (await Permission.contacts.request().isGranted) {
      print('contact permission granted');
      getContactList();
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(
          content: Text(
        'Akses ke kontak device ditolak',
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
        ),
      ));
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar = SnackBar(
          content: Text(
        'data kontak tidak tersedia',
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
        ),
      ));
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void getContactList() async {
    isLoading.value = true;
    List<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
    contactList.addAll(contacts);

    isLoading.value = false;
  }
}
