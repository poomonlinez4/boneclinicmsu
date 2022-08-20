import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/unility/my_dialod.dart';
import 'package:boneclinicmsu/widgets/show_progress.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Prompay extends StatefulWidget {
  const Prompay({Key? key}) : super(key: key);

  @override
  State<Prompay> createState() => _PrompayState();
}

class _PrompayState extends State<Prompay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildTitle(),
            buildCopyPrompay(),
            buildQRcodePrompay(),
            buildDownload()
          ],
        ),
      ),
    );
  }

  ElevatedButton buildDownload() => ElevatedButton(
        onPressed: () async {
          String path = '/sdcard/download';
          try {
            await FileUtils.mkdir([path]);
            await Dio()
                .download(MyConstant.urlPrompay, '$path/prompay.png')
                .then((value) => MyDialog().normalDialog(
                    context,
                    'Download สำเร็จ',
                    'กรุณาไปที่แอป ธนาคารเพื่ออ่าน QR code ที่โหลดมา'));
          } catch (e) {
            print('## error ==>> ${e.toString()}');
            MyDialog().normalDialog(context, 'Storage Permission Denied',
                'กรุณาเปิด Permission Storage ');
          }
        },
        child: Text('Dowload QRcode'),
      );

  Container buildQRcodePrompay() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: CachedNetworkImage(
          imageUrl: MyConstant.urlPrompay,
          placeholder: (context, url) => showProgress(),
        ));
  }

  Widget buildCopyPrompay() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        color: MyConstant.light,
        child: ListTile(
          title: ShowTitle(
            title: '0922698037',
            textStyle: MyConstant().h1style(),
          ),
          subtitle: ShowTitle(title: 'บัญชี Prompay'),
          trailing: IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: '0922698037'));
                MyDialog().normalDialog(context, 'Copy สำเร็จ',
                    ' กณุณาไปที่ แอปธนาคารของ ท่าน เพื่อโอนเงินผ่าน Prompay ได้เลย');
              },
              icon: Icon(
                Icons.copy,
                color: MyConstant.dark,
              )),
        ),
      ),
    );
  }

  ShowTitle buildTitle() {
    return ShowTitle(
        title: 'การโอนเงินโดยใช้ Prompay', textStyle: MyConstant().h2style());
  }
}
