import 'package:flutter/material.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/pages/auth/news/coming_soon_page.dart';
import 'package:okejek_flutter/pages/auth/news/news_page.dart';

class TabbarNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: Colors.white,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(child: Container()),
                    TabBar(
                      indicatorColor: OkejekTheme.primary_color,
                      tabs: [
                        Tab(
                          text: "Berita",
                        ),
                        Tab(
                          text: "Notifikasi",
                        ),
                        Tab(
                          text: "Promo",
                        ),
                      ],
                      labelColor: Colors.black,
                      // add it here
                      indicator: MaterialIndicator(
                        color: Colors.black,
                        horizontalPadding: SizeConfig.safeBlockHorizontal * 50 / 3.6,
                        // distanceFromCenter: 16,
                        // radius: 3,
                        paintingStyle: PaintingStyle.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              NewsPage(),
              ComingSoonPage(
                icon: Icons.notifications,
              ),
              ComingSoonPage(
                icon: Icons.local_offer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
