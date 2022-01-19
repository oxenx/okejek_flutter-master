import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/okefood/detail_outlet_controller.dart';
import 'package:okejek_flutter/controller/auth/store/store_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_model.dart';

/// Menampilkan menu yang ada pada sebuah resto
class OutletMenuList extends StatelessWidget {
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);
  final DetailOutletController controller = Get.find();

  final FoodVendor foodVendor;
  final int index;
  final StoreController storeController = Get.find();

  OutletMenuList({
    required this.foodVendor,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Opacity(
          // make the menu to blurry if store is closed
          opacity: storeController.isStoreOpen(foodVendor) ? 1 : 0.5,
          child: Container(
            height: SizeConfig.safeBlockHorizontal * 100 / 3.6,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
            width: Get.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: SizeConfig.blockSizeVertical * 10.58,
                      width: SizeConfig.blockSizeHorizontal * 22.22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2.64,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        foodVendor.menus[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        softWrap: true,
                        maxLines: 1,
                      ),
                      Text(
                        foodVendor.menus[index].description,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        softWrap: true,
                        maxLines: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currencyFormatter.format(foodVendor.menus[index].price),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            softWrap: true,
                            maxLines: 1,
                          ),
                          SizedBox(
                            width: Get.width * 0.1,
                          ),

                          // disappear action button when the store is closed
                          storeController.isStoreOpen(foodVendor)
                              ? Obx(
                                  () {
                                    return controller.cartQtyMap.containsKey(foodVendor.menus[index].id)
                                        ? addRemoveQtyButton(foodVendor.menus[index].id, controller,
                                            foodVendor.menus[index].price, index)
                                        : addToCart(
                                            foodVendor.menus[index].id,
                                            controller,
                                            foodVendor.menus[index].price,
                                            index,
                                          );
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }

  Widget addToCart(int id, DetailOutletController controller, int price, int index) {
    return IconButton(
      onPressed: () {
        controller.addToCart(id, price, foodVendor.menus[index]);
      },
      icon: Entry.all(
        duration: Duration(milliseconds: 300),
        opacity: 0,
        scale: 1,
        yOffset: 0,
        xOffset: SizeConfig.safeBlockHorizontal * 50 / 3.6,
        child: Icon(
          Icons.add_circle_outline,
          color: Colors.green,
          size: SizeConfig.safeBlockHorizontal * 6.94,
        ),
      ),
    );
  }

  Widget addRemoveQtyButton(int id, DetailOutletController controller, int price, int index) {
    return Flexible(
      child: Container(
        width: Get.width * 0.3,
        child: Entry.all(
          duration: Duration(milliseconds: 300),
          opacity: 0,
          scale: 1,
          yOffset: 0,
          xOffset: SizeConfig.safeBlockHorizontal * 50 / 3.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  // check if its value = 1 or not
                  controller.cartQtyMap[id] == 1
                      ? controller.removeFromCart(id, price, foodVendor.menus[index])
                      : controller.subsQtyItem(id, price);
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.green,
                  size: SizeConfig.safeBlockHorizontal * 6.94,
                ),
              ),
              Text(
                controller.cartQtyMap[id].toString(),
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Flexible(
                child: IconButton(
                  onPressed: () {
                    controller.addQtyItem(id, price);
                  },
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.green,
                    size: SizeConfig.safeBlockHorizontal * 6.94,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
