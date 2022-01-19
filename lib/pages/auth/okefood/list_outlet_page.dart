import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okefood/okefood_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_model.dart';

class OkeFoodListOutletPage extends StatelessWidget {
  final OkeFoodController okeFoodController = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: SizeConfig.safeBlockVertical * 80 / 7.2,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Container(
          margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
          height: SizeConfig.safeBlockVertical * 50 / 7.2,
          width: double.infinity,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              fillColor: Colors.grey[100],
              filled: true,
              hintText: 'Cari menu atau resto..',
              hintStyle: TextStyle(
                color: Colors.black54,
                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                fontStyle: FontStyle.italic,
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<FoodVendor>>(
        future: okeFoodController.getFoodVendor(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height,
              width: Get.width,
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFE0675C),
                ),
              ),
            );
          } else {
            List<FoodVendor> listFoodVendor = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: listFoodVendor.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  height: SizeConfig.safeBlockVertical * 130 / 7.2,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        height: SizeConfig.safeBlockVertical * 100 / 7.2,
                        width: SizeConfig.safeBlockHorizontal * 120 / 3.6,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 5 / 7.2,
                          ),
                          //title
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(top: 15, left: 10),
                              width: SizeConfig.safeBlockHorizontal * 180 / 3.6,
                              child: Text(
                                listFoodVendor[index].name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 5 / 7.2,
                          ),

                          // address
                          Container(
                            margin: EdgeInsets.only(top: 0, left: 10),
                            height: SizeConfig.safeBlockVertical * 20 / 7.2,
                            width: SizeConfig.safeBlockHorizontal * 180 / 3.6,
                            child: Text(
                              listFoodVendor[index].address,
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          // rate
                          Container(
                            margin: EdgeInsets.only(top: 5, left: 10),
                            height: SizeConfig.safeBlockVertical * 40 / 7.2,
                            width: SizeConfig.safeBlockHorizontal * 180 / 3.6,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rate,
                                      color: Colors.grey,
                                      size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                                    ),
                                    Text(
                                      '4.0',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '0.8 km',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
