import 'package:boneclinicmsu/models/wallet_model.dart';
import 'package:boneclinicmsu/unility/my_constant.dart';
import 'package:boneclinicmsu/widgets/show_image.dart';
import 'package:boneclinicmsu/widgets/show_progress.dart';
import 'package:boneclinicmsu/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowListWallet extends StatelessWidget {
  const ShowListWallet({
    Key? key,
    required this.walletModels,
  }) : super(key: key);

  final List<WalletModel>? walletModels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: walletModels!.length,
      itemBuilder: (context, index) => Card(
        // color: index % 2 == 0
        //     ? MyConstant.light.withOpacity(0.7)
        //     : Colors.white,
        color: MyConstant.light.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShowTitle(
                    title: walletModels![index].money,
                    textStyle: MyConstant().h1style(),
                  ),
                  Container(
                    width: 150,
                    height: 170,
                    child: CachedNetworkImage(
                        placeholder: (context, url) => showProgress(),
                        errorWidget: (context, url, error) =>
                            ShowImage(path: 'images/bill.png'),
                        imageUrl:
                            '${MyConstant.domain}/boneclinic${walletModels![index].pathSlip}'),
                  )
                ],
              ),
              ShowTitle(
                title: walletModels![index].datePay,
                textStyle: MyConstant().h2BlueStyle(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
