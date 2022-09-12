import 'dart:convert';
import 'dart:ffi';

import 'package:boneclinicmsu/bodys/approve.dart';
import 'package:boneclinicmsu/bodys/wait.dart';
import 'package:boneclinicmsu/bodys/wallet.dart';
import 'package:boneclinicmsu/models/wallet_model.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_no_data.dart';
import 'package:boneclinicmsu/widgets/show_progress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMoneyCustomer extends StatefulWidget {
  const MyMoneyCustomer({Key? key}) : super(key: key);

  @override
  State<MyMoneyCustomer> createState() => _MyMoneyCustomerState();
}

class _MyMoneyCustomerState extends State<MyMoneyCustomer> {
  int indexWidget = 0;
  var widgets = <Widget>[];

  var titles = <String>[
    'Wallet',
    'Approve',
    'Wait',
  ];

  var iconDatas = <IconData>[
    Icons.money,
    Icons.fact_check,
    Icons.hourglass_bottom,
  ];

  var bottonNavigationBarItems = <BottomNavigationBarItem>[];

  int approvedWallet = 0, waitApproveWallet = 0;
  bool load = true;
  bool? haveWallet;

  //List<WalletModel> approveWalletModels = [];
  var approveWalletModels = <WalletModel>[];
  var waitWalletModels = <WalletModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllWallet();
    setUpBottonBar();
  }

  Future<void> readAllWallet() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var idBuyer = preferences.getString('id');
    print('id Buyer ==> $idBuyer');

    var path =
        '${MyConstant.domain}/boneclinic/getWalletWhereIdBuyer.php?isAdd=true&idBuyer=$idBuyer';
    await Dio().get(path).then((value) {
      print('###value ==>> $value');

      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          WalletModel model = WalletModel.fromMap(item);
          switch (model.status) {
            case 'Approve':
              approvedWallet = approvedWallet + int.parse(model.money);
              approveWalletModels.add(model);

              break;
            case 'WaitOrder':
              waitApproveWallet = waitApproveWallet + int.parse(model.money);
              waitWalletModels.add(model);
              break;
            default:
          }
        }

        print(
            'approveWallet ==> $approvedWallet , waitApproveWallet = $waitApproveWallet');
        widgets.add(Wallet(
          approveWallet: approvedWallet,
          waitApproveWallet: waitApproveWallet,
        ));
        widgets.add(Approve(
          walletModels: approveWalletModels,
        ));
        widgets.add(Wait(
          walletModels: waitWalletModels,
        ));

        setState(() {
          load = false;
          haveWallet = true;
        });
      } else {
        print('### no Wallet Status');

        setState(() {
          load = false;
          haveWallet = false;
        });
      }
    });
  }

  void setUpBottonBar() {
    int index = 0;
    for (var title in titles) {
      bottonNavigationBarItems.add(
        BottomNavigationBarItem(
          label: title,
          icon: Icon(
            iconDatas[index],
          ),
        ),
      );

      index++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? showProgress()
          : haveWallet!
              ? widgets[indexWidget]
              : ShowNoData(
                  title: 'No Wallet', pathImage: 'images/image (4).png'),
      bottomNavigationBar: BottomNavigationBar(
        //  unselectedItemColor: MyConstant.light,
        selectedItemColor: MyConstant.dark,
        onTap: (value) {
          setState(() {
            indexWidget = value;
          });
        },
        currentIndex: indexWidget,
        items: bottonNavigationBarItems,
      ),
    );
  }
}
