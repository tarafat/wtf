import 'package:flutter/material.dart';
import 'package:peandpr/model/coupon.dart';
import 'package:peandpr/utility/db_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int walletamt = 0;
  List<Coupon> couponlist = [];

  @override
  void initState() {
    getAllCoupon();
    getWalletPref();
    super.initState();
  }

  getAllCoupon() async {
    databaseHelper.getAllCoupon().then((value) {
      setState(() {
        couponlist = value;
      });
    });
  }

  Future<void> setWalletPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("userWallet", walletamt);
  }

  getWalletPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userWallet = preferences.getInt('userWallet');
    if (userWallet == null) {
      walletamt = 0;
    } else {
      setState(() {
        walletamt = userWallet;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet Balance : " + walletamt.toString()),
      ),
      body: Center(
        child: couponlist.isNotEmpty
            ? ListView.builder(
                itemCount: couponlist.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      setState(() {
                        walletamt += couponlist[index].amount;
                        setWalletPref();
                        couponlist.removeAt(index);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          color: Colors.green[400],
                          border: Border.all(
                            color: Colors.black,
                            width: .1,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: Text(
                          'Claim Your Point ' +
                              couponlist[index].amount.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Text('No Coupon Available to Claim'),
      ),
    );
  }
}
