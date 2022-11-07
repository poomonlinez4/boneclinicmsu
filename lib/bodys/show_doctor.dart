import 'dart:convert';

import 'package:boneclinicmsu/models/course_model.dart';
import 'package:boneclinicmsu/models/show_doctor_model.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_progress.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ShowDoctor extends StatefulWidget {
  const ShowDoctor({Key? key}) : super(key: key);

  @override
  State<ShowDoctor> createState() => _ShowDoctorState();
}

class _ShowDoctorState extends State<ShowDoctor> {
  bool load = true;
  bool? haveDoctor;
  List<ShowDoctorModel> showDoctorModels = [];
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

  Future<void> readAPI() async {
    String urlAPI =
        '${MyConstant.domain}/boneclinic/getShowDoctor.php?isAdd=true';
    await Dio().get(urlAPI).then((value) {
      print('### value = $value');

      if (value.toString() == 'null') {
        setState(() {
          haveDoctor = false;
          load = false;
        });
      } else {
        for (var item in json.decode(value.data)) {
          ShowDoctorModel model = ShowDoctorModel.fromMap(item);

          String string = model.pic_members;
          string = string.substring(1, string.length - 1);
          List<String> strings = string.split(',');
          int i = 0;
          for (var item in strings) {
            strings[i] = item.trim();
            i++;
          }
          listImages.add(strings);

          setState(() {
            haveDoctor = true;
            load = false;

            showDoctorModels.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('เลือก (เเพทย์ที่ต้องการปรึกษา) ')),
      body: load
          ? showProgress()
          : haveDoctor!
              ? ListView(shrinkWrap: true, children: [
                  Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            width: 400,
                            child: ShowImage(
                              path: MyConstant.tb_doctor,
                            ),
                          ),
                          ShowTitle(
                            title: 'ตารางทำงานหมอ',
                            textStyle: MyConstant().h1style(),
                          ),
                          listDoctor()
                        ],
                      ),
                    ),
                  ),
                ])
              : Center(
                  child: ShowTitle(
                    title: 'No Doctor',
                    textStyle: MyConstant().h1style(),
                  ),
                ),
    );
  }

  SizedBox listDoctor() {
    double size = MediaQuery.of(context).size.width;
    int showdoctorLength = showDoctorModels.length;
    int sum_showdoctorLength = 200 * showdoctorLength;
    return SizedBox(
      height: sum_showdoctorLength.toDouble(),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        //  scrollDirection: Axis.vertical,

        itemCount: showDoctorModels.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            print('### You Click Index ==>> $index');
          },
          //  child:ListView(children: [builImage(100)]) ,
          child: Card(
            child: Row(
              children: [
                Container(
                  width: size * 0.4,
                  height: size * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          '${MyConstant.domain}${showDoctorModels[index].pic_members}',
                      //  findUrlImage(showDoctorModels[index].pic_members),
                      placeholder: (context, url) => showProgress(),
                      errorWidget: (context, url, error) =>
                          ShowImage(path: MyConstant.image1),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShowTitle(
                          title:
                              '${showDoctorModels[index].name} ${showDoctorModels[index].surname} ',
                          textStyle: MyConstant().h2style(),
                        ),

                        ShowTitle(
                          title: 'เพศ :${showDoctorModels[index].sex}',
                          textStyle: MyConstant().h2style(),
                        ),
                        ShowTitle(
                          title: 'โทร :${showDoctorModels[index].phone}',
                          textStyle: MyConstant().h2style(),
                        ),
                        ElevatedButton(
                          // style: ElevatedButton.styleFrom(primary: Colors.red),
                          style: MyConstant().myButtonStyle(),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('เเชทเพื่อปรึกษา '),
                        )

                        // ShowTitle(
                        //   title: cutWord(
                        //       'รายละเอียด :${courseModels[index].detail_course} '),
                        //   textStyle: MyConstant().h3style(),
                        // ),
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

  String cutWord(String string) {
    String result = string;
    if (result.length >= 40) {
      result = result.substring(0, 40);
      result = '$result ...';
    }
    return result;
  }
}
