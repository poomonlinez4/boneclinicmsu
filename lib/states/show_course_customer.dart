import 'dart:convert';

import 'package:boneclinicmsu/models/product_model.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_progress.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

  final formKey = GlobalKey<FormState>();
  String? typeUser;

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readAPI();
  }

  Row buildDate(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก Name ด้วยค่ะ';
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
          ),
        ),
      ],
    );
  }

  Row buildTime1(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'Female',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
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

  Row buildTime2(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'Male',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
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

  Row buildTime3(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'Male',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
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

  Row buildTime4(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'Male',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
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

  Row buildTime5(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'Male',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
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
                            child: Column(
                              //padding: EdgeInsets.all(16),
                              children: [
                                buildDate(300),
                                buildTime1(350),
                                buildTime2(350),
                                buildTime3(350),
                                buildTime4(350),
                                buildTime5(350),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('รายชื่อคนที่จอง'),
                                )
                              ],
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
                        onPressed: () => Navigator.pop(context),
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
}
