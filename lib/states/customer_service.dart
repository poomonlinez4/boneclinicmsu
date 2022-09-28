import 'dart:convert';

import 'package:boneclinicmsu/bodys/my_money_customer.dart';
import 'package:boneclinicmsu/bodys/my_order_customer.dart';
import 'package:boneclinicmsu/bodys/show_all_shop_customer.dart';
import 'package:boneclinicmsu/bodys/show_doctor.dart';
import 'package:boneclinicmsu/bodys/show_profile.dart';
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
    ShowDoctor()
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

          //  widgets.add(ShowProfile(userModel: userModel!));
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
            SingleChildScrollView(
              child: Column(
                children: [
                  buildHeader(),
                  menuShowAllProduct(),
                  menuShowAllCourse(),
                  menuMyMoney(),
                  menuAddWallet(),
                  //   menuMyOrder(),
                  menuShowDoctor(),
                ],
              ),
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
        title: 'สินค้า',
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
        title: 'จองคอร์ส',
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
        title: 'กระเป๋าเงิน ',
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
        title: 'เติมเงิน',
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

  ListTile menuShowDoctor() {
    return ListTile(
      leading:
          Icon(Icons.library_books_rounded, size: 36, color: MyConstant.dark),
      title: ShowTitle(
        title: 'ปรึกษาเพทย์',
        textStyle: MyConstant().h2style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายชื่อหมอ',
        textStyle: MyConstant().h3style(),
      ),
      onTap: () {
        setState(() {
          //   indexWidget = 5;
          Navigator.pushNamed(context, MyConstant.routeDoctor);
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

  Future<Null> refreshUserModel() async {
    print('## refreshUserModel Work');
    String apiGetUserWhereId =
        '${MyConstant.domain}/boneclinic/getUserWhereid.php?isAdd=true&members_id=${userModel!.members_id}';
    await Dio().get(apiGetUserWhereId).then((value) {
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
        });
      }
    });
  }

  UserAccountsDrawerHeader buildHeader() => UserAccountsDrawerHeader(
          otherAccountsPictures: [
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, MyConstant.routeShowProfile)
                      .then((value) => refreshUserModel()),
              icon: Icon(Icons.face_outlined),
              iconSize: 33,
              color: Colors.white,
              tooltip: 'ข้อมูลโปรไฟล์ ',
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(
                      context, MyConstant.routeEditProfileCustomer)
                  .then((value) => refreshUserModel()),
              icon: Icon(Icons.edit_note_outlined),
              iconSize: 36,
              color: Colors.white,
              tooltip: 'เเก้ไขโปรไฟล์ ',
            )
          ],
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
            title: userModel == null
                ? ''
                : '${userModel!.name} ${userModel!.surname}',
            textStyle: MyConstant().h2Whitestyle(),
          ),
          accountEmail: null);
}
