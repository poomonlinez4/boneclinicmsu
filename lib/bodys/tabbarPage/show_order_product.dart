import 'dart:convert';

import 'package:boneclinicmsu/models/buycourse_model.dart';

import 'package:boneclinicmsu/models/order_product_detail_model.dart';
import 'package:boneclinicmsu/models/order_product_model.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_no_data.dart';
import 'package:boneclinicmsu/widgets/show_progress.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowOrderProductDetails extends StatefulWidget {
  final OrderProductModel orderproductModel;
  const ShowOrderProductDetails({Key? key, required this.orderproductModel})
      : super(key: key);

  @override
  State<ShowOrderProductDetails> createState() =>
      _ShowOrderProductDetailsState();
}

class _ShowOrderProductDetailsState extends State<ShowOrderProductDetails> {
  OrderProductModel? orderproductModel;

  bool load = true;
  bool? haveCourse;
  List<OrderProductDetailModel> orderproductDetailModels = [];
  List<List<String>> listImages = [];
  int indexImage = 0;
  TextEditingController dateController = TextEditingController();
  TextEditingController API_dateController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  List<BuyCourseModel> buyCourseModel = [];
  List<BuyCourseModel> Buydate = [];

  String? API_choose_time;

  bool dense = false;
  String _selection = '';
  final bool selected = false;
  bool evaluate = true;
  int? choose_time02;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderproductModel = widget.orderproductModel;
    readAPI();
  }

  Future<void> readAPI() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id_buyer = preferences.getString('id')!;
    String urlAPI =
        '${MyConstant.domain}/boneclinic/get_OrderProduct_detail.php?idBuyer=$id_buyer&id_orderProduct=${orderproductModel!.id}';
    await Dio().get(urlAPI).then((value) {
      print('### value = $value');

      if (value.toString() == 'null') {
        setState(() {
          haveCourse = false;
          load = false;
        });
      } else {
        for (var item in json.decode(value.data)) {
          OrderProductDetailModel model = OrderProductDetailModel.fromMap(item);

          String string = model.pic_product;
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

            orderproductDetailModels.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียด'),
        //centerTitle: true,
      ),
      body: load
          ? showProgress()
          : haveCourse!
              ? listBuyProduct()
              : Center(
                  // decoration: MyConstant().gradintLinearBackground(),
                  child: ShowNoData(
                    title: 'ไม่มี สินค้าที่ทำรายการ',
                    pathImage: MyConstant.image2,
                  ),
                ),
    );
  }

  LayoutBuilder listBuyProduct() {
    double size = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        itemCount: orderproductDetailModels.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            print('### You Click Index ==>> $index');
            //  showAlertDialog(orderproductDetailModels[index], listImages[index]);
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
                      imageUrl: findUrlImage(
                          orderproductDetailModels[index].pic_product),
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
                          title: cutWord(
                              'ชื่อ :  ${orderproductDetailModels[index].name_product} '),
                          textStyle: MyConstant().h2style(),
                        ),
                        ShowTitle(
                          title:
                              'ราคา  ${orderproductDetailModels[index].price_product} THB/ชิ้น',
                          textStyle: MyConstant().h3style(),
                        ),
                        ShowTitle(
                          title:
                              'จำนวน ${orderproductDetailModels[index].amountProduct} ชิ้น',
                          textStyle: MyConstant().h3BlueStyle(),
                        ),
                        ShowTitle(
                          title:
                              'ราคารวม  ${orderproductDetailModels[index].total} THB',
                          textStyle: MyConstant().h3RedStyle(),
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

  // Future<Null> showAlertDialog(
  //     HistoryBuycourseModel historybuycourseModel, List<String> images) async {
  //   double size = MediaQuery.of(context).size.width;
  //   showDialog(
  //       context: context,
  //       builder: (context) => StatefulBuilder(
  //             builder: (context, setState) => AlertDialog(
  //               title: ListTile(
  //                 leading: ShowImage(path: MyConstant.image2),
  //                 title: ShowTitle(
  //                   title: historybuycourseModel.name_course,
  //                   textStyle: MyConstant().h2style(),
  //                 ),
  //                 subtitle: ShowTitle(
  //                   title: 'ราคา ${historybuycourseModel.price} THB',
  //                   textStyle: MyConstant().h3style(),
  //                 ),
  //               ),
  //               content: SingleChildScrollView(
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     CachedNetworkImage(
  //                       imageUrl:
  //                           '${MyConstant.domain}/boneclinic${images[indexImage]}',
  //                       placeholder: (context, url) => showProgress(),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(16.0),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           IconButton(
  //                             onPressed: () {
  //                               setState(() {
  //                                 indexImage = 0;
  //                                 print('### indexImage = $indexImage ');
  //                               });
  //                             },
  //                             icon: Icon(Icons.filter_1_outlined),
  //                           ),
  //                           IconButton(
  //                             onPressed: () {
  //                               setState(() {
  //                                 indexImage = 1;
  //                                 print('### indexImage = $indexImage ');
  //                               });
  //                             },
  //                             icon: Icon(Icons.filter_2_outlined),
  //                           ),
  //                           IconButton(
  //                             onPressed: () {
  //                               setState(() {
  //                                 indexImage = 2;
  //                                 print('### indexImage = $indexImage ');
  //                               });
  //                             },
  //                             icon: Icon(Icons.filter_3_outlined),
  //                           ),
  //                           IconButton(
  //                             onPressed: () {
  //                               setState(() {
  //                                 indexImage = 3;
  //                                 print('### indexImage = $indexImage ');
  //                               });
  //                             },
  //                             icon: Icon(Icons.filter_4_outlined),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     Row(
  //                       children: [
  //                         ShowTitle(
  //                           title: 'รายละเอียด',
  //                           textStyle: MyConstant().h2style(),
  //                         ),
  //                       ],
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Row(
  //                         children: [
  //                           Container(
  //                             width: 200,
  //                             child: ShowTitle(
  //                               title: historybuycourseModel.detail_course,
  //                               textStyle: MyConstant().h3style(),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               actions: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     TextButton(
  //                       onPressed: () => Navigator.pop(context),
  //                       child: Text(
  //                         'ย้อนกลับ',
  //                         style: MyConstant().h2RedStyle(),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ));
  // }

  // สร้างปุ่มกด
  // ElevatedButton List_people_course(BuildContext context) {
  //   return ElevatedButton(
  //     onPressed: () {
  //       Navigator.pop(context);
  //     },
  //     child: Text('รายชื่อคนที่จอง'),
  //   );
  // }

  String cutWord(String string) {
    String result = string;
    if (result.length >= 40) {
      result = result.substring(0, 15);
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
