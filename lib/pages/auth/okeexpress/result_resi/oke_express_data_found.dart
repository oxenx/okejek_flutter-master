import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:timelines/timelines.dart';

class OkeExpressDataFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: OkejekTheme.primary_color,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Track Order',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 20 / 3.6),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Pemesanan Kurir : ',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    ),
                  ),
                  Text(
                    '9048',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 10 / 7.2,
              ),
              Row(
                children: [
                  Text(
                    'AWB : ',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    ),
                  ),
                  Text(
                    'YKEY112100005',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 30 / 7.2,
              ),
              FixedTimeline.tileBuilder(
                builder: TimelineTileBuilder.connected(
                  itemCount: 6,
                  nodePositionBuilder: (context, index) => 0.0,

                  connectorBuilder: (context, index, type) {
                    return SizedBox(
                      height: SizeConfig.safeBlockVertical * 95 / 7.2,
                      child: DashedLineConnector(
                        color: Colors.grey[300],
                        indent: SizeConfig.safeBlockVertical * 10 / 7.2,
                        endIndent: SizeConfig.safeBlockVertical * 2 / 7.2,
                      ),
                    );
                  },
                  indicatorPositionBuilder: (context, index) {
                    return 0;
                  },

                  contentsBuilder: (context, index) {
                    return Container(
                      // color: Colors.blue[100],
                      height: SizeConfig.safeBlockVertical * 110 / 7.2,
                      margin: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 8 / 3.6,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '10 November 2021',
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 11 / 3.6,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                '10.00',
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 11 / 3.6,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 10 / 7.2,
                          ),
                          Container(
                            height: SizeConfig.safeBlockVertical * 50 / 7.2,
                            width: Get.width,
                            padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 10 / 7.2),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Pesanan Status sedang dilaksanakan',
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },

                  // icon location
                  indicatorBuilder: (context, index) {
                    return DotIndicator(
                      color: Colors.grey,
                      size: SizeConfig.safeBlockVertical * 10 / 7.2,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
