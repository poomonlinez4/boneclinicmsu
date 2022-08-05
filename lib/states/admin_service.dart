import 'package:boneclinicmsu/bodys/shop_mange_admin.dart';
import 'package:boneclinicmsu/bodys/show_order_admin.dart';
import 'package:boneclinicmsu/bodys/show_product_admin.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_signout.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:flutter/material.dart';

class AdminService extends StatefulWidget {
  const AdminService({Key? key}) : super(key: key);
  @override
  State<AdminService> createState() => _AdminServiceState();
}

class _AdminServiceState extends State<AdminService> {
  List<Widget> widgets = [
    ShowOrderAdmin(),
    ShopMangeAdmin(),
    ShowProductAdmin(),
  ];
  int indexWidget = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bone Climic (Admin)'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowSignOut(),
            Column(
              children: [
                UserAccountsDrawerHeader(accountName: null, accountEmail: null),
                menuShowOrder(),
                menuShowManage(),
                menuShowProduct()
              ],
            ),
          ],
        ),
      ),
      body: widgets[indexWidget],
    );
  }

  ListTile menuShowOrder() {
    return ListTile(
      onTap: (() {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      }),
      leading: Icon(Icons.filter_1),
      title: ShowTitle(title: 'Show Oder', textStyle: MyConstant().h2style()),
      subtitle: ShowTitle(
          title: 'แสดงรายละเอียด Order ที่สั่ง',
          textStyle: MyConstant().h3Whitestyle()),
    );
  }

  ListTile menuShowManage() {
    return ListTile(
      onTap: (() {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      }),
      leading: Icon(Icons.filter_2),
      title: ShowTitle(title: 'ShopManage', textStyle: MyConstant().h2style()),
      subtitle: ShowTitle(
          title: 'แสดงรายละเอียดของหน้าร้านที่ให้ลูกค้าเห็น',
          textStyle: MyConstant().h3Whitestyle()),
    );
  }

  ListTile menuShowProduct() {
    return ListTile(
      onTap: (() {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      }),
      leading: Icon(Icons.filter_3),
      title:
          ShowTitle(title: 'Show Product', textStyle: MyConstant().h2style()),
      subtitle: ShowTitle(
          title: 'แสดงรายละเอียดของสินค้าที่เราขาย',
          textStyle: MyConstant().h3Whitestyle()),
    );
  }
}
