// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:boneclinicmsu/models/buycourse_model.dart';
import 'package:boneclinicmsu/models/wallet_buyer_model.dart';
import 'package:boneclinicmsu/unility/my_dialod.dart';
import 'package:intl/intl.dart';
import 'package:boneclinicmsu/models/product_model.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_progress.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/course_model.dart';

class ShowCourse extends StatefulWidget {
  const ShowCourse({Key? key}) : super(key: key);

  @override
  State<ShowCourse> createState() => _ShowCourseState();
}

class _ShowCourseState extends State<ShowCourse> {
  bool load = true;
  bool? haveCourse;
  List<CourseModel> courseModels = [];
  List<List<String>> listImages = [];
  int indexImage = 0;
  TextEditingController dateController = TextEditingController();
  TextEditingController API_dateController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  WalletBuyerModel? walletBuyerModel;

  List<BuyCourseModel> buyCourseModel = [];
  List<BuyCourseModel> Buydate = [];
  double? total_moneyBuyer = 0;
  double? price_cours = 0;
  double? sum_calculate = 0;
  String? choose_time;
  String? API_choose_time;

  bool dense = false;
  String _selection = '';
  final bool selected = false;
  bool evaluate = true;
  int? choose_time02;

  @override
  void initState() {
    super.initState();
    readAPI();
    ToTal_moneyBuyer();
    Show_buycourse();
    dateController.text = "";
  }

  Future<Null> ToTal_moneyBuyer() async {
    total_moneyBuyer = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id_buyer = preferences.getString('id')!;

    String apiGetUser =
        '${MyConstant.domain}/boneclinic/get_MoneyWhereidBuyer.php?isAdd=true&id_buyer=$id_buyer';
    await Dio().get(apiGetUser).then((value) {
      print('value from API ==>> $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          walletBuyerModel = WalletBuyerModel.fromMap(item);
          total_moneyBuyer =
              double.parse(walletBuyerModel!.total_money.toString());
          print('total_moneyBuyer==>$total_moneyBuyer');
        });
      }
    });
  }

  Future<Null> Show_buycourse() async {
    String apibuycourse = '${MyConstant.domain}/boneclinic/getBuyCourse.php';
    await Dio().get(apibuycourse).then((value) {
      print('value from API ==>> $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          buyCourseModel.add(BuyCourseModel.fromMap(item));

          print('buyCourseModel==>$buyCourseModel');

          print(
              'API_dateController==>${API_dateController.text} API_choose_time==>$API_choose_time');
        });
      }
    });
  }

  Row buildDate(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.7,
          child: TextFormField(
            controller: dateController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก วันที่จอง ด้วยค่ะ';
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3style(),
              labelText: 'วันที่จองคอร์ส : ',
              prefixIcon: Icon(
                Icons.date_range,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                String formattedDate = DateFormat('yMMMd').format(pickedDate);
                setState(() {
                  dateController.text = formattedDate.toString();
                  Buydate = [];
                  for (var i = 0; i < buyCourseModel.length; i++) {
                    if (buyCourseModel[i].date == formattedDate) {
                      Buydate.add(buyCourseModel[i]);
                    }
                  }
                  print('###Buydate=${Buydate.length}');
                  // Buydate = buyCourseModel.where((x) => {
                  //   return x.date == formattedDate;
                  // });
                });
              } else {
                print('Not selected');
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> readAPI() async {
    String urlAPI = '${MyConstant.domain}/boneclinic/getcourse.php';
    await Dio().get(urlAPI).then((value) {
      print('### value = $value');

      if (value.toString() == 'null') {
        setState(() {
          haveCourse = false;
          load = false;
        });
      } else {
        for (var item in json.decode(value.data)) {
          CourseModel model = CourseModel.fromMap(item);

          String string = model.pic_course;
          print(string);
          string = string.substring(1, string.length - 1);
          List<String> strings = string.split(',');
          int i = 0;
          for (var item in strings) {
            strings[i] = item.trim();
            i++;
          }
          listImages.add(strings);

          setState(() {
            haveCourse = true;
            load = false;

            courseModels.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(),
      body: load
          ? showProgress()
          : haveCourse!
              ? listCourse()
              : Center(
                  child: ShowTitle(
                    title: 'No Course',
                    textStyle: MyConstant().h1style(),
                  ),
                ),
    );
  }

  LayoutBuilder listCourse() {
    double size = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        itemCount: courseModels.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            print('### You Click Index ==>> $index');
            showAlertDialog(courseModels[index], listImages[index]);
          },
          //  child:ListView(children: [builImage(100)]) ,
          child: Card(
            child: Row(
              children: [
                Container(
                  width: constraints.maxWidth * 0.48,
                  height: constraints.maxWidth * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: findUrlImage(courseModels[index].pic_course),
                      placeholder: (context, url) => showProgress(),
                      errorWidget: (context, url, error) =>
                          ShowImage(path: MyConstant.image1),
                    ),
                  ),
                ),
                Container(
                  width: constraints.maxWidth * 0.48,
                  height: constraints.maxWidth * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShowTitle(
                          title: courseModels[index].name_course,
                          textStyle: MyConstant().h2style(),
                        ),
                        ShowTitle(
                          title: 'ราคา  ${courseModels[index].price} THB',
                          textStyle: MyConstant().h3style(),
                        ),
                        ShowTitle(
                          title: cutWord(
                              'รายละเอียด :${courseModels[index].detail_course} '),
                          textStyle: MyConstant().h3style(),
                        ),
                        ShowTitle(
                          title: 'จำนวน :${courseModels[index].amount} ครั้ง ',
                          textStyle: MyConstant().h2RedStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String findUrlImage(String arrayImage) {
    String string = arrayImage.substring(1, arrayImage.length - 1);
    List<String> strings = string.split(',');
    int index = 0;
    for (var item in strings) {
      strings[index] = item.trim();
      index++;
    }
    return '${MyConstant.domain}/boneclinic${strings[0]}';
  }

  Future<Null> showAlertDialog(
      CourseModel courseModel, List<String> images) async {
    double size = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                title: ListTile(
                  leading: ShowImage(path: MyConstant.image2),
                  title: ShowTitle(
                    title: courseModel.name_course,
                    textStyle: MyConstant().h2style(),
                  ),
                  subtitle: ShowTitle(
                    title: 'ราคา ${courseModel.price} THB',
                    textStyle: MyConstant().h3style(),
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            '${MyConstant.domain}/boneclinic${images[indexImage]}',
                        placeholder: (context, url) => showProgress(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  indexImage = 0;
                                  print('### indexImage = $indexImage ');
                                });
                              },
                              icon: Icon(Icons.filter_1_outlined),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  indexImage = 1;
                                  print('### indexImage = $indexImage ');
                                });
                              },
                              icon: Icon(Icons.filter_2_outlined),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  indexImage = 2;
                                  print('### indexImage = $indexImage ');
                                });
                              },
                              icon: Icon(Icons.filter_3_outlined),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  indexImage = 3;
                                  print('### indexImage = $indexImage ');
                                });
                              },
                              icon: Icon(Icons.filter_4_outlined),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          ShowTitle(
                            title: 'รายละเอียด',
                            textStyle: MyConstant().h2style(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 200,
                              child: ShowTitle(
                                title: courseModel.detail_course,
                                textStyle: MyConstant().h3style(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //### ส่วนของการจองคอร์ส
                      Container(
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Container(
                              //width: double.maxFinite,
                              child: Column(
                                //padding: EdgeInsets.all(16),
                                children: [
                                  buildDate(300),
                                  //   buildTime33(size, setState),
                                  buildTime1(size, setState),
                                  buildTime2(size, setState),
                                  buildTime3(size, setState),
                                  buildTime4(size, setState),
                                  buildTime5(size, setState),
                                  List_people_course(context)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (choose_time == null) {
                              print('Non Choose Time User');
                              MyDialog().normalDialog(
                                  context,
                                  'ยังไม่ได้เลือก เวลา',
                                  'กรุณา เลิอกช่วงเวลา ที่ต้องการ');
                            } else {
                              await check_wallet(
                                  context, courseModel, setState);
                              // await processInsertBuycourse(courseModel);

                            }
                          }
                        },
                        child: Text(
                          'จองคอร์ส',
                          style: MyConstant().h2BlueStyle(),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'ยกเลิก',
                          style: MyConstant().h2RedStyle(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }

  Future<void> check_wallet(BuildContext context, CourseModel courseModel,
      StateSetter setState) async {
    MyDialog().showProgressDialog(context);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idBuyer = preferences.getString('id')!;

    var path =
        '${MyConstant.domain}/boneclinic/get_MoneyWhereidBuyer.php?isAdd=true&id_buyer=$idBuyer';
    await Dio().get(path).then((value) {
      Navigator.pop(context);
      print('#### $value');
      if (value.toString() == 'null') {
        print('#### action Alert add Wallet');
        MyDialog(
          funcAction: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, MyConstant.routeAddWallet);
          },
        ).actionDialog(context, 'No Wallet', 'Please Add Wallet');
      } else {
        print('### check Wallet can Payment');

        price_cours = double.parse(courseModel.price.trim());
        print('#12feb total_moneyBuyer ==> $total_moneyBuyer บาท');
        if (total_moneyBuyer! - price_cours! >= 0) {
          print('#12feb Can Order');
          MyDialog(
            funcAction: () {
              orderfunc(courseModel);

              setState(() {
                ToTal_moneyBuyer();

                //  print('##_New_ToTal_moneyBuyer==>$total_moneyBuyer');
              });
            },
          ).actionDialog(context, 'Confirm Order',
              'ราคารวมทั้งหมด : $price_cours THB \n ยืนยันคำสั่งซื้อของท่าน');
        } else {
          print('#12feb Cannot Order');
          MyDialog().normalDialog(context, 'ไม่สามารถซื้อได้ ?',
              'จำนวนเงินที่มีอยู่ : $total_moneyBuyer  บาท\nจำนวนงินที่ต้องจ่าย: \n$price_cours บาท');
        }
      }
    });
  }

  void reset_DateTime() {
    dateController.text = "";
    choose_time = "";
  }

  Future<void> processInsertBuycourse(CourseModel courseModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idBuyer = preferences.getString('id')!;
    String idOrder = '';
    String apiInsertOrder =
        '${MyConstant.domain}/boneclinic/insertBuycourse.php?isAdd=true&course_id=${courseModel.course_id}&id_Buyer=$idBuyer&date=${dateController.text}&time=$choose_time&quantity=${courseModel.amount}';
    print('##processInsertBuycourse==$apiInsertOrder');
    await Dio().get(apiInsertOrder).then((value) {
      if (value.toString() != 'false') {
        //   Navigator.pop(context);
        idOrder = value.toString();
        reset_DateTime();
      } else {
        MyDialog().normalDialog(context, ' False !!!', 'Plase Try Again');
      }
    });
  }

  ElevatedButton List_people_course(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('รายชื่อคนที่จอง'),
    );
  }

  Row buildTime5(double size, StateSetter setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: '14.00 - 15.00',
            groupValue: choose_time,
            onChanged: (value) {
              setState(() {
                choose_time = value as String?;
                print(' ==Date_ ${dateController.text}');
                print('==Time_ $choose_time');

                if (Buydate.length != 0) {
                  for (var i = 0; i < Buydate.length; i++) {
                    if (Buydate[i].time == value) {
                      Buydate.add(buyCourseModel[i]);
                      print('มีคนจองเเล้ว');
                      choose_time = '';
                      MyDialog().normalDialog(context, 'มีคนจองแล้ว',
                          'กรุณาเลือกเวลาใหม่อีกครั้ง !!!');

                      return;
                    } else {
                      evaluate = false;
                      print('จองได้');
                    }
                  }
                } else {
                  evaluate = false;
                  print('จองได้');
                }

                evaluate ? null : choose_time = value as String?;
              });
            },
            title: ShowTitle(
              title: '14.00 - 15.00',
              textStyle: MyConstant().h3style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildTime4(double size, StateSetter setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: '13.00 - 14.00',
            groupValue: choose_time,
            onChanged: (value) {
              setState(() {
                choose_time = value as String?;
                print(' ==Date_ ${dateController.text}');
                print('==Time_ $choose_time');

                if (Buydate.length != 0) {
                  for (var i = 0; i < Buydate.length; i++) {
                    if (Buydate[i].time == value) {
                      Buydate.add(buyCourseModel[i]);
                      print('มีคนจองเเล้ว');
                      choose_time = '';
                      MyDialog().normalDialog(context, 'มีคนจองแล้ว',
                          'กรุณาเลือกเวลาใหม่อีกครั้ง !!!');

                      return;
                    } else {
                      evaluate = false;
                      print('จองได้');
                    }
                  }
                } else {
                  evaluate = false;
                  print('จองได้');
                }
                print('5555555');
                evaluate ? null : choose_time = value as String?;
              });
            },
            title: ShowTitle(
              title: '13.00 - 14.00',
              textStyle: MyConstant().h3style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildTime3(double size, StateSetter setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: '11.00 - 12.00',
            groupValue: choose_time,
            onChanged: (value) {
              setState(() {
                choose_time = value as String?;
                print(' ==Date_ ${dateController.text}');
                print('==Time_ $choose_time');

                if (Buydate.length != 0) {
                  for (var i = 0; i < Buydate.length; i++) {
                    if (Buydate[i].time == value) {
                      Buydate.add(buyCourseModel[i]);
                      print('มีคนจองเเล้ว');
                      choose_time = '';
                      MyDialog().normalDialog(context, 'มีคนจองแล้ว',
                          'กรุณาเลือกเวลาใหม่อีกครั้ง !!!');

                      return;
                    } else {
                      evaluate = false;
                      print('จองได้');
                    }
                  }
                } else {
                  evaluate = false;
                  print('จองได้');
                }
                print('5555555');
                evaluate ? null : choose_time = value as String?;
              });
            },
            title: ShowTitle(
              title: '11.00 - 12.00',
              textStyle: MyConstant().h3style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildTime2(double size, StateSetter setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: '10.00 - 11.00',
            groupValue: choose_time,
            onChanged: (value) {
              setState(() {
                choose_time = value as String?;
                print(' ==Date_ ${dateController.text}');
                print('==Time_ $choose_time');

                if (Buydate.length != 0) {
                  for (var i = 0; i < Buydate.length; i++) {
                    if (Buydate[i].time == value) {
                      Buydate.add(buyCourseModel[i]);
                      print('มีคนจองเเล้ว');
                      choose_time = '';
                      MyDialog().normalDialog(context, 'มีคนจองแล้ว',
                          'กรุณาเลือกเวลาใหม่อีกครั้ง !!!');

                      return;
                    } else {
                      evaluate = false;
                      print('จองได้');
                    }
                  }
                } else {
                  evaluate = false;
                  print('จองได้');
                }

                evaluate ? null : choose_time = value as String?;
              });
            },
            title: ShowTitle(
              title: '10.00 - 11.00',
              textStyle: MyConstant().h3style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildTime1(double size, StateSetter setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: '09.00 - 10.00',
            groupValue: choose_time,
            onChanged: (value) {
              setState(() {
                choose_time = value as String?;
                print(' ==Date_ ${dateController.text}');
                print('==Time_ $choose_time');

                if (Buydate.length != 0) {
                  for (var i = 0; i < Buydate.length; i++) {
                    if (Buydate[i].time == value) {
                      Buydate.add(buyCourseModel[i]);
                      print('มีคนจองเเล้ว');
                      choose_time = '';
                      MyDialog().normalDialog(context, 'มีคนจองแล้ว',
                          'กรุณาเลือกเวลาใหม่อีกครั้ง !!!');

                      return;
                    } else {
                      evaluate = false;
                      print('จองได้');
                    }
                  }
                } else {
                  evaluate = false;
                  print('จองได้');
                }
                print('5555555');
                evaluate ? null : choose_time = value as String?;

                // print('##time==>$choose_time');
                // print(
                //     'API_dateController==>${API_dateController.text} API_choose_time==>$API_choose_time');
              });
            },
            title: ShowTitle(
              title: '09.00 - 10.00',
              textStyle: MyConstant().h3style(),
            ),
          ),
        ),
      ],
    );
  }

  // Row buildTime33(double size, StateSetter setState) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         width: size * 0.6,
  //         child: RadioListTile<int>(
  //           value: 1,
  //           isThreeLine: false,
  //           title: Text(
  //             '08.00 - 09.00',
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           groupValue: choose_time02,
  //           onChanged: (choose_time02) => evaluate ? null : choose_time02 = 1,
  //           activeColor: Colors.green,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  String cutWord(String string) {
    String result = string;
    if (result.length >= 40) {
      result = result.substring(0, 40);
      result = '$result ...';
    }
    return result;
  }

  Row builImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.8,
          child: ShowImage(path: MyConstant.image5),
        ),
      ],
    );
  }

  Future<void> orderfunc(CourseModel courseModel) async {
    Navigator.pop(context);
    Navigator.pop(context);
    print('orderFucn work');
    calculateTotalMoneyBuyer();
    processEditMoneyBuyer();
    processInsertBuycourse(courseModel);

    MyDialog()
        .normalDialog(context, 'การซื้อสำเร็จ', 'ทำรายการเสร็จสิ้นแล้ว !!!');
    // dateController.text = "";
    //choose_time = "";
  }

  Future<Null> processEditMoneyBuyer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idBuyer = preferences.getString('id')!;
    String apiMoneyBuyer =
        '${MyConstant.domain}/boneclinic/editmoneyCustomerWhereId.php?isAdd=true&id_buyer=$idBuyer&total_money=$sum_calculate';
    await Dio().get(apiMoneyBuyer).then((value) {
      print('$apiMoneyBuyer');
    });
  }

  void calculateTotalMoneyBuyer() async {
    sum_calculate = 0;
    setState(() {
      sum_calculate = total_moneyBuyer! - price_cours!;
      print('##price==>$price_cours');
      print('##sum_calculate=>$sum_calculate');
    });
  }
}
