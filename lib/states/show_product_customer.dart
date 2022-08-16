import 'package:flutter/material.dart';

class ShowProductCustomer extends StatefulWidget {
  const ShowProductCustomer({Key? key}) : super(key: key);

  @override
  State<ShowProductCustomer> createState() => _ShowProductCustomerState();
}

class _ShowProductCustomerState extends State<ShowProductCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Text('This is ShowProduct'),
    );
  }
}
