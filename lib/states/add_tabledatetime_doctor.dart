//import 'dart:js';

import 'dart:io';
import 'dart:math';

import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/unility/my_dialod.dart';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddTableDateTime extends StatefulWidget {
  const AddTableDateTime({Key? key}) : super(key: key);

  @override
  State<AddTableDateTime> createState() => _AddTableDateTimeState();
}

class _AddTableDateTimeState extends State<AddTableDateTime> {
  final formKey = GlobalKey<FormState>();
  List<File?> files = [];
  File? file;
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<String> paths = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFile();
  }

  void initialFile() {
    for (var i = 0; i < 4; i++) {
      files.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => processAddProduct(),
            icon: Icon(Icons.cloud_upload),
          )
        ],
        title: Text('เพิ่มตารางเวลาทำงาน '),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Center(
            heightFactor: 1.2,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    buildDate(constraints),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(),
                    //     Container(),
                    //     Container(),
                    //   ],
                    // ),
                    addTableDateButton1(constraints),
                    addTableDateButton2(constraints),
                    addTableDateButton3(constraints),
                    SizedBox(height: 20),
                    addProductButton(constraints),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container addProductButton(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.5,
      child: ElevatedButton(
        style: MyConstant().myButtonStyle2(),
        onPressed: () {
          processAddProduct();
        },
        child: Text('Add Product'),
      ),
    );
  }

  Container addTableDateButton1(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      child: ElevatedButton(
        style: MyConstant().myButtonStyle(),
        onPressed: () {
          processAddProduct();
        },
        child: Text('09.00 - 10.00'),
      ),
    );
  }

  Container addTableDateButton2(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      child: ElevatedButton(
        style: MyConstant().myButtonStyle(),
        onPressed: () {
          processAddProduct();
        },
        child: Text('10.00 - 11.00'),
      ),
    );
  }

  Container addTableDateButton3(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      child: ElevatedButton(
        style: MyConstant().myButtonStyle(),
        onPressed: () {
          processAddProduct();
        },
        child: Text('11.00 - 12.00'),
      ),
    );
  }

  // Container addTableDateButton4(BoxConstraints constraints) {
  //   return Container(
  //     width: constraints.maxWidth * 0.75,
  //     child: ElevatedButton(
  //       style: MyConstant().myButtonStyle2(),
  //       onPressed: () {
  //         processAddProduct();
  //       },
  //       child: Text('14.00 - 15.00'),
  //     ),
  //   );
  // }

  Future<Null> processAddProduct() async {
    if (formKey.currentState!.validate()) {
      bool checkFile = true;
      for (var item in files) {
        if (item == null) {
          checkFile = false;
        } else {}
      }
      if (checkFile) {
        //  print('## choose 4 image success');

        MyDialog().showProgressDialog(context);
        String apiSaveProduct =
            '${MyConstant.domain}/boneclinic/saveProduct.php';

        int loop = 0;

        for (var item in files) {
          int i = Random().nextInt(1000000);
          String nameFile = 'product$i.jpg';

          paths.add('/product/$nameFile');

          Map<String, dynamic> map = {};
          map['file'] =
              await MultipartFile.fromFile(item!.path, filename: nameFile);
          FormData data = FormData.fromMap(map);
          await Dio().post(apiSaveProduct, data: data).then((value) async {
            print('Upload Success');
            loop++;
            if (loop >= files.length) {
              String name_product = nameController.text;
              String price_product = priceController.text;
              String detail_product = detailController.text;
              String pic_product = paths.toString();
              print(
                  '### name = $name_product,price = $price_product,detail = $detail_product');
              print('### images ==> ${pic_product}');

              String path =
                  '${MyConstant.domain}/boneclinic/insertProduct.php?isAdd=true&name_product=$name_product&detail_product=$detail_product&price_product=$price_product&pic_product=$pic_product';
              await Dio().get(path).then((value) => Navigator.pop(context));
              Navigator.pop(context);
            }
          });
        }
      } else {
        MyDialog()
            .normalDialog(context, 'More Image', 'Please Choose More Image');
      }
    }
  }

  Future<Null> processImagePicker(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxHeight: 800,
        maxWidth: 800,
      );
      // files[index] = File(result!.path);
      setState(() {
        file = File(result!.path);
        files[index] = file;
      });
    } catch (e) {}
  }

  Future<Null> chooseSourceImageDialog(int index) async {
    print('Click From index ==>> $index');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image4),
          title: ShowTitle(
              title: 'Source Image ${index + 1}  ?',
              textStyle: MyConstant().h2style()),
          subtitle: ShowTitle(
              title: 'Please Tab on Camera or Gallery',
              textStyle: MyConstant().h3style()),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  processImagePicker(ImageSource.camera, index);
                },
                child: Text('Camera'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  processImagePicker(ImageSource.gallery, index);
                },
                child: Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDate(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        controller: nameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill Date in Blank';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyConstant().h3style(),
          labelText: 'กรอกวันที่ : ',
          prefixIcon: Icon(
            Icons.date_range_outlined,
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
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
