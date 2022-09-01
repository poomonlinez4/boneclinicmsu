import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:flutter/material.dart';

class Approve extends StatefulWidget {
  const Approve({Key? key}) : super(key: key);

  @override
  State<Approve> createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowTitle(title: 'This is Approve'),
    );
  }
}
