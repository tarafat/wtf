import 'package:flutter/material.dart';
import 'package:peandpr/model/coupon.dart';

import 'screen/coupon_screen.dart';
import 'screen/navigation_screen.dart';
import 'screen/redeem_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NavigatorScreen(0),
    );
  }
}
