import 'package:flutter/material.dart';

class MenuBottomBar extends StatelessWidget {
  const MenuBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(),
    );
  }
}

class BottomNavigationBar1 extends StatelessWidget {
  const BottomNavigationBar1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xffba6b6c), Color(0xffef9a9a)])),
      child: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: SizedBox(
          height: 56,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon],
            ),
          ),
        ),
      ),
    );
  }
}
