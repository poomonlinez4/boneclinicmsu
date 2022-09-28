import 'dart:convert';

import 'package:boneclinicmsu/models/user_model.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_progress.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowProfile extends StatefulWidget {
  const ShowProfile({Key? key}) : super(key: key);

  @override
  State<ShowProfile> createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    findUserLogin();
  }

  Future<void> findUserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var idUserLogin = preferences.getString('id');
    var urlAPI =
        '${MyConstant.domain}/boneclinic/getUserWhereid.php?isAdd=true&members_id=$idUserLogin';
    await Dio().get(urlAPI).then((value) async {
      for (var item in json.decode(value.data)) {
        // print('item ==>> $item');
        setState(() {
          userModel = UserModel.fromMap(item);
          print('### id login ==> ${userModel!.members_id}');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('แสดงโปรไฟล์ของฉัน '),
        ),
        body: userModel == null ? showProgress() : ShowProFile());
  }

  LayoutBuilder ShowProFile() {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShowTitle(
                title: '  ชื่อ :   ',
                textStyle: MyConstant().h2style(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShowTitle(
                    title: '${userModel!.name} ${userModel!.surname}  ',
                    textStyle: MyConstant().h2style(),
                  ),
                ],
              ),
              ShowTitle(
                title: 'ที่อยู่ : ',
                textStyle: MyConstant().h2style(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: constraints.maxWidth * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ShowTitle(
                        title:
                            userModel == null ? '' : '${userModel!.address}  ',
                        textStyle: MyConstant().h2style(),
                      ),
                    ),
                  ),
                ],
              ),
              ShowTitle(
                title: 'เบอร์โทรศัพท์ ${userModel!.phone}',
                textStyle: MyConstant().h2style(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ShowTitle(
                  title: 'รูปภาพประจำตัว :',
                  textStyle: MyConstant().h2style(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    width: constraints.maxWidth * 0.6,
                    child: CachedNetworkImage(
                      imageUrl: '${MyConstant.domain}${userModel!.pic_members}',
                      placeholder: (context, url) => showProgress(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
