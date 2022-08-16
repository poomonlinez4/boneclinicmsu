import 'package:boneclinicmsu/bodys/my_money_customer.dart';
import 'package:boneclinicmsu/bodys/my_order_customer.dart';
import 'package:boneclinicmsu/bodys/show_all_shop_customer.dart';
import 'package:boneclinicmsu/states/show_product_customer.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_signout.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
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
    ShowProductCustomer(),
    MyMoneyCustomer(),
    MyOrderCustomer(),
  ];

  int indexWidget = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bone Clinic ลูกค้า'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                buildHeader(),
                menuShowAllShop(),
                menuShowAllProduct(),
                menuMyMoney(),
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

  ListTile menuShowAllShop() {
    return ListTile(
      leading:
          Icon(Icons.shopping_bag_outlined, size: 36, color: MyConstant.dark),
      title: ShowTitle(
        title: 'Show All shop',
        textStyle: MyConstant().h2style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงร้านค้า ทั้งหมด',
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
          indexWidget = 1;
          Navigator.pop(context);
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
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
    );
  }
  // ListTile menuShowAllShop() {
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

  UserAccountsDrawerHeader buildHeader() =>
      UserAccountsDrawerHeader(accountName: null, accountEmail: null);
}
