import 'dart:io';
import 'dart:math';

import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/unility/my_dialod.dart';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;
  String avatar = '';
  File? file; //เกี่ยวกับรูปภาพ
  final formKey = GlobalKey<
      FormState>(); //formkeyเป็นตัวเชื่อม text formfild ว่ามีค่าหรือเปล่า

  TextEditingController nameController = TextEditingController();
  TextEditingController SurnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Row buildName(double size) {
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
              labelText: 'ชื่อ : ',
              prefixIcon: Icon(
                Icons.fingerprint,
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

  Row buildSurname(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: SurnameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก นามสกุล ด้วยค่ะ';
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3style(),
              labelText: 'นามสกุล : ',
              prefixIcon: Icon(
                Icons.fingerprint,
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

  Row buildPhone(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone, //ทำให้คีย์บอร์ดกดได้แค่แบบตัวเลข
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก เบอร์โทรศัพท์ ด้วยค่ะ';
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3style(),
              labelText: 'เบอร์โทรศัพท์ : ',
              prefixIcon: Icon(
                Icons.phone,
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

  Row buildemail(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: emailController,
            keyboardType:
                TextInputType.emailAddress, //ทำให้คีย์บอร์ดกดได้แค่แบบตัวเลข
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก อีเมล ด้วยค่ะ';
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3style(),
              labelText: 'อีเมล : ',
              prefixIcon: Icon(
                Icons.email,
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

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: userController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก ชื่อผู้ใช้ ด้วยค่ะ';
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3style(),
              labelText: 'ชื่อผู้ใช้ : ',
              prefixIcon: Icon(
                Icons.perm_identity,
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

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก Password ด้วยค่ะ';
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3style(),
              labelText: 'รหัสผ่าน : ',
              prefixIcon: Icon(
                Icons.lock_outline,
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

  Row buildAddress(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: addressController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก ที่อยู่ ด้วยค่ะ';
              }
            },
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'ที่อยู่ :',
              helperStyle: MyConstant().h3style(),
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Icon(
                  Icons.home,
                  color: MyConstant.dark,
                ),
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

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          buildCreateNewAccount(),
        ],
        title: Text('Create New Account'),
        backgroundColor: MyConstant.primary,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              //padding: EdgeInsets.all(16),
              children: [
                buildTitle('ข้อมูลพื้นฐาน'),
                buildUser(size),
                buildPassword(size),
                buildTitle('ข้อมูลทั่วไป  '),
                buildRadioMale(size),
                buildRadioFemale(size),
                buildName(size),
                buildSurname(size),
                buildAddress(size),
                buildPhone(size),
                buildemail(size),
                buildTitle('รูปภาพ'),
                buildSubTitle(),
                buildAvatar(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconButton buildCreateNewAccount() {
    return IconButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          if (typeUser == null) {
            print('Non Choose Type User');
            MyDialog().normalDialog(context, 'ยังไม่ได้เลือกชนิดของ User',
                'กรุณา Tap ที่ชนิดของ User ที่ต้องการ');
          } else {
            print('Process Insert to Database');
            uploadPictureAndInsertData();
          }
        }
      },
      icon: Icon(Icons.cloud_upload),
    );
  }

  Future<Null> uploadPictureAndInsertData() async {
    String user = userController.text;
    String password = passwordController.text;
    String name = nameController.text;
    String surname = SurnameController.text;
    String address = addressController.text;
    String phone = phoneController.text;
    String email = emailController.text;

    print(
        '## user = $user, password = $password, name = $name, surname = $surname, address = $address, phone = $phone, email = $email');
    String path =
        '${MyConstant.domain}/boneclinic/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) async {
      print(' ## value ==>> $value');
      if (value.toString() == 'null') {
        print('## user OK ');

        if (file == null) {
          //No Avatar
          processInsertMySQL(
            user: user,
            password: password,
            name: name,
            surname: surname,
            address: address,
            phone: phone,
            email: email,
          );
        } else {
          // Have Avatar
          print('### process Update Avatar');
          String apiSaveAvatar =
              '${MyConstant.domain}/boneclinic/saveAvatar.php';
          int i = Random().nextInt(100000);
          String nameAvatar = 'avatar$i.jpg';
          Map<String, dynamic> map = Map();
          map['file'] =
              await MultipartFile.fromFile(file!.path, filename: nameAvatar);
          FormData data = FormData.fromMap(map);
          await Dio().post(apiSaveAvatar, data: data).then((value) {
            avatar = '/boneclinic/avatar/$nameAvatar';
            processInsertMySQL(
              user: user,
              password: password,
              name: name,
              surname: surname,
              address: address,
              phone: phone,
              email: email,
            );
          });
        }
      } else {
        MyDialog().normalDialog(context, 'User false ?', 'Please Change User');
      }
    });
  }

  Future<Null> processInsertMySQL(
      {String? user,
      String? password,
      String? name,
      String? surname,
      String? sex,
      String? address,
      String? phone,
      String? email,
      String? pic_members}) async {
    print('### processInsertMySQL work and avatar ==> $avatar');
    String apiInsertData =
        '${MyConstant.domain}/boneclinic/insertData.php?isAdd=true&user=$user&password=$password&name=$name&surname=$surname&sex=$typeUser&address=$address&phone=$phone&email=$email&pic_members=$avatar&role_id=3';
    await Dio().get(apiInsertData).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        MyDialog().normalDialog(
            context, 'Create New User False !!!', 'Plase Try Again');
      }
    });
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row buildAvatar(double size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => chooseImage(ImageSource.camera),
          icon: Icon(Icons.add_a_photo, size: 36, color: MyConstant.dark),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.6,
          child: file == null
              ? ShowImage(path: MyConstant.avatar)
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => chooseImage(ImageSource.gallery),
          icon: Icon(
            Icons.add_photo_alternate,
            size: 36,
            color: MyConstant.dark,
          ),
        ),
      ],
    );
  }

  ShowTitle buildSubTitle() {
    return ShowTitle(
        title:
            'เป็นรูปภาพที่แสดงความเป็นตัวตนของ User (แต่ถ้าไม่สะดวกจะแชร์เราจะแสดงภาพ default แทน',
        textStyle: MyConstant().h3style());
  }

  Row buildRadioMale(double size) {
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
              title: 'ชาย (Male)',
              textStyle: MyConstant().h3style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioFemale(double size) {
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
              title: 'หญิง (Female)',
              textStyle: MyConstant().h3style(),
            ),
          ),
        ),
      ],
    );
  }

  Container buildTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2style(),
      ),
    );
  }
}
