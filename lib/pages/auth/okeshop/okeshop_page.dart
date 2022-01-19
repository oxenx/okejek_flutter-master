import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:okejek_flutter/controller/auth/okeshop/detail_order_controller.dart';
import 'package:okejek_flutter/controller/auth/okeshop/okeshop_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/pages/auth/okeshop/detail_order_shop_page.dart';
import 'package:okejek_flutter/widgets/shopping/empty_cart_shopping.dart';
import 'package:okejek_flutter/widgets/shopping/list_item_shopping.dart';
import 'package:okejek_flutter/widgets/shopping/modal_shopping.dart';

class OkeShopPage extends StatelessWidget {
  final RequiredValidator requiredValidator = RequiredValidator(errorText: 'Field tidak boleh kosong');
  final TextEditingController namaController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController estimasiController = TextEditingController();
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    OkeShopController controller = Get.put(OkeShopController());
    DetailOrderShopController detailShopController = Get.put(DetailOrderShopController());
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'OkeShop',
          style: TextStyle(
            fontFamily: OkejekTheme.font_family,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: SizeConfig.safeBlockHorizontal * 11.11,
            width: SizeConfig.safeBlockHorizontal * 11.11,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back,
                color: OkejekTheme.primary_color,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5.56),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Obx(
                    () => controller.dummyData.length == 0 ? EmptyCartShopping() : ListItemShopping(),
                  ),
                ),
              ),
            ),

            // floatin button
            Positioned(
              left: SizeConfig.safeBlockHorizontal * 27.78,
              right: SizeConfig.safeBlockHorizontal * 27.78,
              bottom: SizeConfig.safeBlockHorizontal * 27.78,
              child: ElevatedButton(
                onPressed: () {
                  showModal(controller, context);
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

            // total Belanja
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  detailShopController.resetController();
                  Get.to(() => DetailOrderShopPage(), transition: Transition.rightToLeft);
                },
                child: Container(
                  height: Get.height * 0.07,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: OkejekTheme.primary_color,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 5.56),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () {
                            // dummy total
                            String totalFormatted = currencyFormatter.format(controller.total.value);

                            return Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Total Belanja :',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: SizeConfig.safeBlockHorizontal * 2.78,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        softWrap: true,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        totalFormatted,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeConfig.safeBlockHorizontal * 3.89,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        softWrap: true,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Lihat Keranjang',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    softWrap: true,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
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

  Future<dynamic> showModal(OkeShopController controller, context) {
    return showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeConfig.safeBlockHorizontal * 5.56),
          topRight: Radius.circular(SizeConfig.safeBlockHorizontal * 5.56),
        ),
      ),
      builder: (context) => ModalStackShopping(
        formkey: formkey,
        detailController: detailController,
        estimasiController: estimasiController,
        jumlahController: jumlahController,
        namaController: namaController,
      ),
    );
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
