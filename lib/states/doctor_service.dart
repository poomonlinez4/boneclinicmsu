import 'dart:convert';

import 'package:boneclinicmsu/bodys/home_chat.dart';
import 'package:boneclinicmsu/bodys/my_order_customer.dart';
import 'package:boneclinicmsu/bodys/show_all_shop_customer.dart';
import 'package:boneclinicmsu/bodys/tabbarPage/show_list_buyCourse.dart';
import 'package:boneclinicmsu/bodys/show_table_doctor.dart';
import 'package:boneclinicmsu/models/user_model.dart';
import 'package:boneclinicmsu/states/show_course_customer.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/unility/my_dialod.dart';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_signout.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorService extends StatefulWidget {
  const DoctorService({Key? key}) : super(key: key);

  @override
  State<DoctorService> createState() => _DoctorServiceState();
}

class _DoctorServiceState extends State<DoctorService> {
  List<Widget> widgets = [ShowListBuyCourse(), ShowTableDoctor(), HomeChat()];

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
        title: Text('Bone Clinic (Doctor) '),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                buildHeader(),
                menuShowListBuyCourse(),
                menuTableDoctor(),
                menuChatDoctor()
              ],
            ),
            ShowSignOut(),
          ],
        ),
      ),
      body: widgets[indexWidget],
    );
  }

  ListTile menuShowListBuyCourse() {
    return ListTile(
      leading:
          Icon(Icons.shopping_bag_outlined, size: 36, color: MyConstant.dark),
      title: ShowTitle(
        title: 'รายชื่อคนจองคอร์ส',
        textStyle: MyConstant().h2style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายการจองคอร์ส ทั้งหมด',
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

  ListTile menuTableDoctor() {
    return ListTile(
      leading:
          Icon(Icons.library_books_rounded, size: 36, color: MyConstant.dark),
      title: ShowTitle(
        title: 'จัดการตารางเวลา',
        textStyle: MyConstant().h2style(),
      ),
      subtitle: ShowTitle(
        title: 'ตารางเวลาทำงานของเเพทย์ ',
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

  ListTile menuChatDoctor() {
    return ListTile(
      leading: Icon(Icons.chat, size: 36, color: MyConstant.dark),
      title: ShowTitle(
        title: 'Chat',
        textStyle: MyConstant().h2style(),
      ),
      subtitle: ShowTitle(
        title: 'chat ',
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
