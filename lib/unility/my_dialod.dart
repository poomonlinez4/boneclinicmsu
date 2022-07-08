//import 'dart:io';

import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:flutter/material.dart';

class MyDialog {
  Future<Null> normalDialog(
      BuildContext context, String title, String messagde) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image4),
          title: ShowTitle(title: title, textStyle: MyConstant().h2style()),
          subtitle:
              ShowTitle(title: messagde, textStyle: MyConstant().h3style()),
        ),
        children: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
        ],
      ),
    );
  }
}
