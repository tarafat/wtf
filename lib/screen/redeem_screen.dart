import 'package:flutter/material.dart';
import 'package:peandpr/model/redeem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedeemScreen extends StatefulWidget {
  RedeemScreen({Key? key}) : super(key: key);

  @override
  _RedeemScreenState createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  int walletamt = 0;
  List<Redeem> redeemAblelist = [
    Redeem(1, '100100', false),
    Redeem(1, '100200', false),
    Redeem(1, '100300', false),
    Redeem(1, '100400', false),
    Redeem(1, '100500', false),
  ];
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
  void initState() {
    getWalletPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet Balance: ' + walletamt.toString()),
      ),
      body: Center(
          child: ListView.builder(
              itemCount: redeemAblelist.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.amber[300]),
                  onPressed: () {
                    if (walletamt >= 200) {
                      setState(() {
                        walletamt -= 200;
                        redeemAblelist[index].earned = true;
                        setWalletPref();
                      });
                    } else {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.orange,
                        content: Text('Minimum Redeemable balance is 200'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: redeemAblelist[index].earned
                      ? Text(redeemAblelist[index].code)
                      : const Text('XXXXXXX'),
                );
              })),
    );
  }
}
