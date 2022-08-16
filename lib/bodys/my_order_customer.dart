import 'package:flutter/material.dart';

class MyOrderCustomer extends StatefulWidget {
  const MyOrderCustomer({Key? key}) : super(key: key);

  @override
  State<MyOrderCustomer> createState() => _MyOrderCustomerState();
}

class _MyOrderCustomerState extends State<MyOrderCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('My Order'),
    );
  }
}
