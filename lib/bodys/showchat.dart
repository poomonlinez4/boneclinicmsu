// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/chatmodel.dart';
import '../unility/my_constant.dart';

class ShowChat extends StatefulWidget {
  const ShowChat({
    Key? key,
    required this.chatModel,
  }) : super(key: key);
  final Chatmodel chatModel;
  @override
  State<ShowChat> createState() => _ShowChatState();
}

class _ShowChatState extends State<ShowChat> {
  // Future<Null> checkUser() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     // idCus = preferences.getString('idcus');
  //     // usernameCus = preferences.getString('usernamecus');

  //   });
  //   String url =
  //       '${MyConstant.domain}/boneclinic/CheckChatWhereId.php?isAdd=true&idmembers=${widget.chatModel.membersId}';
  //   print('###########################################$url');

  //   try {
  //     Response response = await Dio().get(url);
  //     print('res = $response');
  //     if (response.toString() == 'null') {
  //       addChatThread();
  //       readDataCustomer();
  //       modelChat(idCus, usernameCus);
  //     } else {
  //       readDataCustomer();
  //       modelChat(idCus, usernameCus);
  //     }
  //   } catch (e) {}
  // }

  // Future<List<dynamic>> readDataChat(int value) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   usernameCus = preferences.getString('usernamecus');
  //   String url =
  //       '${MyConstant().domain}/mobile/getChatDetail.php?isAdd=true&userCus=$usernameCus&userStore=${widget.chatModel.membersUser}';
  //   await Dio().get(url).then((value) {
  //     result = json.decode(value.data);
  //   });
  //   return result;
  // }

  //******************************************___^^^^^^^^^^^^^ ส่วนของด้านบนคือโค้ดที่ไม่ได้คอมเม้นไว้ */

  // Future<Null> modelChat() async {
  //   String url = '${MyConstant.domain}/boneclinic/CheckChatWhereId.php?isAdd=true&idmembers=${widget.chatModel.membersId}';

  //   print('###########################################$url');

  //   try {
  //     await Dio().get(url).then((value) {
  //       print('value = $value');
  //       var result = json.decode(value.data);
  //       for (var map in result) {
  //         setState(() {
  //           checkModel = TrackModel.fromJson(map);
  //           pro = checkModel.id;
  //         });
  //         print('ChatId =${checkModel.id}');
  //       }
  //     });
  //   } catch (e) {}
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เลือก (เเพทย์ที่ต้องการปรึกษา) ')),
    );
  }
}
