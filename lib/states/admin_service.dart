import 'package:boneclinicmsu/widgets/show_signout.dart';
import 'package:flutter/material.dart';

class AdminService extends StatefulWidget {
  const AdminService({Key? key}) : super(key: key);

  @override
  State<AdminService> createState() => _AdminServiceState();
}

class _AdminServiceState extends State<AdminService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bone Climic (Admin)'),
      ),
      drawer: Drawer(
        child: ShowSignOut(),
      ),
    );
  }
}
