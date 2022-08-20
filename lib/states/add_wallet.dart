import 'package:boneclinicmsu/bodys/bank.dart';
import 'package:boneclinicmsu/bodys/credic.dart';
import 'package:boneclinicmsu/bodys/prompay.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:flutter/material.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({Key? key}) : super(key: key);

  @override
  State<AddWallet> createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  List<Widget> widgets = [Bank(), Prompay(), Credic()];
  List<IconData> icons = [Icons.money, Icons.book, Icons.credit_card];
  List<String> titles = ['Bank', 'Prompay', 'Credic'];

  int indexPosition = 0;

  List<BottomNavigationBarItem> bottomNavigationBarItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    int i = 0;
    for (var item in titles) {
      bottomNavigationBarItems
          .add(createBottomNavigationBarItem(icons[i], item));
      i++;
    }
  }

  BottomNavigationBarItem createBottomNavigationBarItem(
          IconData iconData, String string) =>
      BottomNavigationBarItem(
        icon: Icon(iconData),
        label: string,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ชำระเงินโดยใช้ ${titles[indexPosition]}')),
      body: widgets[indexPosition],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: MyConstant.dark),
        unselectedItemColor: MyConstant.primary,
        items: bottomNavigationBarItems,
        currentIndex: indexPosition,
        onTap: (value) {
          setState(() {
            indexPosition = value;
          });
        },
      ),
    );
  }
}
