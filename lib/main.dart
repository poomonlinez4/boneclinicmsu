import 'dart:io';

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
  '/customerService': (BuildContext context) => CustomerService(),
  '/doctorService': (BuildContext context) => DoctorService(),
  '/adminService': (BuildContext context) => AdminService(),
};

String? initlalRoute;

void main() {
  initlalRoute = MyConstant.routeAuthen;
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
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
