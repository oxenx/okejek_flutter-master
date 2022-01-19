import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:okejek_flutter/controller/auth/okeshop/okeshop_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class ModalStackShopping extends StatelessWidget {
  final formkey;
  final namaController;
  final detailController;
  final jumlahController;
  final estimasiController;
  ModalStackShopping({
    required this.formkey,
    required this.namaController,
    required this.jumlahController,
    required this.detailController,
    required this.estimasiController,
  });

  @override
  Widget build(BuildContext context) {
    OkeShopController controller = Get.find();
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              controller: ModalScrollController.of(context),
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  SizeConfig.safeBlockHorizontal * 11.11,
                  SizeConfig.safeBlockHorizontal * 5.56,
                  SizeConfig.safeBlockHorizontal * 11.11,
                  SizeConfig.safeBlockHorizontal * 5.56,
                ),
                height: Get.height * 1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(SizeConfig.safeBlockHorizontal * 5.56),
                    topRight: Radius.circular(SizeConfig.safeBlockHorizontal * 5.56),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Tambah Belanja',
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4.4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 8.3),
                    Text(
                      'Nama Barang',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.safeBlockHorizontal * 2.78,
                      ),
                    ),
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 2.78),
                    textField(namaController),
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 8.3),
                    Text(
                      'Detail Barang',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.safeBlockHorizontal * 2.78,
                      ),
                    ),
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 2.78),
                    textField(detailController),
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 8.3),
                    Text(
                      'Jumlah Barang',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.safeBlockHorizontal * 2.78,
                      ),
                    ),
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 2.78),
                    numberTextField(jumlahController),
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 8.3),
                    Text(
                      'Estimasi Harga',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.safeBlockHorizontal * 2.78,
                      ),
                    ),
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 2.78),
                    numberTextField(estimasiController),
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 13.89),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 8.3),
                      child: ElevatedButton(
                        onPressed: () {
                          validate(context, controller);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: OkejekTheme.primary_color,
                          padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockHorizontal * 3.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 6.94),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Tambah Belanja',
                            style: TextStyle(color: Colors.white, fontSize: SizeConfig.safeBlockHorizontal * 3.3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: SizeConfig.safeBlockHorizontal * 13.89,
          left: SizeConfig.safeBlockHorizontal * 2.78,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close,
              color: Colors.black87,
            ),
          ),
        )
      ],
    );
  }

  Widget textField(controller) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 2.78),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field tidak boleh kosong';
          }
        },
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 2.78),
          ),
          contentPadding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5.56),
          filled: true,
          fillColor: Colors.grey[200],
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.black54,
          fontSize: SizeConfig.safeBlockHorizontal * 3.3,
        ),
      ),
    );
  }

  Widget numberTextField(controller) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 2.78),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field tidak boleh kosong';
          }
        },
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 2.78),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5.56),
        ),
        style: TextStyle(
          color: Colors.black54,
          fontSize: SizeConfig.safeBlockHorizontal * 3.3,
        ),
      ),
    );
  }

  void validate(BuildContext context, OkeShopController controller) {
    if (formkey.currentState!.validate()) {
      int parsedHarga = int.parse(estimasiController.text);
      int parsedJumlah = int.parse(jumlahController.text);
      var mapData = {
        'nama_barang': namaController.text,
        'deskripsi': detailController.text,
        'harga': parsedHarga,
        'jumlah': parsedJumlah,
      };

      // add item to controller
      controller.addItem(mapData, parsedHarga, parsedJumlah);

      // pop modal
      Navigator.pop(context);
      showToast(context, 'Barang telah ditambahkan');

      // reset textfield controller
      namaController.clear();
      detailController.clear();
      jumlahController.clear();
      estimasiController.clear();
    }
  }

  void showToast(context, String text) async {
    await showTextToast(
      margin: EdgeInsets.only(bottom: SizeConfig.safeBlockHorizontal * 22.22),
      text: text,
      style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3.3),
      context: context,
    );
  }
}
