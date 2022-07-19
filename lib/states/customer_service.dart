import 'package:flutter/material.dart';

class CustomerService extends StatefulWidget {
  const CustomerService({Key? key}) : super(key: key);

  @override
  State<CustomerService> createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bone Clinic'),
        ),
        drawer: Drawer(
          child: ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('data'),
          ),
        ));
  }
}
