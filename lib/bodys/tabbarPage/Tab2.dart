import 'dart:convert';
import 'dart:ffi';

import 'package:boneclinicmsu/bodys/tabbarPage/show_order_product.dart';
import 'package:boneclinicmsu/models/buycourse_model.dart';
import 'package:boneclinicmsu/models/history_buycourse_model.dart';
import 'package:boneclinicmsu/models/order_product_model.dart';
import 'package:boneclinicmsu/models/wallet_buyer_model.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/unility/my_dialod.dart';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_no_data.dart';
import 'package:boneclinicmsu/widgets/show_progress.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tab2 extends StatefulWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  bool load = true;
  bool? haveCourse;
  List<OrderProductModel> orderproductModels = [];
  List<List<String>> listImages = [];
  int indexImage = 0;

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  WalletBuyerModel? walletBuyerModel;

  List<BuyCourseModel> buyCourseModel = [];
  List<BuyCourseModel> Buydate = [];

  bool dense = false;
  String _selection = '';
  final bool selected = false;
  bool evaluate = true;
  int? choose_time02;

  @override
  void initState() {
    super.initState();
    readAPI();
  }

  Future<void> readAPI() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id_buyer = preferences.getString('id')!;
    String urlAPI =
        '${MyConstant.domain}/boneclinic/get_OrderProductWhereUser.php?idBuyer=$id_buyer';
    await Dio().get(urlAPI).then((value) {
      print('### value = $value');

      if (value.toString() == 'null') {
        setState(() {
          haveCourse = false;
          load = false;
        });
      } else {
        for (var item in json.decode(value.data)) {
          OrderProductModel model = OrderProductModel.fromMap(item);

          setState(() {
            haveCourse = true;
            load = false;

            orderproductModels.add(model);
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
              ? listBuyCourse()
              : Center(
                  // decoration: MyConstant().gradintLinearBackground(),
                  child: ShowNoData(
                    title: 'ไม่มี สินค้าที่ทำรายการ',
                    pathImage: MyConstant.image2,
                  ),
                ),
    );
  }

  LayoutBuilder listBuyCourse() {
    double size = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        itemCount: orderproductModels.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            print('### You Click Index ==>> $index');
          },
          //  child:ListView(children: [builImage(100)]) ,

          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            // height: 120,

            child: Card(
              color: Color.fromARGB(220, 255, 249, 249),
              child: Row(
                children: [
                  // Container(
                  //   width: constraints.maxWidth * 0.48,
                  //   height: constraints.maxWidth * 0.4,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     // child: CachedNetworkImage(
                  //     //   fit: BoxFit.cover,
                  //     //   imageUrl: findUrlImage(
                  //     //       historybuycourseModels[index].pic_course),
                  //     //   placeholder: (context, url) => showProgress(),
                  //     //   errorWidget: (context, url, error) =>
                  //     //       ShowImage(path: MyConstant.image1),
                  //     // ),
                  //   ),
                  // ),
                  Container(
                    // width: constraints.maxWidth * 0.48,
                    // height: constraints.maxWidth * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShowTitle(
                            title: 'วันที่สั่งซื้อ',
                            textStyle: MyConstant().h1Redstyle(),
                          ),
                          ShowTitle(
                            title: ' ${orderproductModels[index].date_time} ',
                            textStyle: MyConstant().h3BlackStyle(),
                          ),
                          ShowTitle(
                            title:
                                'ราคารวม: ${orderproductModels[index].total_price}',
                            textStyle: MyConstant().h3BlueStyle(),
                          ),
                          ShowTitle(
                            title:
                                'สถานะการจัดส่ง: ${orderproductModels[index].status}  ',
                            textStyle: MyConstant().h3RedStyle(),
                          ),
                          ShowTitle(
                            title:
                                'ที่อยู่การจัดส่ง:  \n ${orderproductModels[index].address}  ',
                            textStyle: MyConstant().h4BlackStyle(),
                          ),
                          ElevatedButton(
                            // style: ElevatedButton.styleFrom(primary: Colors.red),
                            style: MyConstant().myButtonStyle(),
                            onPressed: () {
                              print('Click ดูรายละเอียดคำสั่งซื้อ');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ShowOrderProductDetails(
                                            orderproductModel:
                                                orderproductModels[index]),
                                  ));
                            },
                            child: Text('ดูรายละเอียดคำสั่งซื้อ '),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
}
