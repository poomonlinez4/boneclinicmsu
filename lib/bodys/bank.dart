import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Bank extends StatefulWidget {
  const Bank({Key? key}) : super(key: key);

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [buildTitle(), buildSCBbank(), builKrungthaibank()],
      ),
    );
  }

  Widget buildSCBbank() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      height: 120,
      child: Center(
        child: Card(
          color: Colors.purple.shade900,
          child: ListTile(
            leading: Container(
              width: 100,
              height: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('images/SCB.jpg'),
              ),
            ),
            title: ShowTitle(
              title: 'ธนาคารไทยพาณิชย์ ',
              textStyle: MyConstant().h2style(),
            ),
            subtitle: ShowTitle(
                title: 'เลขบัญชี : 9352325671  ชื่อ :นายธวัชชัย แข่งขัน ',
                textStyle: MyConstant().h3Whitestyle()),
          ),
        ),
      ),
    );
  }

  Container builKrungthaibank() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      height: 100,
      child: Center(
        child: Card(
          color: Colors.blue,
          child: ListTile(
            leading: Container(
              width: 100,
              height: 100,
              // color: Color.fromARGB(255, 114, 7, 146),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset('images/krungthai-bank.svg'),
              ),
            ),
            title: ShowTitle(
              title: 'ธนาคารกรุงไทย ',
              textStyle: MyConstant().h2Whitestyle(),
            ),
            subtitle: ShowTitle(
              title: 'เลขบัญชี : 1422xx56xx   ชื่อ :นายธวัชชัย แข่งขัน ',
              textStyle: MyConstant().h3Whitestyle(),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowTitle(
          title: 'การโอนเงินเข้าสู่บัญชึธนาคาร',
          textStyle: MyConstant().h1style()),
    );
  }
}
