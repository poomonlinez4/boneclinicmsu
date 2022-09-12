import 'package:boneclinicmsu/models/wallet_model.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_list_wallet.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:flutter/material.dart';

class Approve extends StatefulWidget {
  final List<WalletModel> walletModels;

  const Approve({Key? key, required this.walletModels}) : super(key: key);

  @override
  State<Approve> createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
  List<WalletModel>? approveWalletModels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    approveWalletModels = widget.walletModels;
    print('approve lost ==>> ${approveWalletModels!.length} ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('สถานะ : อนุมัติเเล้ว'),
          backgroundColor: Color.fromARGB(255, 2, 134, 20)),
      body: approveWalletModels?.isEmpty ?? true
          ? ShowTitle(
              title: 'No Meney Approve',
              textStyle: MyConstant().h1style(),
            )
          : ShowListWallet(
              walletModels: approveWalletModels,
            ),
    );
  }
}
