import 'package:boneclinicmsu/unility/my_constant.dart';
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
      body: Text('This is Show TableDoctor'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.dark,
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeAddTableDateTime),
        child: Text('Add'),
      ),
    );
  }
}
