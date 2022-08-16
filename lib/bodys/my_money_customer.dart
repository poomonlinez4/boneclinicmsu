import 'package:flutter/material.dart';

class MyMoneyCustomer extends StatefulWidget {
  const MyMoneyCustomer({Key? key}) : super(key: key);

  @override
  State<MyMoneyCustomer> createState() => _MyMoneyCustomerState();
}

class _MyMoneyCustomerState extends State<MyMoneyCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('My Money'),
    );
  }
}
