import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:flutter/material.dart';

class ShowProductAdmin extends StatefulWidget {
  const ShowProductAdmin({Key? key}) : super(key: key);

  @override
  State<ShowProductAdmin> createState() => _ShowProductAdminState();
}

class _ShowProductAdminState extends State<ShowProductAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is Show Product'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.dark,
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeAddProduct),
        child: Text('Add'),
      ),
    );
  }
}
