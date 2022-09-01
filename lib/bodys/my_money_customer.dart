import 'package:boneclinicmsu/bodys/approve.dart';
import 'package:boneclinicmsu/bodys/wait.dart';
import 'package:boneclinicmsu/bodys/wallet.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:flutter/material.dart';

class MyMoneyCustomer extends StatefulWidget {
  const MyMoneyCustomer({Key? key}) : super(key: key);

  @override
  State<MyMoneyCustomer> createState() => _MyMoneyCustomerState();
}

class _MyMoneyCustomerState extends State<MyMoneyCustomer> {
  int indexWidget = 0;
  var widgets = <Widget>[
    Wallet(),
    Approve(),
    Wait(),
  ];

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpBottonBar();
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
      body: widgets[indexWidget],
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
