import 'package:boneclinicmsu/models/wallet_model.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_list_wallet.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:flutter/material.dart';

class Wait extends StatefulWidget {
  final List<WalletModel> walletModels;
  const Wait({Key? key, required this.walletModels}) : super(key: key);

  @override
  State<Wait> createState() => _WaitState();
}

class _WaitState extends State<Wait> {
  List<WalletModel>? waitWalletModels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitWalletModels = widget.walletModels;
    print('waitList ==> ${waitWalletModels!.length} ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สถานะ : รอดำเนินการ'),
        backgroundColor: Colors.red,
      ),
      body: waitWalletModels?.isEmpty ?? true
          ? ShowTitle(
              title: 'No Wait Wallet',
              textStyle: MyConstant().h1Redstyle(),
            )
          : ShowListWallet(walletModels: waitWalletModels),
    );
  }
}
