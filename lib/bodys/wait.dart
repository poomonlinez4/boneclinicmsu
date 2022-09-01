import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:flutter/material.dart';

class Wait extends StatefulWidget {
  const Wait({Key? key}) : super(key: key);

  @override
  State<Wait> createState() => _WaitState();
}

class _WaitState extends State<Wait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowTitle(title: 'This is Wait'),
    );
  }
}
