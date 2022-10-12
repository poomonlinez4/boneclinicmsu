import 'dart:convert';

import 'package:boneclinicmsu/models/wallet_buyer_model.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wallet extends StatefulWidget {
  final int approveWallet, waitApproveWallet;

  const Wallet(
      {Key? key, required this.approveWallet, required this.waitApproveWallet})
      : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int? approveWallet, waitApproveWallet;
  WalletBuyerModel? walletBuyerModel;
  int? total_moneyBuyer = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.approveWallet = widget.approveWallet;
    this.waitApproveWallet = widget.waitApproveWallet;
    ToTal_moneyBuyer();
  }

  Future<Null> ToTal_moneyBuyer() async {
    //  double total_moneyBuyer = 0;
    total_moneyBuyer = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id_buyer = preferences.getString('id')!;

    String apiGetUser =
        '${MyConstant.domain}/boneclinic/get_MoneyWhereidBuyer.php?isAdd=true&id_buyer=$id_buyer';
    await Dio().get(apiGetUser).then((value) {
      print('value from API ==>> $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          walletBuyerModel = WalletBuyerModel.fromMap(item);
          double sum_moneyBuyer =
              double.parse(walletBuyerModel!.total_money.toString());
          total_moneyBuyer = sum_moneyBuyer.toInt();

          print('total_moneyBuyer==>$total_moneyBuyer');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: MyConstant().planBackgroundLight(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              newListTile(Icons.wallet_giftcard, 'จำนวนเงินที่ใช้ได้',
                  '$total_moneyBuyer THB'),
              newListTile(Icons.wallet_membership, 'จำนวนเงินที่รอการตรวจสอบ',
                  '$waitApproveWallet THB'),
              newListTile(Icons.grading_sharp, 'จำนวนเงินทั้งหมด',
                  '${approveWallet! + waitApproveWallet!} THB'),
            ],
          ),
        ),
      ),
    );
  }

  Widget newListTile(IconData iconData, String title, String subTitle) {
    return Container(
      width: 270,
      child: Card(
        color: Colors.black87,
        // color: MyConstant.primary.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ListTile(
            leading: Icon(
              iconData,
              color: Colors.white,
              size: 48,
            ),
            title: ShowTitle(
              title: title,
              textStyle: MyConstant().h2Whitestyle(),
            ),
            subtitle: ShowTitle(
              title: subTitle,
              textStyle: MyConstant().h1style(),
            ),
          ),
        ),
      ),
    );
  }
}
