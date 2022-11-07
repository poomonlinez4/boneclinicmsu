import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:flutter/material.dart';

class ShowTableDoctor extends StatefulWidget {
  const ShowTableDoctor({Key? key}) : super(key: key);

  @override
  State<ShowTableDoctor> createState() => _ShowTableDoctorState();
}

class _ShowTableDoctorState extends State<ShowTableDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ShowTitle(
                    title: 'ตารางทำงานหมอ',
                    textStyle: MyConstant().h1style(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                width: 400,
                child: ShowImage(
                  path: MyConstant.tb_doctor,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.dark,
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeAddTableDateTime),
        child: Text('Edit'),
      ),
    );
  }
}
