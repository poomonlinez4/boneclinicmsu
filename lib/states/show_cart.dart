import 'dart:convert';

import 'package:boneclinicmsu/models/sqlite_model.dart';
import 'package:boneclinicmsu/models/user_model.dart';
import 'package:boneclinicmsu/models/wallet_model.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/unility/my_dialod.dart';
import 'package:boneclinicmsu/unility/sqlite_helper.dart';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_no_data.dart';
import 'package:boneclinicmsu/widgets/show_progress.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowCart extends StatefulWidget {
  const ShowCart({Key? key}) : super(key: key);

  @override
  State<ShowCart> createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<SQLiteModel> sqliteModels = [];
  bool load = true;
  double? total = 0;
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processReadSQLite();
  }

  Future<Null> processReadSQLite() async {
    if (sqliteModels.isNotEmpty) {
      sqliteModels.clear();
    }

    await SQLiteHelper().readSQLite().then((value) {
      print('### value on processReadSQLite ==>> $value');
      setState(() {
        load = false;
        sqliteModels = value;
        calculateTotal();
      });
    });
  }

  void calculateTotal() async {
    total = 0;
    for (var item in sqliteModels) {
      double sumInt = double.parse(item.sum.trim());
      setState(() {
        total = total! + sumInt;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Cart'),
      ),
      body: load
          ? showProgress()
          : sqliteModels.isEmpty
              ? Container(
                  // decoration: MyConstant().gradintLinearBackground(),
                  child: ShowNoData(
                    title: 'ไม่มี รายการสั่งซื้อสินค้า',
                    pathImage: MyConstant.image4,
                  ),
                )
              : buildContent(),
    );
  }

  Container buildContent() {
    return Container(
      //   decoration: MyConstant().gradintLinearBackground(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ShowTitle(
                title: 'รายการสั่งซื้อทั้งหมด',
                textStyle: MyConstant().h1style()),
          ),
          buildHead(),
          listProduct(),
          buildDivider(),
          buildTotal(),
          buildDivider(),
          buttonController()
        ],
      ),
    );
  }

  Future<void> confirmEmptyCart() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image8),
          title: ShowTitle(
              title: 'คุณต้องการจะ ลบ ?', textStyle: MyConstant().h2style()),
          subtitle: ShowTitle(
              title: 'สินค้า ทั้งหมด ใน ตะกร้า',
              textStyle: MyConstant().h3style()),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await SQLiteHelper().emptySQLite().then((value) {
                Navigator.pop(context);
                processReadSQLite();
              });
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Row buttonController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () async {
            MyDialog().showProgressDialog(context);

            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            String idBuyer = preferences.getString('id')!;

            var path =
                '${MyConstant.domain}/boneclinic/getWalletWhereIdBuyer.php?isAdd=true&idBuyer=$idBuyer';
            await Dio().get(path).then((value) {
              Navigator.pop(context);
              print('#### $value');
              if (value.toString() == 'null') {
                print('#### action Alert add Wallet');
                MyDialog(
                  funcAction: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, MyConstant.routeAddWallet);
                  },
                ).actionDialog(context, 'No Wallet', 'Please Add Wallet');
              } else {
                print('### check Wallet can Payment');

                double approveWallet = 0;

                for (var item in json.decode(value.data)) {
                  WalletModel walletModel = WalletModel.fromMap(item);
                  if (walletModel.status == 'Approve') {
                    approveWallet =
                        approveWallet + double.parse(walletModel.money.trim());
                  }
                }
                print('#12feb approveWallet ==> $approveWallet');
                if (approveWallet - total! >= 0) {
                  print('#12feb Can Order');
                } else {
                  print('#12feb Cannot Order');
                  MyDialog().normalDialog(context, 'ไม่สามารถซื้อได้ ?',
                      'จำนวนเงินที่มีอยู่ : $approveWallet  บาท\nจำนวนงินที่ต้องจ่าย: \n$totalบาท');
                }
              }
            });
          },
          child: Text('ชำระเงิน'),
        ),
        Container(
          margin: EdgeInsets.only(left: 4, right: 8),
          child: ElevatedButton(
            onPressed: () => confirmEmptyCart(),
            child: Text('ลบสินค้าทั้งหมด'),
          ),
        ),
      ],
    );
  }

  Row buildTotal() {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShowTitle(
                title: 'Total :',
                textStyle: MyConstant().h2BlueStyle(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTitle(
                title: total == null ? '' : total.toString(),
                textStyle: MyConstant().h2BlueStyle(),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }

  Divider buildDivider() {
    return Divider(
      color: MyConstant.dark,
    );
  }

  ListView listProduct() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: sqliteModels.length,
      itemBuilder: (context, index) => Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ShowTitle(
                title: sqliteModels[index].name,
                textStyle: MyConstant().h3style(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(
              title: sqliteModels[index].price,
              textStyle: MyConstant().h3style(),
            ),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(
              title: sqliteModels[index].amount,
              textStyle: MyConstant().h3style(),
            ),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(
              title: sqliteModels[index].sum,
              textStyle: MyConstant().h3style(),
            ),
          ),
          Expanded(
            child: IconButton(
                onPressed: () async {
                  int idSQLite = sqliteModels[index].id!;
                  print('### Delete idSQLite ==>> $idSQLite');
                  await SQLiteHelper()
                      .deleteSQLiteWhereId(idSQLite)
                      .then((value) => processReadSQLite());
                },
                icon: Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red.shade700,
                )),
          ),
        ],
      ),
    );
  }

  Container buildHead() {
    return Container(
      decoration: BoxDecoration(color: MyConstant.light),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ShowTitle(
                  title: 'Product',
                  textStyle: MyConstant().h2style(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'Price',
                textStyle: MyConstant().h2style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'Amt ',
                textStyle: MyConstant().h2style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'Sum',
                textStyle: MyConstant().h2style(),
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
