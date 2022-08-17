import 'dart:convert';
import 'dart:ffi';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:boneclinicmsu/models/product_model.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_progress.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ShowAllShopCustomer extends StatefulWidget {
  const ShowAllShopCustomer({Key? key}) : super(key: key);

  @override
  State<ShowAllShopCustomer> createState() => _ShowAllShopCustomerState();
}

class _ShowAllShopCustomerState extends State<ShowAllShopCustomer> {
  bool load = true;
  List<ProductModel> productModels = [];
  List<List<String>> ListImages = [];
  int indexImage = 0;
  int amountInt = 1;
  @override
  void initState() {
    super.initState();
    readApiAllShop();
  }

  Future<Null> readApiAllShop() async {
    String urlAPI = '${MyConstant.domain}/boneclinic/getProductWhereUser.php';
    await Dio().get(urlAPI).then((value) {
      setState(() {
        load = false;
      });
      print('value ==> $value');
      var result = json.decode(value.data);
      print('result = $result');
      for (var item in result) {
        //  print('item ==> $item');
        ProductModel model = ProductModel.fromMap(item);

        String string = model.pic_product;
        string = string.substring(1, string.length - 1);
        List<String> strings = string.split(',');
        int i = 0;
        for (var item in strings) {
          strings[i] = item.trim();
          i++;
        }
        ListImages.add(strings);

        // print('name ==>> ${model.name_product}');
        setState(() {
          productModels.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? showProgress()
          : GridView.builder(
              itemCount: productModels.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 2 / 3, maxCrossAxisExtent: 180),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  print('### You Click Index ==>> $index');
                  showAlertDialog(
                    productModels[index],
                    ListImages[index],
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 180,
                          height: 180,
                          child: CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                ShowImage(path: MyConstant.image9),
                            placeholder: (context, url) => showProgress(),
                            fit: BoxFit.cover,
                            imageUrl:
                                findUrlImage(productModels[index].pic_product),
                          ),
                        ),
                        Column(
                          children: [
                            ShowTitle(
                                title:
                                    cutWord(productModels[index].name_product),
                                textStyle: MyConstant().h2style()),
                            ShowTitle(
                                title: cutWord(
                                    ' ${productModels[index].price_product} THB'),
                                textStyle: MyConstant().h3style()),
                            ShowTitle(
                                title: cutWord(
                                    productModels[index].detail_product),
                                textStyle: MyConstant().h3style()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  String cutWord(String name_product) {
    String result = name_product;
    if (result.length > 14) {
      result = result.substring(0, 10);
      result = '$result ...';
    }

    return result;
  }

  String findUrlImage(String arrayImage) {
    String string = arrayImage.substring(1, arrayImage.length - 1);
    List<String> strings = string.split(',');
    int index = 0;
    for (var item in strings) {
      strings[index] = item.trim();
      index++;
    }
    String result = '${MyConstant.domain}/boneclinic${strings[0]}';
    print('### result = $result');
    return result;
  }

  Future<Null> showAlertDialog(
      ProductModel productModel, List<String> pic_product) async {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                title: ListTile(
                  leading: ShowImage(path: MyConstant.image2),
                  title: ShowTitle(
                      title: productModel.name_product,
                      textStyle: MyConstant().h2style()),
                  subtitle: ShowTitle(
                      title: 'ราคา  ${productModel.price_product} THB ',
                      textStyle: MyConstant().h3style()),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            '${MyConstant.domain}/boneclinic${pic_product[indexImage]}',
                        placeholder: (context, url) => showProgress(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  indexImage = 0;
                                  print('### INDEXiMAGE = $indexImage');
                                });
                              },
                              icon: Icon(Icons.filter_1),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  indexImage = 1;
                                  print('### INDEXiMAGE = $indexImage');
                                });
                              },
                              icon: Icon(Icons.filter_2),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  indexImage = 2;
                                  print('### INDEXiMAGE = $indexImage');
                                });
                              },
                              icon: Icon(Icons.filter_3),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  indexImage = 3;
                                  print('### INDEXiMAGE = $indexImage');
                                });
                              },
                              icon: Icon(Icons.filter_4),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          ShowTitle(
                              title: 'รายละเอียด :',
                              textStyle: MyConstant().h2style()),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 200,
                              child: ShowTitle(
                                  title: productModel.detail_product,
                                  textStyle: MyConstant().h3style()),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (amountInt != 1) {
                                setState(() {
                                  amountInt--;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: MyConstant.dark,
                            ),
                          ),
                          ShowTitle(
                              title: amountInt.toString(),
                              textStyle: MyConstant().h1style()),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                amountInt++;
                              });
                            },
                            icon: Icon(Icons.add_circle_outline,
                                color: MyConstant.dark),
                          ),
                        ],
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
                          'Add Cart',
                          style: MyConstant().h2BlueStyle(),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: MyConstant().h2RedStyle(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}
