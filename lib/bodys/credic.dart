import 'dart:convert';

import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/unility/my_dialod.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:omise_flutter/omise_flutter.dart';

import 'package:http/http.dart' as http;

class Credic extends StatefulWidget {
  const Credic({Key? key}) : super(key: key);

  @override
  State<Credic> createState() => _CredicState();
}

class _CredicState extends State<Credic> {
  String? name,
      surname,
      idCard,
      expiryDateMouth,
      expiryDateYear,
      cvc,
      amount,
      expriyDateStr;
  MaskTextInputFormatter idCardMask =
      MaskTextInputFormatter(mask: '#### - #### - #### - ####');
  MaskTextInputFormatter expiryDateMask =
      MaskTextInputFormatter(mask: '## / ####');
  MaskTextInputFormatter cvcMask = MaskTextInputFormatter(mask: '###');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitle('ชื่อ - นามสกุล '),
                    buildNameSurname(),
                    buildTitle('ID Card'),
                    formIDcard(),
                    buildExpiryCvc(),
                    buildTitle('Amount : '),
                    formAmount(),
                    // Spacer(),
                    buttonAddMoney(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buttonAddMoney() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (() {
          if (formKey.currentState!.validate()) {
            getTokenAndChargeOmise();
          }
        }),
        child: Text('Add Money'),
      ),
    );
  }

  Future<void> getTokenAndChargeOmise() async {
    String publicKey = MyConstant.publicKey;

    print(
        'publicKey = $publicKey, idCard ==>> $idCard, expiryDateStr = $expriyDateStr, expiryDateMouth ==>> $expiryDateMouth , expiryDateYear ==>> $expiryDateYear, cvc ==>> $cvc');

    OmiseFlutter omiseFlutter = OmiseFlutter(publicKey);
    await omiseFlutter.token
        .create(
            '$name $surname', idCard!, expiryDateMouth!, expiryDateYear!, cvc!)
        .then((value) async {
      String token = value.id.toString();
      print('token ==>> $token');

      String secreKey = MyConstant.secreKey;
      String urlAPI = 'https://api.omise.co/charges';
      String basicAuth = 'Basic ' + base64Encode(utf8.encode(secreKey + ":"));

      Map<String, String> headerMap = {};
      headerMap['authorization'] = basicAuth;
      headerMap['Cache-Control'] = 'no-cache';
      headerMap['Content-Type'] = 'application/x-www-form-urlencoded';

      String zero = '00';
      amount = '$amount$zero';
      print('### ==>>$amount');

      Map<String, dynamic> data = {};
      data['amount'] = amount;
      data['currency'] = 'thb';
      data['card'] = token;

      Uri uri = Uri.parse(urlAPI);

      http.Response response =
          await http.post(uri, headers: headerMap, body: data);

      var resultCharge = json.decode(response.body);

      // print('resultCharge = $resultCharge');
      print('status ของการตัดบัตร -->>> ${resultCharge['status']}');
    }).catchError((value) {
      String title = value.code;
      String message = value.message;
      MyDialog().normalDialog(context, title, message);
    });
  }

  Container buildExpiryCvc() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          buildSizebox(30),
          Expanded(
            child: Column(
              children: [
                buildTitle('Expiry Date :'),
                formExpiryDate(),
              ],
            ),
          ),
          buildSizebox(8),
          Expanded(
            child: Column(
              children: [
                buildTitle('CVC :'),
                formCVC(),
              ],
            ),
          ),
          buildSizebox(30),
        ],
      ),
    );
  }

  Container buildNameSurname() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          buildSizebox(30),
          formName(),
          buildSizebox(10),
          formSurName(),
          buildSizebox(30),
        ],
      ),
    );
  }

  SizedBox buildSizebox(double width) {
    return SizedBox(
      width: width,
    );
  }

  Widget formName() {
    return Expanded(
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill Name in Blank';
          } else {
            name = value.trim();
            return null;
          }
        },
        decoration: InputDecoration(
          label: ShowTitle(title: 'Name : '),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }

  Widget formSurName() {
    return Expanded(
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill Surname in Blank';
          } else {
            surname = value.trim();
            return null;
          }
        },
        decoration: InputDecoration(
            label: ShowTitle(title: 'Surname : '),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
      ),
    );
  }

  Widget formIDcard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill ID Card in Blank';
          } else {
            if (idCard!.length != 16) {
              return 'ID Card ต้องมี 16 ตัว อักษร';
            } else {
              return null;
            }
          }
        },
        inputFormatters: [idCardMask],
        onChanged: (value) {
          //  idCard = value.trim();
          idCard = idCardMask.getUnmaskedText();
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'xxxx-xxxx-xxxx-xxxx',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }

  Widget formExpiryDate() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Fill Expiry Date in Blank';
        } else {
          if (expriyDateStr!.length != 6) {
            return 'กรุณากรอก ให้ครบ';
          } else {
            expiryDateMouth = expriyDateStr!.substring(0, 2);
            expiryDateYear = expriyDateStr!.substring(2, 6);

            int expiryDateMouthInt = int.parse(expiryDateMouth!);
            expiryDateMouth = expiryDateMouthInt.toString();

            if (expiryDateMouthInt > 12) {
              return 'เดือนไม่ควรเกิน 12';
            } else {
              return null;
            }
          }
        }
      },
      onChanged: (value) {
        expriyDateStr = expiryDateMask.getUnmaskedText();
      },
      inputFormatters: [expiryDateMask],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'xx/xxxx',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }

  Widget formCVC() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Fill CVC in Blank';
        } else {
          if (expriyDateStr!.length == 3) {
            return 'CVC ต้องมี 3 ตัว';
          } else {
            return null;
          }
        }
      },
      onChanged: (value) {
        cvc = cvcMask.getUnmaskedText();
      },
      inputFormatters: [cvcMask],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'xxx',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }

  Widget formAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill Amount in Blank';
          } else {
            amount = value.trim();
            return null;
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          suffix: ShowTitle(
            title: 'THB.',
            textStyle: MyConstant().h2RedStyle(),
          ),
          label: ShowTitle(title: 'Amount : '),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2style(),
      ),
    );
  }
}
