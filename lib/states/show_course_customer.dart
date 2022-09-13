import 'package:flutter/material.dart';

class ShowCourse extends StatefulWidget {
  const ShowCourse({Key? key}) : super(key: key);

  @override
  State<ShowCourse> createState() => _ShowCourseState();
}

class _ShowCourseState extends State<ShowCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Text('This is Show Course'),
    );
  }
}
