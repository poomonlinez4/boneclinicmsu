import 'dart:ffi';

import 'package:boneclinicmsu/bodys/tabbarPage/Tab1.dart';
import 'package:boneclinicmsu/bodys/tabbarPage/Tab2.dart';
import 'package:boneclinicmsu/bodys/tabbarPage/show_list_buyCourse.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:flutter/material.dart';

class ShowToggleBar extends StatefulWidget {
  const ShowToggleBar({Key? key}) : super(key: key);

  @override
  State<ShowToggleBar> createState() => _ShowToggleBarState();
}

class _ShowToggleBarState extends State<ShowToggleBar>
    // List<String> labels = ['การนัดหมาย', 'ประวัติ', 'ใบสั่งซื้อผลิตภัณฑ์'];
    with
        SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: Text('ตารางนัดหมาย'),
        centerTitle: true,
        //   backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        //decoration: MyConstant().planBackground(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                    // height: 50,
                    width: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        //   color: Colors.redAccent.shade100,
                        color: MyConstant.primary,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: TabBar(
                            unselectedLabelColor: Colors.white,
                            labelColor: Colors.black,
                            indicatorColor: Colors.white,
                            indicatorWeight: 2,
                            indicator: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            controller: tabController,
                            tabs: [
                              Tab(
                                text: 'การนัดหมาย',
                              ),
                              Tab(
                                text: 'ประวัติคำสั่งซื้อสินค้า',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          // Tab1(),
                          ShowListBuyCourse(),
                          Tab2(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
