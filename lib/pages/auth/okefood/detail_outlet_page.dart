import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/okefood/detail_outlet_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_model.dart';
import 'package:okejek_flutter/pages/auth/okefood/okefood_payment_page.dart';
import 'package:okejek_flutter/widgets/food/custom_sliverappbar.dart';
import 'package:okejek_flutter/widgets/food/outlet_menu_list.dart';

class DetailOutletPage extends StatelessWidget {
  final FoodVendor foodVendor;
  final int type;

  DetailOutletPage({
    required this.foodVendor,
    required this.type,
  });

  final DetailOutletController controller = Get.put(DetailOutletController());

  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<FoodVendor?>(
          future: controller.getDetailOutlet(foodVendor.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              FoodVendor foodVendor = snapshot.data!;

              return Stack(
                children: [
                  CustomScrollView(
                    physics: ClampingScrollPhysics(),
                    slivers: <Widget>[
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: CustomSliverDelegate(
                          foodVendor: foodVendor,
                          expandedHeight: SizeConfig.safeBlockHorizontal * 200 / 3.6,
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Column(
                            children: [
                              OutletMenuList(
                                foodVendor: foodVendor,
                                index: index,
                              ),
                            ],
                          ),
                          childCount: foodVendor.menus.length,
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 80 / 3.6),
                      ),
                    ],
                  ),
                  Obx(
                    () => AnimatedPositioned(
                      bottom: controller.total.value == 0 ? SizeConfig.safeBlockHorizontal * -50 / 3.6 : 0,
                      duration: Duration(milliseconds: 300),
                      child: viewCart(),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget viewCart() {
    return GestureDetector(
      onTap: () => Get.to(
        () => OkeFoodPaymentPage(
          foodVendor: foodVendor,
          type: type,
          totalBelanja: controller.total.value,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: SizeConfig.safeBlockVertical * 6.61,
          width: Get.width,
          decoration: BoxDecoration(
            color: OkejekTheme.primary_color,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 5.56),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  int total = controller.total.value;
                  String totalFormatted = currencyFormatter.format(total);
                  return Flexible(
                    child: Column(
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
                        Entry.all(
                          duration: Duration(milliseconds: 1000),
                          opacity: 0,
                          xOffset: -30,
                          yOffset: 0,
                          scale: 1,
                          child: Text(
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
                        ),
                      ],
                    ),
                  );
                }),
                Text(
                  'Lihat Keranjang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
