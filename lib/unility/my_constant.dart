import 'package:flutter/material.dart';

class MyConstant {
  // Genernal
  static String appName = 'Bone Clinic';
  static String domain = 'https://4985-183-88-156-13.ap.ngrok.io';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeCoustomerService = '/customerService';
  static String routeDoctorService = '/doctorService';
  static String routeAdminService = '/adminService';
  static String routeAddProduct = '/addProduct';

  // Image
  static String image1 = 'images/image (1).png';
  static String image2 = 'images/image (2).png';
  static String image3 = 'images/image (3).png';
  static String image4 = 'images/image (4).png';
  static String image5 = 'images/image (5).png';
  static String image6 = 'images/image (6).png';
  static String image7 = 'images/image (7).png';
  static String image8 = 'images/image (8).png';
  static String image9 = 'images/image 9.png';
  static String avatar = 'images/avatar.png';

  //Color
  static Color primary = Color(0xffef9a9a);
  static Color dark = Color(0xffba6b6c);
  static Color light = Color(0xffffcccb);
  static Map<int, Color> mapMaterialColor = {
    50: Color.fromRGBO(186, 107, 108, 0.1),
    100: Color.fromRGBO(186, 107, 108, 0.2),
    200: Color.fromRGBO(186, 107, 108, 0.3),
    300: Color.fromRGBO(186, 107, 108, 0.4),
    400: Color.fromRGBO(186, 107, 108, 0.5),
    500: Color.fromRGBO(186, 107, 108, 0.6),
    600: Color.fromRGBO(186, 107, 108, 0.7),
    700: Color.fromRGBO(186, 107, 108, 0.8),
    800: Color.fromRGBO(186, 107, 108, 0.9),
    900: Color.fromRGBO(186, 107, 108, 1.0),
  };

  // Style
  TextStyle h1style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );
  TextStyle h2style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h2Whitestyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3Whitestyle() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      );

  ButtonStyle myButtonStyle2() => ElevatedButton.styleFrom(
        primary: MyConstant.dark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      );
}
