import 'package:flutter/material.dart';

class MyConstant {
  // Genernal
  static String appName = 'Bone Clinic';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeCoustomerService = 'customerService';
  static String routeDoctorService = 'doctorService';
  static String routeAdminService = 'adminService';

  // Image
  static String image1 = 'images/image (1).png';
  static String image2 = 'images/image (2).png';
  static String image3 = 'images/image (3).png';
  static String image4 = 'images/image (4).png';
  static String image5 = 'images/image (5).png';
  static String image6 = 'images/image (6).png';
  static String image7 = 'images/image (7).png';
  static String image8 = 'images/image (8).png';

  //Color
  static Color primary = Color(0xffef9a9a);
  static Color dark = Color(0xffba6b6c);
  static Color light = Color(0xffffcccb);

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
  TextStyle h3style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );
}
