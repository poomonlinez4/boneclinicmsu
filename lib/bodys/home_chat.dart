import 'dart:convert';

import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({Key? key}) : super(key: key);

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  @override
  void initState() {
    super.initState();
    readDataChat(1);
  }

  Stream<Future<List<dynamic>>> _stream() {
    Duration interval = Duration(seconds: 1);
    Stream<Future<List<dynamic>>> stream =
        Stream<Future<List<dynamic>>>.periodic(interval, readDataChat);
    return stream;
  }

  Future<List<dynamic>> readDataChat(int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    var result;

    String url =
        '${MyConstant.domain}/boneclinic/getchat.php?isAdd=true&members_id=$id';

    await Dio().get(url).then((value) {
      print('value = $value');
      result = json.decode(value.data);
      print('result =$result');
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //    backgroundColor: Colors.white,
          title: Text(
            'แชท',
            //   style: TextStyle(color: Colors.black38),
          ),
        ),
        body: StreamBuilder(
          stream: _stream(),
          builder: (context, snap) {
            // print(snap.hasData);
            if (snap.hasData) {
              // print(snap.data);
              var temp = snap.data as Future<List<dynamic>>;
              return FutureBuilder(
                future: temp,
                builder: (context, snap) {
                  List<dynamic>? lst = snap.data as List?;
                  if (lst != null) {
                    return Container(
                      child: ListView.builder(
                        itemCount: lst.length,
                        itemBuilder: (context, index) {
                          print('99999999999999');
                          print(lst[index]['members_Pic'].toString());
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  '${MyConstant.domain}${lst[index]['members_Pic'].toString()}'),
                              backgroundColor: Colors.transparent,
                            ),
                            title: Text(lst[index]['members_user'].toString()),
                            subtitle:
                                Text(lst[index]['members_phone'].toString()),
                            // onTap: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => ShowChatFromList(
                            //                 chatModel: ChatModel(
                            //                   lst[index]['id'].toString(),
                            //                   lst[index]['storeName']
                            //                       .toString(),
                            //                   lst[index]['cusName'].toString(),
                            //                   lst[index]['customerPic']
                            //                       .toString(),
                            //                   lst[index]['storePic'].toString(),
                            //                   lst[index]['store_id'].toString(),
                            //                   lst[index]['customer_id']
                            //                       .toString(),
                            //                   lst[index]['store_username']
                            //                       .toString(),
                            //                   lst[index]['customer_username']
                            //                       .toString(),
                            //                   lst[index]['customer_toen']
                            //                       .toString(),
                            //                   lst[index]['store_token']
                            //                       .toString(),
                            //                   lst[index]['customerTel']
                            //                       .toString(),
                            //                   lst[index]['storeTel'].toString(),
                            //                 ),
                            //               )));
                            //   print(
                            //       "*************************************************${lst[index]['store_username']}");
                            // },
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'ยังไม่มีข้อความ',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.black38),
                          )
                        ],
                      ),
                    );
                  }
                },
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
