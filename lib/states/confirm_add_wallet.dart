import 'dart:io';
import 'dart:math';

import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/unility/my_dialod.dart';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ConfirmAddWallet extends StatefulWidget {
  const ConfirmAddWallet({Key? key}) : super(key: key);

  @override
  State<ConfirmAddWallet> createState() => _ConfirmAddWalletState();
}

class _ConfirmAddWalletState extends State<ConfirmAddWallet> {
  String? dateTimeStr;
  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    findCurrentTime();
  }

  void findCurrentTime() {
    DateTime dateTime = DateTime.now();
    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    setState(() {
      dateTimeStr = dateFormat.format(dateTime);
    });
    print('dateTimeStr = $dateTimeStr');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comfirm Add Wallet'),
        leading: IconButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, MyConstant.routeCoustomerService, (route) => false),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          newHeader(),
          newDateTimePay(),
          Spacer(),
          newImage(),
          Spacer(),
          newButtonConfirm(),
        ],
      ),
    );
  }

  Container newButtonConfirm() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (file == null) {
            MyDialog().normalDialog(context, 'ยังไม่มีรูปภาพ',
                'กรูณาถ่ายภาพ หรือ ใช้ภาพจากคลังภาพ');
          } else {
            processUploadAndInsertData();
          }
        },
        child: Text('Confirm Add Wallet'),
      ),
    );
  }

  Future<void> processUploadAndInsertData() async {
    String apiSaveSlip = '${MyConstant.domain}/boneclinic/saveSlip.php';
    String nameSlip = 'slip ${Random().nextInt(10000000)}.jpg';

    MyDialog().showProgressDialog(context);

    try {
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameSlip);
      FormData data = FormData.fromMap(map);
      await Dio().post(apiSaveSlip, data: data).then((value) {
        print('value --> $value');
        Navigator.pop(context);
      });
    } catch (e) {}
  }

  Future<void> processTakePhoto(ImageSource source) async {
    try {
      var result = await ImagePicker()
          .pickImage(source: source, maxWidth: 800, maxHeight: 800);
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row newImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => processTakePhoto(ImageSource.camera),
          icon: Icon(Icons.add_a_photo),
        ),
        Container(
          width: 200,
          height: 200,
          child: file == null
              ? ShowImage(path: 'images/bill.png')
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => processTakePhoto(ImageSource.gallery),
          icon: Icon(Icons.add_photo_alternate),
        ),
      ],
    );
  }

  ShowTitle newDateTimePay() {
    return ShowTitle(
      title: dateTimeStr == null ? 'dd/MM/yy HH:mm' : dateTimeStr!,
      textStyle: MyConstant().h2BlueStyle(),
    );
  }

  ShowTitle newHeader() {
    return ShowTitle(
      title: 'Current Date Pay',
      textStyle: MyConstant().h1style(),
    );
  }
}
