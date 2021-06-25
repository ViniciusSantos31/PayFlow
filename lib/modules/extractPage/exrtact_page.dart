import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/boletoInfo/boletoInfo_widget.dart';
import 'package:payflow/shared/widgets/boletoList/boletoList_controller.dart';
import 'package:payflow/shared/widgets/boletoList/boletoList_widget.dart';

class MeusExtratosPage extends StatefulWidget {
  const MeusExtratosPage({Key? key}) : super(key: key);

  @override
  _MeusExtratosPageState createState() => _MeusExtratosPageState();
}

class _MeusExtratosPageState extends State<MeusExtratosPage> {
  final controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Stack(
          //   children: [
          //     Container(
          //       height: 50,
          //       color: AppColors.primary,
          //       width: double.maxFinite,
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 24),
          //       child: ValueListenableBuilder<List<BoletoModel>>(
          //         valueListenable: controller.boletosNotifier,
          //         builder: (_, boletos, __) => BoletoInfoWidget(
          //           size: boletos.length,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Row(
              children: [
                Text(
                  "Meu extrato",
                  style: TextStyles.titleBoldHeading,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Divider(
              color: AppColors.stroke,
              thickness: 1,
              height: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BoletoListWidget(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
