import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'coupon_screen.dart';
import 'redeem_screen.dart';

class NavigatorScreen extends StatefulWidget {
  int _pageNo;
  GlobalKey<_NavigatorState> globalKey = GlobalKey<_NavigatorState>();

  NavigatorScreen(this._pageNo, {Key? key}) : super(key: key);
  static const routeName = "/navigatorScreen";
  @override
  _NavigatorState createState() => _NavigatorState();
}

class _NavigatorState extends State<NavigatorScreen> {
  @override
  Widget build(BuildContext context) {
    var page;
    final _screens = [
      CouponScreen(
        key: widget.globalKey,
      ),
      RedeemScreen(
        key: widget.globalKey,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        body: _screens[widget._pageNo],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          height: 45,
          animationDuration: const Duration(milliseconds: 300),
          index: 0,
          items: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.auto_fix_high_rounded, size: 20),
                Text(
                  'Coupon',
                  style: TextStyle(
                      fontSize: 8, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_bag_outlined, size: 20),
                Text(
                  'Redeem',
                  style: TextStyle(
                      fontSize: 8, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ],
          onTap: (index) {
            setState(() {
              widget._pageNo = index;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
