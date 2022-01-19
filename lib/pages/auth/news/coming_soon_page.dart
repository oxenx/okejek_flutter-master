import 'package:flutter/material.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class ComingSoonPage extends StatelessWidget {
  final IconData icon;
  ComingSoonPage({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: SizeConfig.safeBlockHorizontal * 80 / 3.6,
                color: Colors.grey,
              ),
              SizedBox(
                height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
              ),
              Text(
                'Coming Soon',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
              ),
              Text(
                'Tunggu untuk update selanjutnya',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
