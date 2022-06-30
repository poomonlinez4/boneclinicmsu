import 'package:boneclinicmsu/states/admin_service.dart';
import 'package:boneclinicmsu/states/authen.dart';
import 'package:boneclinicmsu/states/create_account.dart';
import 'package:boneclinicmsu/states/customer_service.dart';
import 'package:boneclinicmsu/states/doctor_service.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  'customerService': (BuildContext context) => CustomerService(),
  'doctorService': (BuildContext context) => DoctorService(),
  'adminService': (BuildContext context) => AdminService(),
};

String? initlalRoute;

void main() {
  initlalRoute = MyConstant.routeAuthen;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoute,
    );
  }
}
