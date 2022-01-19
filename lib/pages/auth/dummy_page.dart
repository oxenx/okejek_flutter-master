import 'package:flutter/material.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';

class Dummypage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OkejekTheme.primary_color,
      ),
      body: Center(
        child: Text('this is a dummy page'),
      ),
    );
  }
}
