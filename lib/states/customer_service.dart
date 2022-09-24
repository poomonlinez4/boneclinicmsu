import 'dart:convert';

import 'package:boneclinicmsu/bodys/my_money_customer.dart';
import 'package:boneclinicmsu/bodys/my_order_customer.dart';
import 'package:boneclinicmsu/bodys/show_all_shop_customer.dart';
import 'package:boneclinicmsu/models/user_model.dart';
import 'package:boneclinicmsu/states/add_wallet.dart';
import 'package:boneclinicmsu/states/show_course_customer.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/unility/my_dialod.dart';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_progress.dart';
import 'package:boneclinicmsu/widgets/show_signout.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerService extends StatefulWidget {
  const CustomerService({Key? key}) : super(key: key);

  @override
  State<CustomerService> createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  List<Widget> widgets = [
    ShowAllShopCustomer(),
    ShowCourse(),
    MyMoneyCustomer(),
    AddWallet(),
    MyOrderCustomer(),
  ];

  int indexWidget = 0;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    findUserLogin();
  }

  Future<void> findUserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var idUserLogin = preferences.getString('id');
    var urlAPI =
        '${MyConstant.domain}/boneclinic/getUserWhereid.php?isAdd=true&members_id=$idUserLogin';
    await Dio().get(urlAPI).then((value) async {
      for (var item in json.decode(value.data)) {
        // print('item ==>> $item');
        setState(() {
          userModel = UserModel.fromMap(item);
          print('### id login ==> ${userModel!.members_id}');
        });
      }

      var path =
          '${MyConstant.domain}/boneclinic/getWalletWhereIdBuyer.php?isAdd=true&idBuyer=${userModel!.members_id}';
      await Dio().get(path).then((value) {
        print('### value getWalletWhereId ==> $value');

        if (value.toString() == 'null') {
          print('#### action Alert add Wallet');
          MyDialog(
            funcAction: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, MyConstant.routeAddWallet);
            },
          ).actionDialog(context, 'No Wallet', 'Please Add Wallet');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bone Clinic ลูกค้า'),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, MyConstant.routeShowCart),
                icon: Icon(Icons.shopping_cart_outlined),
              ),
              IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, MyConstant.routeHomeChat),
                icon: Icon(Icons.chat),
              )
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                buildHeader(),
                menuShowAllProduct(),
                menuShowAllCourse(),
                menuMyMoney(),
                menuAddWallet(),
                menuMyOrder(),
              ],
            ),
            ShowSignOut(),
          ],
        ),
      ),
      body: widgets[indexWidget],
    );
  }

  ListTile menuShowAllProduct() {
    return ListTile(
      leading:
          Icon(Icons.shopping_bag_outlined, size: 36, color: MyConstant.dark),
      title: ShowTitle(
        title: 'Show All Product',
        textStyle: MyConstant().h2style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงสินค้า ทั้งหมด',
        textStyle: MyConstant().h3style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuShowAllCourse() {
    return ListTile(
      leading:
          Icon(Icons.shopping_bag_outlined, size: 36, color: MyConstant.dark),
      title: ShowTitle(
        title: 'Show All course',
        textStyle: MyConstant().h2style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงคอร์ส ทั้งหมด',
        textStyle: MyConstant().h3style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyMoney() {
    return ListTile(
      leading: Icon(Icons.money, size: 36, color: MyConstant.dark),
      title: ShowTitle(
        title: 'My Money',
        textStyle: MyConstant().h2style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงจำนวนเงินที่มี',
        textStyle: MyConstant().h3style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuAddWallet() {
    return ListTile(
      leading: Icon(Icons.wallet_travel, size: 36, color: MyConstant.dark),
      title: ShowTitle(
        title: 'Add Wallet',
        textStyle: MyConstant().h2style(),
      ),
      subtitle: ShowTitle(
        title: 'เติมเงิน กระเป๋าตัง',
        textStyle: MyConstant().h3style(),
      ),
      onTap: () {
        setState(() {
          // indexWidget = 3;
          Navigator.pushNamed(context, MyConstant.routeAddWallet);
        });
      },
    );
  }

  ListTile menuMyOrder() {
    return ListTile(
      leading:
          Icon(Icons.library_books_rounded, size: 36, color: MyConstant.dark),
      title: ShowTitle(
        title: 'MyOrder',
        textStyle: MyConstant().h2style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายการสั่งของ ',
        textStyle: MyConstant().h3style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 4;
          Navigator.pop(context);
        });
      },
    );
  }

  // ListTile menuShowAllProduct() {
  //   return ListTile(
  //     leading:
  //         Icon(Icons.shopping_bag_outlined, size: 36, color: MyConstant.dark),
  //     title: ShowTitle(
  //       title: 'Show All shop',
  //       textStyle: MyConstant().h2style(),
  //     ),
  //     subtitle: ShowTitle(
  //       title: 'แสดงร้านค้า ทั้งหมด',
  //       textStyle: MyConstant().h3style(),
  //     ),
  //     onTap: () {
  //       setState(() {});
  //     },
  //   );
  // }

  UserAccountsDrawerHeader buildHeader() => UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          gradient: RadialGradient(
              radius: 1,
              center: Alignment(-0.65, -1.2),
              colors: [Colors.white, MyConstant.dark])),
      currentAccountPicture: userModel == null
          ? ShowImage(path: MyConstant.image1)
          : userModel!.pic_members.isEmpty
              ? ShowImage(path: MyConstant.image1)
              : CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      '${MyConstant.domain}${userModel!.pic_members}'),
                ),
      accountName: ShowTitle(
        title: userModel == null ? '' : userModel!.name,
        textStyle: MyConstant().h2Whitestyle(),
      ),
      accountEmail: null);
}
