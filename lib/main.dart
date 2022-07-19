import 'dart:io';

import 'package:boneclinicmsu/states/admin_service.dart';
import 'package:boneclinicmsu/states/authen.dart';
import 'package:boneclinicmsu/states/create_account.dart';
import 'package:boneclinicmsu/states/customer_service.dart';
import 'package:boneclinicmsu/states/doctor_service.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/customerService': (BuildContext context) => CustomerService(),
  '/doctorService': (BuildContext context) => DoctorService(),
  '/adminService': (BuildContext context) => AdminService(),
};

String? initlalRoute;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  //******* แบ่งตาม type
  //SharedPreferences บันทึก something ลงในเครื่องง
  String? type = preferences.getString('type');
  print('### type ===>> $type');
  if (type?.isEmpty ?? true) {
    initlalRoute = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    switch (type) {
      case 'customer':
        initlalRoute = MyConstant.routeCoustomerService;
        runApp(MyApp());
        break;
      default:
    }
  }
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
    HttpOverrides.global = MyHttpOverrides();
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoute,
    );
  }
}
