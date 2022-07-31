import 'package:boneclinicmsu/widgets/show_signout.dart';
import 'package:flutter/material.dart';

class DoctorService extends StatefulWidget {
  const DoctorService({Key? key}) : super(key: key);

  @override
  State<DoctorService> createState() => _DoctorServiceState();
}

class _DoctorServiceState extends State<DoctorService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bone Clinic (Doctor) '),
      ),
      drawer: Drawer(
        child: ShowSignOut(),
      ),
    );
  }
}
